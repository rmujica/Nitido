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

internal class Ease.InspectorElementPane : InspectorPane
{
	private Gtk.Widget none;
	private Gtk.Widget current;
	private const string UI_FILE_PATH = "inspector-element-none.ui";
	
	internal InspectorElementPane(Document d)
	{
		base(d);
		
		// build the "nothing selected" widget
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE_PATH)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		none = builder.get_object("root") as Gtk.Widget;
		
		// add the "nothing selected" widget
		pack_start(none, true, true, 0);
	}
	
	internal void on_element_selected(Element selected)
	{
		if (current != null)
		{
		 	if (current.get_parent() == this) remove(current);
		}
		else if (none.get_parent() == this) remove(none);
		current = selected.get_inspector_widget();
		pack_start(current, false, false, 0);
	}
	
	internal void on_element_deselected(Element? deselected)
	{
		if (none.get_parent() != this) pack_start(none, true, true, 0);
		none.show();
		if (current != null)
		{
			if (current.get_parent() == this) remove(current);
		}
		current = null;
	}
	
	internal override void slide_updated()
	{
		if (none.get_parent() != this) pack_start(none, true, true, 0);
		if (current == null) return;
		if (current.get_parent() == this) remove(current);
	}
}
