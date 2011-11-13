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
 * A {@link MediaElement} subclass for displaying an image. Linked with
 * {@link ImageActor}.
 */
public class Ease.ImageElement : MediaElement
{
	private const string UI_FILE_PATH = "inspector-element-image.ui";
	private const int CACHE_SIZE = 100;
	
	private Gdk.Pixbuf small_cache
	{
		get
		{
			if (small_cache_l != null) return small_cache_l;
			var filename = Path.build_path("/", parent.parent.path, filename);
			return small_cache_l = new Gdk.Pixbuf.from_file_at_size(filename,
			                                                        CACHE_SIZE,
			                                                        CACHE_SIZE);
		}
		set { small_cache_l = value; }
	}
	private Gdk.Pixbuf small_cache_l;
	
	/**
	 * Create a new element.
	 */
	public ImageElement()
	{
		signals();
	}
	
	public override void signals()
	{
		base.signals();
		notify["filename"].connect(() => small_cache_l = null);
	}
	
	internal ImageElement.from_json(Json.Object obj)
	{
		base.from_json(obj);
	}
	
	internal override Actor actor(ActorContext c)
	{
		return new ImageActor(this, c);
	}
	
	public override void cairo_free_cache()
	{
		small_cache = null;
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
		
		// set up the file button
		var file_b = builder.get_object("file-button") as Gtk.FileChooserButton;
		file_b.set_filename(source_filename);
		
		file_b.file_set.connect((button) => {
			// create an undo action to redo the old file
			var action = new UndoAction(this, "filename");
			action.add(this, "source-filename");
			try
			{
				filename = parent.parent.add_media_file(file_b.get_filename());
				source_filename = file_b.get_filename();
				undo(action);
			}
			catch (Error e)
			{
				error_dialog(_("Error Inserting Image"), e.message);
			}
		});
		
		notify["source-filename"].connect((obj, spec) => {
			file_b.set_filename(source_filename);
		});
		
		// return the root
		return builder.get_object("root") as Gtk.Widget;
	}
	
	public override string html_render(HTMLExporter exporter)
	{
		// open the img tag
		string html = "<img class=\"image element\" ";
		
		// set the image's style
		html += "style=\"";
		html += "left:" + x.to_string() + "px;";
		html += " top:" + y.to_string() + "px;";
		html += " width:" + width.to_string() + "px;";
		html += " height:" + height.to_string() + "px;";
		html += " position: absolute;\" ";
		
		// add the image
		html += "src=\"" +
		        (exporter.basename + " " + filename).replace(" ", "%20") +
		        "\" alt=\"Image\" />";
		
		// copy the image file
		exporter.copy_file(filename, parent.parent.path);
		
		return html;
	}

	/**
	 * Renders an image Element with Cairo.
	 */
	public override void cairo_render(Cairo.Context context) throws Error
	{
		var filename = Path.build_path("/", parent.parent.path, filename);
		
		// load the image
		var pixbuf = new Gdk.Pixbuf.from_file_at_scale(filename,
		                                               (int)width,
		                                               (int)height,
		                                               false);
		
		Gdk.cairo_set_source_pixbuf(context, pixbuf, 0, 0);
		context.rectangle(0, 0, width, height);
		context.fill();
	}
	
	public override void cairo_render_small(Cairo.Context context) throws Error
	{
		var scaled = small_cache.scale_simple((int)width, (int)height,
		                                      Gdk.InterpType.NEAREST);
		Gdk.cairo_set_source_pixbuf(context, scaled, 0, 0);
		context.rectangle(0, 0, width, height);
		context.scale(40, 40);
		context.fill();
	}
}
