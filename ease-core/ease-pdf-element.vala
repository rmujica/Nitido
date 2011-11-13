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
 * Displays a PDF document in a presentation.
 */
public class Ease.PdfElement : MediaElement
{
	private const string UI_FILE = "inspector-element-pdf.ui";
	private const int DEFAULT_PAGE = 0;
	
	/**
	 * The page of the PDF file that is initially displayed.
	 */
	public int displayed_page { get; set; default = 0; }
	
	/**
	 * Whether or not the user can change pages in the presentation.
	 */
	public bool allow_flipping { get; set; default = true; }
	
	/**
	 * The background displayed behind the PDF (if it is visible)
	 */
	internal Background background;
	
	/**
	 * The background widget controlling {@link background}.
	 */
	private BackgroundWidget bg_widget;
	
	internal Poppler.Document pdf_doc;
	
	public PdfElement(string filename)
	{
		pdf_doc = new Poppler.Document.from_file(Filename.to_uri(filename),
		                                         null);
		background = new Background.white();
		signals();
	}
	
	internal PdfElement.from_json(Json.Object obj, Slide owner)
	{
		base.from_json(obj);
		parent = owner;
		displayed_page = obj.get_string_member(Theme.PDF_DEFAULT_PAGE).to_int();
		allow_flipping = obj.get_boolean_member(Theme.PDF_ALLOW_FLIPPING);
		
		background =
			new Background.from_json(obj.get_object_member(Theme.BACKGROUND));
		
		pdf_doc = new Poppler.Document.from_file(Filename.to_uri(full_filename),
		                                         null);
	}	
	
	public override Actor actor(ActorContext c)
	{
		return new PdfActor(this, c);
	}
	
	public override Json.Object to_json()
	{
		var obj = base.to_json();
		obj.set_object_member(Theme.BACKGROUND, background.to_json());
		obj.set_string_member(Theme.PDF_DEFAULT_PAGE, displayed_page.to_string());
		obj.set_boolean_member(Theme.PDF_ALLOW_FLIPPING, allow_flipping);
		return obj;
	}
	
	/**
	 * Renders this PdfElement as HTML.
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
		var html = "<img class=\"pdf element\" ";
		
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
		              "\" alt=\"PDF\" />";
	}
	
	public override void cairo_render(Cairo.Context context) throws Error
	{
		// render the background
		background.cairo_render(context, (int)width, (int)height,
		                        parent.parent.path);
		
		// get the current page
		var page = pdf_doc.get_page(displayed_page);
		
		// scale the context
		double w = 0, h = 0;
		page.get_size(out w, out h);
		context.scale(width / w, height / h);
		
		// render the PDF
		page.render(context);
	}
	
	public override Gtk.Widget inspector_widget()
	{
		bool silence_undo = false;
		
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		// get the displayed page slider
		var scale = builder.get_object("disp-page") as Gtk.HScale;
		scale.adjustment.upper = pdf_doc.get_n_pages();
		
		// format the scale value's display
		scale.format_value.connect((s, value) => {
			return "%i".printf((int)value + 1);
		});
		
		// connect the slider's changed signal
		scale.value_changed.connect(() => {
			// create an undo acton
			var action = new UndoAction(this, "displayed-page");
			changed();
			
			displayed_page = (int)scale.adjustment.value;
			
			// emit the undoaction
			if (!silence_undo) undo(action);
		});
		
		notify["displayed-page"].connect(() => {
			silence_undo = true;
			scale.adjustment.value = displayed_page;
			changed();
			silence_undo = false;
		});
		
		// set up the flipping
		var flip = builder.get_object("allow-flipping") as Gtk.CheckButton;
		flip.active = allow_flipping;
		
		flip.toggled.connect((button) => {
			// create an undo acton
			var action = new UndoAction(this, "allow-flipping");
			
			allow_flipping = button.active;
			
			// emit the undoaction
			if (!silence_undo) undo(action);
		});
		
		notify["allow-flipping"].connect(() => {
			silence_undo = true;
			flip.active = allow_flipping;
			silence_undo = false;
		});
		
		// add a background widget
		bg_widget = new BackgroundWidget(background, this);
		(builder.get_object("root-vbox") as Gtk.Box).pack_end(
			bg_widget, false, true, 0);
		bg_widget.show();
		
		// return the root widget
		return builder.get_object("root") as Gtk.Widget;
	}
	
	public override void signals()
	{
		base.signals();
		
		notify["default-page"].connect((o, p) => changed());
		
		undo.connect((item) => {
			if (background.owns_undoitem(item)) changed();
		});
	}
}
