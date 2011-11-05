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
 * A GtkClutterEmbed with scrolling capabilities.
 */
public class Ease.ScrolledEmbed : GtkClutter.Embed
{
	/**
	 * The viewport. Actors should be placed on this, not on the stage.
	 * It is automatically resized as the stage resizes.
	 */
	public GtkClutter.Viewport viewport { get; private set; }
	
	public ScrolledEmbed(Gtk.Adjustment hadjustment,
	                     Gtk.Adjustment vadjustment,
	                     Gtk.Adjustment? zadjustment)
	{
		// create the viewport
		viewport = new GtkClutter.Viewport(hadjustment,
		                                   vadjustment,
		                                   zadjustment);
		
		// add the viewport to the stage
		(get_stage() as Clutter.Stage).add_actor(viewport);
		viewport.show();
		
		// resize the viewport with the stage
		get_stage().allocation_changed.connect(() => {
			viewport.width = get_stage().width;
			viewport.height = get_stage().height;
		});
	}
}
