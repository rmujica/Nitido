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
 * Gradient representation, using {@link Color}.
 */
public class Ease.Gradient : GLib.Object
{
	/**
	 * The format string for converting gradients to strings.
	 */
	private const string STR = "%s|%s|%s|%f";
	
	/**
	 * The string placed between each color in a string representation.
	 */
	private const string SPLIT = "|";	
	
	/**
	 * The starting {@link Color} of the gradient.
	 */
	public Color start { get; set; default = Color.white; }
	
	/**
	 * The ending {@link Color} of the gradient.
	 */
	public Color end { get; set; default = Color.black; }
	
	/**
	 * The {@link GradientType} of the gradient.
	 */
	public GradientType mode { get; set; default = GradientType.LINEAR; }
	
	/**
	 * The angle, in radians, of the gradient, if it is linear.
	 */
	public double angle { get; set; default = 0; }
	
	/**
	 * Returns a copy of the default background gradient.
	 */
	public static Gradient default_background
	{	
		owned get { return new Gradient(Color.black, Color.white); }
	}
	
	/**
	 * Creates a new linear gradient, with the specified colors.
	 */
	public Gradient(Color start_color, Color end_color)
	{
		start = start_color;
		end = end_color;
		mode = GradientType.LINEAR;
		angle = 0;
	}
	
	/**
	 * Creates a new mirrored linear gradient, with the specified colors.
	 */
	public Gradient.mirrored(Color start_color, Color end_color)
	{
		this(start_color, end_color);
		mode = GradientType.LINEAR_MIRRORED;
		angle = 0;
	}
	
	/**
	 * Creates a new linear gradient, with the specified colors.
	 */
	public Gradient.radial(Color start_color, Color end_color)
	{
		this(start_color, end_color);
		mode = GradientType.RADIAL;
		angle = 0;
	}
	
	/**
	 * Creates a Gradient from a string representation.
	 */
	public Gradient.from_string(string str)
	{
		var split = str.replace(" ", "").split(SPLIT);
		start = new Color.from_string(split[0]);
		end = new Color.from_string(split[1]);
		mode = GradientType.from_string(split[2]);
		angle = split[3].to_double();
	}
	
	/**
	 * Returns a string representation of this Gradient.
	 */
	public string to_string()
	{
		return STR.printf(start.to_string(), end.to_string(),
		                  mode.to_string(), angle);
	}
	
	/**
	 * Returns a copy of this Gradient.
	 */
	public Gradient copy()
	{
		var grad = new Gradient(start.copy(), end.copy());
		grad.mode = mode;
		grad.angle = angle;
		return grad;
	}
	
	/**
	 * Reverses the Gradient.
	 */
	public void flip()
	{
		var temp = end;
		end = start;
		start = temp;
	}
	
	/**
	 * Renders the gradient to the given Cairo context at the specified size.
	 *
	 * @param cr The Cairo context to render to.
	 * @param width The width of the rendered rectangle.
	 * @param height The height of the rendered rectangle.
	 */
	public void cairo_render_rect(Cairo.Context cr, int width, int height)
	{
		cr.save();
		cr.rectangle(0, 0, width, height);
		set_cairo(cr, width, height);
		cr.fill();
		cr.restore();
	}
	
	/**
	 * Sets a CairoContext's source to this gradient.
	 */
	public void set_cairo(Cairo.Context cr, int width, int height)
	{
		var x_orig = width / 2;
		var y_orig = height / 2;
		var dist_x = (int)(Math.cos(angle + Math.PI / 2) * y_orig);
		var dist_y = (int)(Math.sin(angle + Math.PI / 2) * y_orig);
		
		Cairo.Pattern pattern;
		switch (mode)
		{
			case GradientType.LINEAR:
				pattern = new Cairo.Pattern.linear(x_orig - dist_x,
				                                   y_orig - dist_y,
				                                   x_orig + dist_x,
				                                   y_orig + dist_y);
				pattern.add_color_stop_rgba(0, start.red, start.green,
						                    start.blue, start.alpha);
				pattern.add_color_stop_rgba(1, end.red, end.green,
						                    end.blue, end.alpha);
				break;
			case GradientType.LINEAR_MIRRORED:
				pattern = new Cairo.Pattern.linear(x_orig - dist_x,
				                                   y_orig - dist_y,
				                                   x_orig + dist_x,
				                                   y_orig + dist_y);
				pattern.add_color_stop_rgba(0, start.red, start.green,
						                    start.blue, start.alpha);
				pattern.add_color_stop_rgba(0.5, end.red, end.green,
						                    end.blue, end.alpha);
				pattern.add_color_stop_rgba(1, start.red, start.green,
						                    start.blue, start.alpha);
				break;
			default: // radial
				pattern = new Cairo.Pattern.radial(width / 2, height / 2, 0,
				                                   width / 2, height / 2,
				                                   width / 2);
				pattern.add_color_stop_rgba(0, start.red, start.green,
						                    start.blue, start.alpha);
				pattern.add_color_stop_rgba(1, end.red, end.green,
						                    end.blue, end.alpha);
				break;
		}
		
		cr.set_source(pattern);
	}
}

/**
 * The {@link Gradient} types provided by Ease.
 */
public enum Ease.GradientType
{
	/**
	 * A linear gradient, from top to bottom.
	 */
	LINEAR,
	
	/**
	 * A mirrored linear gradient, with the "end" color in the middle and the
	 * "start" color on both ends.
	 */
	LINEAR_MIRRORED,
	
	/**
	 * A radial gradient, with the "start" color in the center and the "end"
	 * color on the outsides.
	 */
	RADIAL;
	
	/**
	 * Returns a string representation of this GradientType.
	 */
	public string to_string()
	{
		switch (this)
		{
			case LINEAR: return Theme.GRAD_LINEAR;
			case LINEAR_MIRRORED: return Theme.GRAD_LINEAR_MIRRORED;
			case RADIAL: return Theme.GRAD_RADIAL;
		}
		return "undefined";
	}
	
	/**
	 * Creates a GradientType from a string representation.
	 */
	public static GradientType from_string(string str)
	{
		switch (str)
		{
			case Theme.GRAD_LINEAR: return LINEAR;
			case Theme.GRAD_LINEAR_MIRRORED: return LINEAR_MIRRORED;
			case Theme.GRAD_RADIAL: return RADIAL;
		}
		
		warning("%s is not a gradient type", str);
		return LINEAR;
	}
	
	/**
	 * Returns a string description of the GradientType
	 */
	public string description()
	{
		switch (this)
		{
			case LINEAR: return _("Linear");
			case LINEAR_MIRRORED: return _("Mirrored Linear");
			case RADIAL: return _("Radial");
		}
		return "undefined";
	}
	
	/**
	 * Creates a ListStore with the first column set as the description
	 * and the second column set as the GradientType.
	 */
	public static Gtk.ListStore list_store()
	{
		var store = new Gtk.ListStore(2, typeof(string), typeof(GradientType));
		Gtk.TreeIter itr;
		
		store.append(out itr);
		store.set(itr, 0, LINEAR.description(), 1, LINEAR);
		store.append(out itr);
		store.set(itr, 0, LINEAR_MIRRORED.description(), 1, LINEAR_MIRRORED);
		store.append(out itr);
		store.set(itr, 0, RADIAL.description(), 1, RADIAL);
		
		return store;
	}
}
