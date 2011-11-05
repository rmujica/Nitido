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

internal class Ease.ImportDialog : Gtk.Window
{
	private const string PROGRESS_FORMAT = _("Downloading image %i of %i");

	public signal void add_image(string filename);
	
	int total_images;
	
	internal ImportDialog()
	{
		title = _("Import Media");
		set_default_size(640, 480);
		
		// create the source list
		var view = new Source.View();
		var group = new Source.Group(_("Images"));
		view.add_group(group);
		view.show_all();
		
		Plugin.ImportService service = new FlickrService();
		var flickr = create_item("Flickr", "gtk-go-down", service);
		group.add_item(flickr);
		service = new OCAService();
		group.add_item(create_item("OpenClipArt", "gtk-go-down", service));
		
		add(view);
		view.show_all();
		flickr.select();
	}
	
	internal void run()
	{
		show();
	}
	
	private Source.Item create_item(string title, string stock_id,
	                                Plugin.ImportService service)
	{
		var widget = new ImportWidget(service);
		var item = new Source.SpinnerItem.from_stock_icon(title, stock_id,
		                                                  widget);
		
		widget.add_media.connect((media_list) => {
			var img = new Gtk.Image.from_stock("gtk-go-down",
			                                   Gtk.IconSize.LARGE_TOOLBAR);
			var progress = new Dialog.Progress.with_image(
				_("Downloading Media Files"), false,
				media_list.size, this, img); 
			progress.show();
			total_images = media_list.size;
			add_media_recursive(progress, media_list, Temp.request(), 0);
		});
		
		service.started.connect(() => item.start());
		service.no_results.connect(() => item.stop());
		service.loading_complete.connect(() => item.stop());
		
		return item;
	}
	
	private void add_media_recursive(Dialog.Progress progress,
	                                 Gee.Queue<Plugin.ImportMedia> media_list,
	                                 string temp, int i)
	{
		if (media_list.size == 0)
		{
			progress.destroy();
			return;
		}
		
		// set progress text
		progress.set_label(PROGRESS_FORMAT.printf(i + 1, total_images));
		
		var file = File.new_for_uri(media_list.poll().file_link);
		var copy = File.new_for_path(Path.build_filename(temp,
		                                                 "media" +
		                                                 (i++).to_string()));
		try
		{
			double previous = 0;
			file.copy_async(copy, FileCopyFlags.OVERWRITE,
			                Priority.DEFAULT, null,
			                (current, total) => {
				progress.add(((double)current - previous) / (double)total);
				previous = current;
			},
			                (sender, result) => {
				add_image(copy.get_path());
				add_media_recursive(progress, media_list, temp, i);
			});
		}
		catch (Error e)
		{
			critical("Couldn't read file: %s", e.message);
			return;
		}
	}
}
