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
 * A GtkClutter.Embed with scrollbars 
 *
 * A ScollableEmbed contains a {@link GtkClutter.Viewport} within a
 * {@link GtkClutter.Embed}. The horizontal scrollbar is optional.
 */
internal class Ease.ScrollableEmbed : Gtk.HBox
{
	// actors
	private GtkClutter.Embed embed;
	private GtkClutter.Viewport viewport;
	private Clutter.Stage stage;
	internal Clutter.Group contents { get; private set; }

	// scrolling
	private Gtk.HScrollbar h_scrollbar;
	private Gtk.VScrollbar v_scrollbar;
	private Gtk.Alignment h_padder;
	private Gtk.Alignment v_padder;
	private Gtk.Adjustment h_adjust;
	private Gtk.Adjustment v_adjust;
	private Gtk.Adjustment z_adjust;
	
	// constants
	private const int FRAME_PADDING = 2;
	
	internal bool has_horizontal { get; private set; }
	
	/**
	 * The width of this ScrollableEmbed's Stage.
	 */
	internal float width { get{ return stage.width; } }

	/**
	 * The height of this ScrollableEmbed's Stage.
	 */
	internal float height { get { return stage.height; } }
	
	/**
	 * Instantiate a ScollableEmbed with an optional vertical sidebar.
	 * 
	 * A ScollableEmbed contains a {@link GtkClutter.Viewport} within a
	 * {@link GtkClutter.Embed}.
	 *
	 * @param horizontal If true, the ScrollableEmbed has a horizontal
	 * scrollbar in addition to the vertical scrollbar.
	 * @param has_frame If the EditorEmbed should have a frame around its stage.
	 */
	internal ScrollableEmbed(bool horizontal, bool has_frame)
	{
		has_horizontal = horizontal;
		// create children
		embed = new GtkClutter.Embed();
		h_adjust = new Gtk.Adjustment(0, 0, 1, 0.1, 0.1, 0.1);
		h_scrollbar = new Gtk.HScrollbar(h_adjust);
		v_adjust = new Gtk.Adjustment(0, 0, 1, 0.1, 0.1, 0.1);
		v_scrollbar = new Gtk.VScrollbar(v_adjust);
		z_adjust = new Gtk.Adjustment(0, 0, 1, 0.1, 0.1, 0.1);
		
		debug("%f %f", v_adjust.value, v_adjust.upper);

		// set up clutter actors
		viewport = new GtkClutter.Viewport(h_adjust, v_adjust, z_adjust);
		contents = new Clutter.Group();
		
		stage = (Clutter.Stage)(embed.get_stage());
		stage.add_actor(viewport);
		viewport.child = contents;

		// add the embed to a frame if requested
		var vbox = new Gtk.VBox(false, 0);
		if (has_frame)
		{
			// create the frame
			var frame = new Gtk.Frame(null);
			frame.shadow_type = Gtk.ShadowType.IN;
			frame.add(embed);
			
			// add the frame to padded alignment
			var align = new Gtk.Alignment(0, 0, 1, 1);
			align.set_padding(0, horizontal ? FRAME_PADDING : 0,
			                  0, FRAME_PADDING);
			align.add(frame);
			
			vbox.pack_start(align, true, true, 0);
		}
		else
		{
			vbox.pack_start(embed, true, true, 0);
		}
		
		if (has_horizontal)
		{
			// this widget shifts the scrollbar to line up with the frame
			h_padder = new Gtk.Alignment(0, 0, 0, 0);
			
			var hscroll_box = new Gtk.HBox(false, 0);
			hscroll_box.pack_start(h_scrollbar, true, true, 0);
			hscroll_box.pack_start(h_padder, false, false, 0);
			vbox.pack_start(hscroll_box, false, false, 0);
			
			/* so that the vertical scrollbar doesn't extend to the bottom
			   of the horizontal scrollbar, a padding widget is added */
			v_padder = new Gtk.Alignment(0, 0, 0, 0);
			
			var vscroll_box = new Gtk.VBox(false, 0);
			vscroll_box.pack_start(v_scrollbar, true, true, 0);
			vscroll_box.pack_start(v_padder, false, false, 0);
			pack_end(vscroll_box, false, false, 0);
			
			h_scrollbar.size_allocate.connect((sender, rect) => {
				h_padder.width_request = FRAME_PADDING;
				v_padder.height_request = rect.height + FRAME_PADDING;
			});
		}
		else
		{
			pack_end(v_scrollbar, false, false, 0);
		}

		pack_start(vbox, true, true, 0);
		
		stage.show_all();
		
		// scroll the view as is appropriate (with the mouse wheel)
		realize.connect(() => {
			get_window().set_events(Gdk.EventMask.ALL_EVENTS_MASK);
		});
		
		button_press_event.connect((event) => {
			return false;
		});
		
		scroll_event.connect((event) => {
			switch (event.direction)
			{
				case Gdk.ScrollDirection.UP:
					v_adjust.value = Math.fmin(v_adjust.upper,
					                 Math.fmax(v_adjust.lower,
					                           v_adjust.value -
					                           v_adjust.step_increment));
					break;
				case Gdk.ScrollDirection.DOWN:
					v_adjust.value = Math.fmin(v_adjust.upper,
					                 Math.fmax(v_adjust.lower,
					                           v_adjust.value +
					                           v_adjust.step_increment));
					break;
			}
			return false;
		});

		// react when the view is resized
		embed.size_allocate.connect(embed_allocate);
	}
	
	/**
	 * Returns the stage of this ScrollableEmbed. Use with caution. Most
	 * actors should be placed onto the "contents" ClutterGroup.
	 */
	internal Clutter.Stage get_stage()
	{
		return (Clutter.Stage)(embed.get_stage());
	}
	
	/**
	 * Signal handler for size allocation.
	 */
	private void embed_allocate(Gtk.Widget sender, Gdk.Rectangle rect)
	{
		// pass on to Clutter actors
		stage.width = allocation.width;
		stage.height = allocation.height;
		viewport.width = allocation.width;
		viewport.height = allocation.height;
	}
	
	/**
	 * When grabbing focus, grab it on the embed.
	 */
	internal override void grab_focus()
	{
		embed.grab_focus();
	}
}
