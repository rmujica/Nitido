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
 * Background abstraction, supporting {@link Color}, {@link Gradient}, and
 * images. For controlling a Background, see {@link BackgroundWidget}.
 */
public class Ease.Background : GLib.Object
{
	/**
	 * The background background_type of this element.
	 */
	internal BackgroundType background_type { get; set; }
	
	/**
	 * The background color, if this element uses a solid color for a
	 * background.
	 *
	 * To use this property, {@link background_type} must also be set to
	 * {@link BackgroundType.COLOR}.
	 */
	internal Color color { get; set; default = Color.black; }
	
	/**
	 * The background gradient, if this slide uses a gradient for a background.
	 *
	 * To use this property, {@link background_type} must also be set to
	 * {@link BackgroundType.GRADIENT}.
	 */
	internal Gradient gradient { get; set;
	                             default = Gradient.default_background; }
	
	/**
	 * The background image, if this slide uses an image for a background.
	 *
	 * To use this property, {@link background_type} must also be set to
	 * {@link BackgroundType.IMAGE}.
	 */
	internal Image image { get; set; default = new Image(); }
	
	/**
	 * Emitted when an image file is added to this background.
	 */
	internal signal void image_added(string image_path);
	
	/**
	 * Creates a new Background.
	 */
	public Background() { }
	
	/**
	 * Returns the default gradient background.
	 */
	public Background.default_gradient()
	{
		color = Color.white;
		gradient = Gradient.default_background;
		background_type = BackgroundType.GRADIENT;
	}
	
	/**
	 * Returns a white background.
	 */
	public Background.white()
	{
		color = Color.white;
		gradient = Gradient.default_background;
		background_type = BackgroundType.COLOR;
	}
	
	/**
	 * Creates a background from a JSON object.
	 */
	public Background.from_json(Json.Object obj)
	{
		if (obj.has_member(Theme.BACKGROUND_IMAGE))
		{
			image.filename = obj.get_string_member(Theme.BACKGROUND_IMAGE);
			image.source =
				obj.get_string_member(Theme.BACKGROUND_IMAGE_SOURCE);
			image.fill = ImageFillType.from_string(
				obj.get_string_member(Theme.BACKGROUND_IMAGE_FILL));
		}
		if (obj.has_member(Theme.BACKGROUND_COLOR))
		{
			color = new Color.from_string(
				obj.get_string_member(Theme.BACKGROUND_COLOR));
		}
		if (obj.has_member(Theme.BACKGROUND_GRADIENT))
		{
			gradient = new Gradient.from_string(
				obj.get_string_member(Theme.BACKGROUND_GRADIENT));
		}
		background_type = BackgroundType.from_string(
			obj.get_string_member(Theme.BACKGROUND_TYPE));
	}
	
	/**
	 * Writes this background's properties to the given JSON object.
	 */
	public Json.Object to_json()
	{
		var obj = new Json.Object();
	
		if (image != null)
		{
			obj.set_string_member(Theme.BACKGROUND_IMAGE, image.filename);
			obj.set_string_member(Theme.BACKGROUND_IMAGE_FILL,
			                      image.fill.to_string());
			obj.set_string_member(Theme.BACKGROUND_IMAGE_SOURCE,
			                      image.source);
		}
		if (color != null)
		{
			obj.set_string_member(Theme.BACKGROUND_COLOR, color.to_string());
		}
		if (gradient!= null)
		{
			obj.set_string_member(Theme.BACKGROUND_GRADIENT,
			                      gradient.to_string());
		}
		obj.set_string_member(Theme.BACKGROUND_TYPE,
		                      background_type.to_string());
		return obj;
	}
	
	/**
	 * Sets up a CairoContext to render this background.
	 *
	 * @param cr The context to set up.
	 * @param width The width of the rendering.
	 * @param height The height of the rendering.
	 * @param path The base path to any possible media files.
	 */
	public void set_cairo(Cairo.Context cr, int width, int height, string path)
	{
		switch (background_type)
		{
			case BackgroundType.COLOR:
				color.set_cairo(cr);
				break;
			case BackgroundType.GRADIENT:
				gradient.set_cairo(cr, width, height);
				break;
			case BackgroundType.IMAGE:
				image.set_cairo(cr, width, height, path);
				break;
		}
	}
	
	/** 
	 * Renders this background to a Cairo context at the specified size.
	 *
	 * @param cr The Cairo.Context to draw to.
	 * @param w The width to render at.
	 * @param h The height to render at.
	 * @param path The base path to any possible media files.
	 */
	public void cairo_render(Cairo.Context cr, int width, int height,
	                         string path) throws GLib.Error
	{
		cr.save();
		set_cairo(cr, width, height, path);
		cr.rectangle(0, 0, width, height);
		cr.fill();
		cr.restore();
	}
	
	// TODO: this is a bit hacky, but it works...
	internal bool owns_undoitem(UndoItem item)
	{
		if (this in item) return true;
		if (color in item) return true;
		if (gradient.start in item) return true;
		if (gradient.end in item) return true;
		if (gradient in item) return true;
		if (image in item) return true;
		return false;
	}
}

public enum Ease.BackgroundType
{
	COLOR,
	GRADIENT,
	IMAGE;
	
	public const BackgroundType[] TYPES = { COLOR, GRADIENT, IMAGE};
	
	/**
	 * Returns a string representation of this BackgroundType.
	 */
	public string to_string()
	{
		switch (this)
		{
			case COLOR: return Theme.BACKGROUND_TYPE_COLOR;
			case GRADIENT: return Theme.BACKGROUND_TYPE_GRADIENT;
			case IMAGE: return Theme.BACKGROUND_TYPE_IMAGE;
		}
		return "undefined";
	}
	
	/**
	 * Creates a BackgroundType from a string representation.
	 */
	public static BackgroundType from_string(string str)
	{
		switch (str)
		{
			case Theme.BACKGROUND_TYPE_COLOR: return COLOR;
			case Theme.BACKGROUND_TYPE_GRADIENT: return GRADIENT;
			case Theme.BACKGROUND_TYPE_IMAGE: return IMAGE;
		}
		
		warning("%s is not a gradient type", str);
		return COLOR;
	}
	
	/**
	 * Returns a description of the BackgroundType.
	 */
	public string description()
	{
		switch (this)
		{
			case COLOR: return _("Solid Color");
			case GRADIENT: return _("Gradient");
			case IMAGE: return _("Image");
		}
		return "undefined";
	}
}

