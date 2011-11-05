/*  Ease, a GTK presentation application
    Copyright (C) 2010 Nate Stedman

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
 * Base class for an "import media" dialog that searches a website for media.
 *
 * PluginImportDialog offers a generic interface and almost entirely controls
 * the user interface for the dialog. Therefore, by using PluginImportDialog
 * to write a plugin, the author ensures that it fits in with all similar
 * plugins. PluginImportDialog also automatically manages the downloading
 * of images and image data - subclasses only need to provide a REST call,
 * and parse the response to generate a list of data.
 */
public abstract class Ease.Plugin.ImportService : GLib.Object
{
	/**
	 * REST Proxy for retrieving image data.
	 */
	private Rest.Proxy proxy;
	
	/**
	 * REST Call for retrieving image data.
	 */
	private Rest.ProxyCall call;
	
	/**
	 * ListStore for the icon view.
	 */
	internal Gtk.ListStore model;
	
	/**
	 * The size of the list to download.
	 */
	private float list_size;
	
	/**
	 * Emitted when the search begins.
	 */
	public signal void started();
	
	/**
	 * Emitted when the search completes.
	 */
	public signal void proxy_call_complete();
	
	/**
	 * Emitted if no results are found. This signal is the alterative to
	 * {@link loading_started}.
	 */
	public signal void no_results();
	
	/**
	 * Emitted when image previews begin downloading. This signal is the
	 * alternative to {@link no_results}.
	 */
	public signal Gtk.IconView loading_started();
	
	/**
	 * Emitted when progress is made in loading the image previews.
	 *
	 * @param progress The current progress.
	 */
	public signal void loading_progress(double progress);
	
	/**
	 * Emitted when the loading of image previews is complete.
	 */
	public signal void loading_complete();
	
	/**
	 * Stores the images to download. As each image is downloaded, it is
	 * removed from the list.
	 */
	private Gee.LinkedList<ImportMedia?> images_list;

	/**
	 * Subclasses must override this function to parse the data returned from
	 * their Rest.ProxyCall.
	 *
	 * This method should construct images_list, a Gee.LinkedList of
	 * {@link ImportMedia}s (or a subclass specific to your plugin).
	 * ImportService will then automatically download the images.
	 *
	 * @param data The data returned from the REST call.
	 */
	public abstract void parse_data(string data);
	
	/**
	 * Allows subclasses to provide a Rest.Proxy for their website.
	 */
	public abstract Rest.Proxy create_proxy();
	
	/**
	 * Allows subclasses to provide a Rest.ProxyCall for their website.
	 *
	 * @param proxy The proxy that the subclass created.
	 * @param search The search string provided by the user.
	 */
	public abstract Rest.ProxyCall create_call(Rest.Proxy proxy, string search);
	
	/**
	 * Adds an {@link ImportMedia} to the downloads list.
	 */
	public void add_media(ImportMedia media)
	{
		images_list.add(media);
	}
	
	/**
	 * Runs a search with this service.
	 *
	 * @param search The search string to use.
	 */
	public void run(string search)
	{
		// create the rest proxy call
		proxy = create_proxy();
		call = create_call(proxy, search);
		
		started();
		
		// run the call
		try { call.run_async(on_call_finish, this); }
		catch (Error e) { critical(e.message); }
	}
	
	/**
	 * This virtual function should be overridden by services that require
	 * more advanced control than a simple string search.
	 *
	 * For example, it can be used to select different types of Creative
	 * Commons licenses. By default, it returns null.
	 *
	 * In order to properly fit into Ease's current search window layout, 
	 * this should be a relatively short and narrow widget. One or two
	 * checkboxes is ideal, any more will take up too much space (consider a
	 * popup window if more space is required).
	 */
	public virtual Gtk.Widget? extra_widget()
	{
		return null;
	}
	
	/**
	 * Signal handler for Rest.ProxyCall completion.
	 *
	 * @param call The completed Rest.ProxyCall.
	 */
	private void on_call_finish(Rest.ProxyCall call)
	{
		proxy_call_complete();
		
		// create list
		images_list = new Gee.LinkedList<ImportMedia?>();
		
		// parse the image data (done by subclasses)
		parse_data(call.get_payload());
		
		// remember the list size for the widget.progress bar
		list_size = images_list.size;
		
		if (list_size > 0)
		{
			// create model
			model = new Gtk.ListStore(3, typeof(Gdk.Pixbuf), typeof(string),
			                             typeof(ImportMedia));
			
			// set icons
			var icons = loading_started();
			icons.set_model(model);
			icons.text_column = Column.TEXT;
			icons.pixbuf_column = Column.PIXBUF;
		
			// if threads are supported, get the pixbufs in a thread
			if (Thread.supported())
			{
				try { Thread.create(threaded_get_pixbufs, false); }
				catch { threaded_get_pixbufs(); }
			}
			else
			{
				threaded_get_pixbufs();
			}
		}
		else
		{
			no_results();
		}
	}
	
	/**
	 * Retrieves the first pixbuf in "images_list", then calls itself again if
	 * there are more images.
	 *
	 * As its name implies, threaded_get_pixbufs should be used in a thread,
	 * because getting images from the web can be slow. While it will work
	 * when not run in a thread (if, for example, threads are not supported),
	 * this will lock up the user interface and be a bad experience for the
	 * user.
	 */
	private void* threaded_get_pixbufs()
	{
		// get the next image
		ImportMedia image;
		lock (images_list) { image = images_list.poll_head(); }
		
		// get the pixbuf for this image
		var pixbuf = gdk_pixbuf_from_uri(image.thumb_link == null ?
		                                 image.file_link : 
		                                 image.thumb_link);
		// append to the model
		var tree_itr = Gtk.TreeIter();
		lock (model)
		{
			model.append(out tree_itr);
			model.set(tree_itr, Column.PIXBUF, pixbuf,
				                Column.TEXT, image.title,
				                Column.IMPORT_MEDIA, image);
		}
		
		// set the widget.progress bar
		loading_progress(1 - (images_list.size / list_size));
			
		// continue if there are more images
		lock (images_list)
		{
			if (images_list.size > 0) threaded_get_pixbufs();
		}
			
		// otherwise, remove the widget.progress bar and return
		loading_complete();
		return null;
	}
	
	/**
	 * Loads and returns a pixbuf from a URI. Best used threaded, to prevent 
	 * lock up.
	 *
	 * @param uri The URI to load from.
	 */
	private Gdk.Pixbuf? gdk_pixbuf_from_uri(string uri)
	{
		File file = File.new_for_uri(uri);
		FileInputStream filestream;
		try { filestream = file.read(null); }
		catch (Error e)
		{
			filestream = null;
			critical("Couldn't read distant file : %s", e.message);
		}
		assert(filestream != null);
		Gdk.Pixbuf pix;
		try
		{
			pix = new Gdk.Pixbuf.from_stream_at_scale(filestream,
			                                          200, 200,
			                                          true, null);
		}
		catch (Error e)
		{
			critical("Couldn't create pixbuf from file: %s", e.message);
			pix = null;
		}
		return pix;
	}
	
	/**
	 * Enumerator for columns in the "model" ListStore.
	 */
	public enum Column
	{
		/**
		 * The column storing Gdk.Pixbufs, downloaded from the internet.
		 * Note that these pixbufs are often only the thumbnails, and thus
		 * should not be inserted (go fetch the real picture).
		 */
		PIXBUF = 0,
		
		/**
		 * The column for the label displayed in the Gtk.IconView.
		 */
		TEXT = 1,
		
		/**
		 * Stores the ImportMedia associated with the image.
		 */
		IMPORT_MEDIA = 2
	}
}

