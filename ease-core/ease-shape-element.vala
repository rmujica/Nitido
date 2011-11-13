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

public class Ease.ShapeElement : CairoElement
{
	private const string UI_FILE = "inspector-element-shape.ui";
	
	/**
	 * The shape of this ShapeElement.
	 */
	public ShapeType shape_type { get; private set; }
	
	/**
	 * The background of this ShapeElement.
	 */
	private Background background { get; private set; }
	
	/**
	 * Creates a new ShapeElement.
	 *
	 * @param type The shape of the element (rectangle, oval).
	 */
	public ShapeElement(ShapeType type)
	{
		signals();
		
		shape_type = type;
		background = new Background.default_gradient();
	}
	
	/**
	 * Constructs a ShapeElement from a JsonObject.
	 */
	public ShapeElement.from_json(Json.Object obj)
	{
		base.from_json(obj);
		shape_type =
			ShapeType.from_string(obj.get_string_member(Theme.SHAPE_TYPE));
		
		// read the shapes's background properties
		background =
			new Background.from_json(obj.get_object_member(Theme.BACKGROUND));
	}
	
	/**
	 * Serializes this ShapeElement to JSON.
	 */
	public override Json.Object to_json()
	{
		var obj = base.to_json();
		obj.set_string_member(Theme.SHAPE_TYPE, shape_type.to_string());
		
		// write the shape's background properties
		obj.set_object_member(Theme.BACKGROUND, background.to_json());
		
		return obj;
	}
	
	/**
	 * Claims this ShapeElement's background image, if needed.
	 */
	public override string[] claim_media()
	{
		if (background.image.filename != null)
			return { background.image.filename };
		return {};
	}
	
	/**
	 * Renders this ShapeElement as HTML.
	 */
	public override string html_render(HTMLExporter exporter)
	{
		var dir = Temp.request();
		var surface = new Cairo.ImageSurface(Cairo.Format.ARGB32,
		                                     (int)width, (int)height);
		var cr = new Cairo.Context(surface);
		cairo_render(cr);
		
		var path = Path.build_filename(dir, exporter.render_index.to_string());
		surface.write_to_png(path);
		var output = exporter.copy_rendered(path);
		
		// open the img tag
		var html = "<img class=\"shape element\" ";
		
		// set the image's style
		html += "style=\"";
		html += "left:" + x.to_string() + "px;";
		html += " top:" + y.to_string() + "px;";
		html += " width:" + width.to_string() + "px;";
		html += " height:" + height.to_string() + "px;";
		html += " position: absolute;\" ";
		
		// add the image
		return html + "src=\"" +
		              (exporter.basename +
		               " Media/" + output).replace(" ", "%20") +
		              "\" alt=\"Shape\" />";
	}
	
	/**
	 * {@inheritDoc}
	 */
	public override Gtk.Widget inspector_widget()
	{
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		var bg = new BackgroundWidget(background, this);
		
		if (shape_type == ShapeType.RECTANGLE)
		{
			(builder.get_object("rect") as Gtk.ToggleButton).active = true;
		}
		else
		{
			(builder.get_object("oval") as Gtk.ToggleButton).active = true;
		}
		
		(builder.get_object("rect") as Gtk.Button).clicked.connect(() => {
			shape_type = ShapeType.RECTANGLE;
		});
		
		(builder.get_object("oval") as Gtk.Button).clicked.connect(() => {
			shape_type = ShapeType.OVAL;
		});
			
		(builder.get_object("vbox-root") as Gtk.Box).pack_end(
			bg, false, true, 0);
			
		bg.show();
		
		return builder.get_object("root") as Gtk.Widget;
	}
	
	/**
	 * Renders this ShapeElement to a CairoContext.
	 *
	 * @param cr The context to render to.
	 */
	public override void cairo_render(Cairo.Context cr)
	{
		background.set_cairo(cr, (int)width, (int)height, parent.parent.path);
		
		switch (shape_type)
		{
			case ShapeType.RECTANGLE:
				cr.rectangle(0, 0, width, height);
				break;
			case ShapeType.OVAL:
				cr.translate(width / 2, height / 2);
				cr.scale(width / 2, height / 2);
				cr.arc(0, 0, 1, 0, 2 * Math.PI);
				break;
		}
		cr.fill();
	}
	
	public override void signals()
	{
		base.signals();
		
		notify["shape-type"].connect((o, p) => changed());
		
		undo.connect((item) => {
			if (background.owns_undoitem(item)) changed();
		});
	}
}

/**
 * Enumerates the possible shapes of a ShapeElement.
 */
public enum Ease.ShapeType
{
	/**
	 * A basic rectangle.
	 */
	RECTANGLE = 0,
	
	/**
	 * An oval, not restricted in aspect ratio.
	 */
	OVAL = 1;
	
	/**
	 * Parses a ShapeType from a string representation.
	 */
	internal static ShapeType from_string(string str)
	{
		switch (str)
		{
			case "EASE_SHAPE_TYPE_RECTANGLE":
				return RECTANGLE;
			case "EASE_SHAPE_TYPE_OVAL":
				return OVAL;
			default:
				critical("Invalid shape type: %s", str);
				return RECTANGLE;
		}
	}
}
