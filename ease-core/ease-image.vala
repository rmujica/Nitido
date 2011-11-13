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
	 * Sets up a CairoContext to render this image.
	 *
	 * @param cr The context to set up.
	 * @param width The width of the rendering.
	 * @param height The height of the rendering.
	 * @param path The base path to any possible media files.
	 */
	public void set_cairo(Cairo.Context cr, int width, int height, string path)
	{
		try
		{
			string full = Path.build_filename(path, filename);
			Gdk.Pixbuf pixbuf;
			switch (fill)
			{
				case ImageFillType.STRETCH:
					pixbuf = new Gdk.Pixbuf.from_file_at_scale(full,
					                                           width,
					                                           height,
					                                           false);
					Gdk.cairo_set_source_pixbuf(cr, pixbuf, 0, 0);
					break;
				case ImageFillType.ASPECT:
					pixbuf = new Gdk.Pixbuf.from_file(full);
					
					// get the aspect ratio of both image and drawing area
					var this_aspect = (float)width / height;
					
					// set the pixbuf as source
					Gdk.Pixbuf out_pixbuf;
					if (this_aspect > 1) // set the image's height
					{
						out_pixbuf = pixbuf.scale_simple(
							width, (int)(height * this_aspect),
							Gdk.InterpType.BILINEAR);
						Gdk.cairo_set_source_pixbuf(
							cr, out_pixbuf,
					    	0,
					    	(height - out_pixbuf.height) / 2);
					}
					else // set the image's width
					{
						out_pixbuf = pixbuf.scale_simple(
							(int)(width / this_aspect), height,
							Gdk.InterpType.BILINEAR);
						Gdk.cairo_set_source_pixbuf(
							cr, out_pixbuf,
					    	(width - out_pixbuf.width) / 2,
					    	0);
					}
					break;
				case ImageFillType.ORIGINAL:
					pixbuf = new Gdk.Pixbuf.from_file(full);
					Gdk.cairo_set_source_pixbuf(cr, pixbuf,
					                            (width - pixbuf.width) / 2,
					                            (height - pixbuf.height) / 2);
					break;
			}
			
		}
		catch (Error e)
		{
			critical("Error rendering image background: %s", e.message);
		}
	}
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

