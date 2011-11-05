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
 * Base class for inspector panes
 */
internal abstract class Ease.InspectorPane : Gtk.VBox
{
	internal Slide slide { get; set; }
	internal Document document { get; set; }

	internal InspectorPane(Document d)
	{
		document = d;
		homogeneous = false;
		spacing = 0;
		
		notify["slide"].connect((a, b) => slide_updated());
	}
	
	/**
	 * Override this method to update interface elements when the displayed
	 * slide changes.
	 */
	protected virtual void slide_updated() {}
}
