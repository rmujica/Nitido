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
 * An {@link Element} subclass for displaying text. Linked with {@link TextActor}.
 */
public class Ease.TextElement : Element
{
	private const string UI_FILE_PATH = "inspector-element-text.ui";
	private bool freeze = false;
	private const string DEFAULT_TEXT = _("Double click to edit");
	
	/**
	 * Creates a new TextElement.
	 */
	public TextElement()
	{
		signals();
	}
	
	/**
	 * Create a TextElement from a JsonObject
	 */
	internal TextElement.from_json(Json.Object obj)
	{
		base.from_json(obj);
		
		text = obj.get_string_member(Theme.TEXT_TEXT);
		color = new Color.from_string(obj.get_string_member(Theme.TEXT_COLOR));
		text_font = obj.get_string_member(Theme.TEXT_FONT);
		text_style_from_string(obj.get_string_member(Theme.TEXT_STYLE));
		text_variant_from_string(obj.get_string_member(Theme.TEXT_VARIANT));
		text_weight_from_string(obj.get_string_member(Theme.TEXT_WEIGHT));
		text_align_from_string(obj.get_string_member(Theme.TEXT_ALIGN));
		text_size_from_string(obj.get_string_member(Theme.TEXT_SIZE));
	}
	
	internal override Json.Object to_json()
	{
		var obj = base.to_json();
		
		obj.set_string_member(Theme.TEXT_COLOR, color.to_string());
		obj.set_string_member(Theme.TEXT_TEXT, text);
		obj.set_string_member(Theme.TEXT_FONT, text_font);
		obj.set_string_member(Theme.TEXT_STYLE, text_style_to_string());
		obj.set_string_member(Theme.TEXT_VARIANT, text_variant_to_string());
		obj.set_string_member(Theme.TEXT_WEIGHT, text_weight_to_string());
		obj.set_string_member(Theme.TEXT_ALIGN, text_align_to_string());
		obj.set_string_member(Theme.TEXT_SIZE, text_size_to_string());
		
		return obj;
	}
	
	public override Actor actor(ActorContext c)
	{
		return new TextActor(this, c);
	}
	
	/**
	 * This method sets the color of this TextElement, then returns "true".
	 *
	 * @param c The color to set the element to.
	 */
	public override bool set_color(Clutter.Color c)
	{
		color = new Color.from_clutter(c);
		return true;
	}
	
	/**
	 * This method returns the color of the TextElement.
	 */
	public override Clutter.Color? get_color()
	{
		return color.clutter;
	}
	
	public override Gtk.Widget inspector_widget()
	{
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE_PATH)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		// connect signals
		builder.connect_signals(this);
		
		// get the alignment buttons
		var left = builder.get_object("left-button") as Gtk.Button;
		var center = builder.get_object("center-button") as Gtk.Button;
		var right = builder.get_object("right-button") as Gtk.Button;
		
		// highlight the current alignment
		switch (text_align)
		{
			case Pango.Alignment.LEFT:
				left.relief = Gtk.ReliefStyle.NORMAL;
				break;
			case Pango.Alignment.CENTER:
				center.relief = Gtk.ReliefStyle.NORMAL;
				break;
			case Pango.Alignment.RIGHT:
				right.relief = Gtk.ReliefStyle.NORMAL;
				break;
		}
		
		// when the alignment is changed, select the correct button
		notify["text-align"].connect((obj, spec) => {
			switch (text_align)
			{
				case Pango.Alignment.LEFT:
					left.relief = Gtk.ReliefStyle.NORMAL;
					center.relief = Gtk.ReliefStyle.NONE;
					right.relief = Gtk.ReliefStyle.NONE;
					break;
				case Pango.Alignment.CENTER:
					left.relief = Gtk.ReliefStyle.NONE;
					center.relief = Gtk.ReliefStyle.NORMAL;
					right.relief = Gtk.ReliefStyle.NONE;
					break;
				case Pango.Alignment.RIGHT:
					left.relief = Gtk.ReliefStyle.NONE;
					center.relief = Gtk.ReliefStyle.NONE;
					right.relief = Gtk.ReliefStyle.NORMAL;
					break;
			}
		});
		
		// set up the font button
		var font = builder.get_object("font-button") as Gtk.FontButton;
		font.set_font_name(font_description.to_string());
		
		font.font_set.connect((button) => {
			var action = new UndoAction(this, "font-description");
			undo(action);
			font_description =
				Pango.FontDescription.from_string(font.font_name);
		});
		
		notify["font-description"].connect((obj, spec) => {
			font.set_font_name(font_description.to_string());
		});
		
		// set up the color button
		var color_b = builder.get_object("color-button") as Gtk.ColorButton;
		color_b.set_color(color.gdk);
		
		color_b.color_set.connect((button) => {
			var action = new UndoAction(this, "color");
			undo(action);
			color = new Color.from_gdk(color_b.color);
		});
		
		notify["color"].connect((obj, spec) => {
			color_b.color = color.gdk;
		});
		
		// return the root
		return builder.get_object("root") as Gtk.Widget;
	}
	
	[CCode (instance_pos = -1)]
	public void on_inspector_alignment(Gtk.Widget sender)
	{
		(sender.get_parent() as Gtk.Container).foreach((widget) => {
			(widget as Gtk.Button).relief = Gtk.ReliefStyle.NONE;
		});
		
		(sender as Gtk.Button).relief = Gtk.ReliefStyle.NORMAL;
		
		var action = new UndoAction(this, "text-align");
		var old = text_align;
		
		text_align_from_string(
			(((sender as Gtk.Bin).get_child() as Gtk.Image).stock));
		
		if (text_align != old)
		{
			undo(action);
		}
	}

	protected override string html_render(HTMLExporter exporter)
	{
		// open the tag
		string html = "<div class=\"text element\" ";
		
		// set the size and position of the element
		html += "style=\"";
		html += "left:" + x.to_string() + "px;";
		html += " top:" + y.to_string() + "px;";
		html += " width:" + width.to_string() + "px;";
		html += " height:" + width.to_string() + "px;";
		html += " position: absolute;";
		
		// set the text-specific properties of the element
		html += " color:" + 
		        @"rgb($(color.red8),$(color.green8),$(color.blue8));";
		        
		html += " font-family:'" + text_font + "', sans-serif;";
		        
		html += " font-size:" + text_size_to_string() + "pt;";
		
		html += " font-weight:" + text_weight_to_string() + ";";
		html += " font-style:" + text_style_to_string().down() +
		        ";";
		        
		html += " text-align:" + text_align_to_string() + ";\"";
		
		// write the actual content
		html += ">" + text.replace("\n", "<br />") +
		        "</div>";
		
		return html;
	}

	/**
	 * Renders a text Element with Cairo.
	 */
	public override void cairo_render(Cairo.Context context,
	                                  bool use_small) throws Error
	{
		var t = display_text;
		
		// create the layout
		var layout = Pango.cairo_create_layout(context);
		layout.set_text(t, (int)t.length);
		layout.set_width((int)(width * Pango.SCALE));
		layout.set_height((int)(height * Pango.SCALE));
		layout.set_font_description(font_description);
		layout.set_alignment(text_align);
		
		// render
		color.set_cairo(context);
		Pango.cairo_update_layout(context, layout);
		Pango.cairo_show_layout(context, layout);
	}
	
	/**
	 * The text value of this Element.
	 */
	public string text { get; set; }
	
	/**
	 * Gets the text this Element should display. This might not be the same as
	 * {@link text}.
	 */
	public string display_text
	{
		get
		{
			return has_been_edited || text.length > 0 ? text : DEFAULT_TEXT;
		}
	}
	
	/**
	 * The color of the text.
	 */
	public Color color { get; set; }
	
	/**
	 * The name of the text's font family.
	 */
	public string text_font
	{
		get { return text_font_priv; }
		set
		{
			text_font_priv = value;
			if (!freeze) notify_property("font-description");
		}
	}
	private string text_font_priv;
	
	/**
	 * The PangoStyle for this Element.
	 */
	public Pango.Style text_style
	{
		get { return text_style_priv; }
		set
		{
			text_style_priv = value;
			if (!freeze) notify_property("font-description");
		}
	}
	private Pango.Style text_style_priv;
	
	public string text_style_to_string()
	{
		switch (text_style)
		{
			case Pango.Style.OBLIQUE:
				return "oblique";
			case Pango.Style.ITALIC:
				return "italic";
			case Pango.Style.NORMAL:
				return "normal";
			default:
				critical("Invalid text style");
				return "normal";
		}
	}
	
	public void text_style_from_string(string str)
	{
		switch (str)
		{
			case "oblique":
				text_style = Pango.Style.OBLIQUE;
				break;
			case "italic":
				text_style = Pango.Style.ITALIC;
				break;
			default:
				text_style = Pango.Style.NORMAL;
				break;
		}
	}
	
	/**
	 * The PangoVariant for this Element.
	 */
	public Pango.Variant text_variant
	{
		get { return text_variant_priv; }
		set
		{
			text_variant_priv = value;
			if (!freeze) notify_property("font-description");
		}
	}
	private Pango.Variant text_variant_priv;
	
	public void text_variant_from_string(string str)
	{
		text_variant = str == "normal" ?
		                      Pango.Variant.NORMAL : Pango.Variant.SMALL_CAPS;
	}
	
	public string text_variant_to_string()
	{
		return text_variant == Pango.Variant.NORMAL ? "Normal" : "Small Caps";
	}
	
	/**
	 * The font's weight.
	 */
	public int text_weight
	{
		get { return text_weight_priv; }
		set
		{
			text_weight_priv = value;
			if (!freeze) notify_property("font-description");
		}
	}
	private int text_weight_priv;
	
	
	public void text_weight_from_string(string str)
	{
		text_weight = (Pango.Weight)(str.to_int());
	}
	
	public string text_weight_to_string()
	{
		return ((int)text_weight).to_string();
	}
	
	/**
	 * A full PangoFontDescription for this Element.
	 *
	 * This property creates a new FontDescription when retrieved, and
	 * sets all appropriate properties (text_weight, etc.) when set.
	 */
	public Pango.FontDescription font_description
	{
		owned get
		{
			var desc = new Pango.FontDescription();
			desc.set_family(text_font);
			desc.set_style(text_style);
			desc.set_weight((Pango.Weight)text_weight);
			desc.set_variant(text_variant);
			desc.set_size(text_size * Pango.SCALE);
			
			return desc;
		}
		set
		{
			freeze = true;
			text_font = value.get_family();
			text_style = value.get_style();
			text_weight = (int)value.get_weight();
			text_variant = value.get_variant();
			text_size = value.get_size() / Pango.SCALE;
			freeze = false;
		}
	}
	
	/**
	 * The alignment of the text.
	 */
	public Pango.Alignment text_align { get; set; }
	
	public void text_align_from_string(string str)
	{
		switch (str)
		{
			case "right":
			case "gtk-justify-right":
				text_align = Pango.Alignment.RIGHT;
				break;
			case "center":
			case "gtk-justify-center":
				text_align = Pango.Alignment.CENTER;
				break;
			case "left":
			case "gtk-justify-left":
				text_align = Pango.Alignment.LEFT;
				break;
			default:
				critical("Illegal alignment: %s", str);
				text_align = Pango.Alignment.LEFT;
				break;
		}
	}
	
	public string text_align_to_string()
	{
		switch (text_align)
		{
			case Pango.Alignment.RIGHT:
				return "right";
			case Pango.Alignment.CENTER:
				return "center";
			default:
				return "left";
		}
	}
	
	/**
	 * The size of the font.
	 *
	 * This value should be multiplied by Pango.SCALE for rendering, otherwise
	 * the text will be far too small to be visible.
	 */
	public int text_size
	{
		get { return text_size_priv; }
		set
		{
			text_size_priv = value;
			if (!freeze) notify_property("font-description");
		}
	}
	private int text_size_priv;

	public void text_size_from_string(string str)
	{
		text_size = str.to_int();
	}
	
	public string text_size_to_string()
	{
		return text_size.to_string();
	}
}
