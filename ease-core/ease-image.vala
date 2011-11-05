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

public class Ease.Image : GLib.Object
{
	/**
	 * The image's filename, relative to the {@link Document}'s path.
	 */
	internal string filename { get; set; }
	
	/**
	 * The original path to the background image. This path is used in the UI.
	 */
	internal string source { get; set; }
	
	/**
	 * The fill mode of this image.
	 */
	internal ImageFillType fill { get; set; default = ImageFillType.STRETCH; }
	
	/**
	 * The width of the image. This is used internally and is not always valid.
	 */
	private int img_width;
	 
	/**
	 * The height of the image. This is used internally and is not always valid.
	 */
	private int img_height;
	
	/**
	 * Invalidate the cache when the background image changes.
	 */
	construct
	{
		notify["filename"].connect(() => small_cache = null );
	}
	
	/**
	 * Sets up a CairoContext to render this image.
	 *
	 * @param cr The context to set up.
	 * @param width The width of the rendering.
	 * @param height The height of the rendering.
	 * @param path The base path to any possible media files.
	 * @param use_small Whether or not to use the small cached version of the
     * image instead of loading a full sized version.
	 */
	public void set_cairo(Cairo.Context cr, int width, int height, string path,
	                      bool use_small)
	{
		// TODO: clean this method up, it's bad but it works
		try
		{
			// build the full path to the image
			string full = Path.build_filename(path, filename);
			
			// if the small cache isn't loaded, load it
			if (use_small && small_cache == null)
			{
				// load the image at full size to get its width and height
				var pixbuf = new Gdk.Pixbuf.from_file(full);
				img_width = pixbuf.width;
				img_height = pixbuf.height;
				
				// store the image as a small cached version
				var h = (int)((float)pixbuf.height / pixbuf.width * CACHE_SIZE);
				small_cache = pixbuf.scale_simple(CACHE_SIZE, h,
				                                  Gdk.InterpType.BILINEAR); 
			}
			
			// use more efficient/low quality interpolation for small previews
			var interpolation = use_small
			                  ? Gdk.InterpType.NEAREST
			                  : Gdk.InterpType.BILINEAR;
			
			// which sized image should be used?
			Gdk.Pixbuf pixbuf;
			if (use_small) pixbuf = small_cache;
			else pixbuf = new Gdk.Pixbuf.from_file(full);
			
			// set up the cairo context appropriately for the fill type
			switch (fill)
			{
				case ImageFillType.STRETCH:		
					Gdk.cairo_set_source_pixbuf(
						cr,
						pixbuf.scale_simple(width, height, interpolation),
						0, 0);
					break;

				case ImageFillType.ASPECT:
					// get the aspect ratio of the image
					var img_aspect = ((float)pixbuf.width) / pixbuf.height;
					var ctx_aspect = ((float)width) / height;
					
					// determine the width and height of pixbuf
					int px_width, px_height, px_x, px_y;
					if (ctx_aspect < img_aspect)
					{
						px_width = (int)(height * (img_aspect));
						px_height = height;
						px_x = (width - px_width) / 2;
						px_y = 0;
					}
					else
					{
						px_width = width;
						px_height = (int)(width * (1 / img_aspect));
						px_x = 0;
						px_y = (height - px_height) / 2;
					}
					
					// scale and set source
					Gdk.cairo_set_source_pixbuf(
						cr,
						pixbuf.scale_simple(px_width, px_height, interpolation),
						px_x, px_y);
					break;
				
				case ImageFillType.ORIGINAL:
					if (use_small)
					{
						pixbuf = small_cache.scale_simple(img_width, img_height,
						                                  interpolation);
					}
					Gdk.cairo_set_source_pixbuf(cr, pixbuf,
					                            (width - img_width) / 2,
					                            (height - img_height) / 2);
					break;
			}
			
		}
		catch (Error e)
		{
			critical("Error rendering image background: %s", e.message);
		}
	}
	
	/**
	 * The size of the small copy of the image kept loaded at all times.
	 */
	private const int CACHE_SIZE = 100;
	
	/**
	 * A small copy of the image that is kept loaded at all times. This image
	 * is used in the sidebar to keep rendering times fast. Because the sidebar
	 * uses Cairo rendering, the entire slide is redrawn when anything is
	 * changed. The process of loading and rendering large images is slow, so
	 * this made simple tasks such as dragging an image around slow on slides
	 * with image backgrounds.
	 *
	 * As the small cache is used only for Cairo rendering and requires
	 * knowledge of the image's Document's extracted path, it is set manually
	 * in the {@link set_cairo} method.
	 */
	private Gdk.Pixbuf small_cache;
}

internal enum Ease.ImageFillType
{
	STRETCH,
	ASPECT,
	ORIGINAL;
	
	/**
	 * Returns a string representation of this ImageFillType.
	 */
	public string to_string()
	{
		switch (this)
		{
			case STRETCH: return Theme.IMAGE_STRETCH;
			case ASPECT: return Theme.IMAGE_ASPECT;
			case ORIGINAL: return Theme.IMAGE_ORIGINAL;
		}
		return "undefined";
	}
	
	/**
	 * Creates a ImageFillType from a string representation.
	 */
	public static ImageFillType from_string(string str)
	{
		switch (str)
		{
			case Theme.IMAGE_STRETCH: return STRETCH;
			case Theme.IMAGE_ASPECT: return ASPECT;
			case Theme.IMAGE_ORIGINAL: return ORIGINAL;
		}
		
		warning("%s is not an image fill type", str);
		return STRETCH;
	}
	
	/**
	 * Returns a string description of the ImageFillType
	 */
	public string description()
	{
		switch (this)
		{
			case STRETCH: return _("Stretch");
			case ASPECT: return _("Maintain Aspect Ratio");
			case ORIGINAL: return _("Do not Scale");
		}
		return "undefined";
	}
	
	/**
	 * Creates a ListStore with the first column set as the description
	 * and the second column set as the ImageFillType.
	 */
	public static Gtk.ListStore list_store()
	{
		var store = new Gtk.ListStore(2, typeof(string), typeof(ImageFillType));
		Gtk.TreeIter itr;
		
		store.append(out itr);
		store.set(itr, 0, STRETCH.description(), 1, STRETCH);
		store.append(out itr);
		store.set(itr, 0, ASPECT.description(), 1, ASPECT);
		store.append(out itr);
		store.set(itr, 0, ORIGINAL.description(), 1, ORIGINAL);
		
		return store;
	}
}

