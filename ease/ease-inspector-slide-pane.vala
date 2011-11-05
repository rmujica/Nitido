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
 * The inspector pane concerning slides.
 */
internal class Ease.InspectorSlidePane : InspectorPane
{
	private const string UI_FILE_PATH = "inspector-slide.ui";

	private BackgroundWidget bg_widget;
	private Gtk.VBox vbox;

	internal InspectorSlidePane(Document d)
	{	
		base(d);
		
		// load the GtkBuilder file
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE_PATH)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		// get the root box
		vbox = builder.get_object("root-box") as Gtk.VBox;
		
		// connect signals
		builder.connect_signals(this);
		
		// add the root of the builder file to this widget
		pack_start(builder.get_object("root") as Gtk.Widget, true, true, 0);
	}
	
	protected override void slide_updated()
	{
		if (bg_widget != null) vbox.remove(bg_widget);
		bg_widget = new BackgroundWidget.for_slide(slide);
		vbox.pack_start(bg_widget, true, true, 0);
		bg_widget.show();
	}
}

