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
 * Presents a {@link Document}
 * 
 * The Ease Player uses ClutterGtk to create a stage floated in the center
 * of a fullscreen Gtk.Window.
 */
internal class Ease.Player : Gtk.Window
{
	internal Document document { get; set; }
	internal int slide_index { get; set; }
	internal Clutter.Stage stage { get; set; }
	private bool can_animate { get; set; }
	private bool dragging = false;

	// current and transitioning out slide
	private SlideActor current_slide;
	private SlideActor old_slide;
	private Clutter.Group container;
	
	// automatic advance alarm
	private Clutter.Timeline advance_alarm;
	
	// scale the presentation, if needed
	private float scale = 1;
	
	// constants
	private const uint FADE_IN_TIME = 1000;
	private const uint FOCUS_OPACITY = 150;
	//FIXME : make it proportionnal
	private uint FOCUS_RADIUS = 100;

	// focus actors
	private Clutter.CairoTexture focus_circle;
	private Cairo.Pattern radial;
	private Cairo.Context cr;
	
	internal signal void complete();
	
	internal Player(Document doc)
	{
		document = doc;
		slide_index = -1;
		
		var embed = new GtkClutter.Embed();
		stage = embed.get_stage() as Clutter.Stage;
		stage.width = document.width * scale;
		stage.height = document.height * scale;
		stage.title = _("Ease Presentation");
		stage.use_fog = false;

		// scale the presentation if needed
		if (stage.width < document.width || stage.height < document.height)
		{
			var x = ((float)stage.width) / document.width;
			var y = ((float)stage.height) / document.height;
            
			scale = x < y ? x : y;
		}

		// keyboard handling
		stage.key_press_event.connect (on_key_press);

		// mouse handling
		stage.button_press_event.connect (on_button_press);
		stage.motion_event.connect (on_motion);
		stage.button_release_event.connect (on_button_release);
		stage.scroll_event.connect (on_scroll_event);
		
		// TODO : auto hide/show of the cursor.
		// stage.hide_cursor();
		
		stage.color = {0, 0, 0, 255};
		Clutter.grab_keyboard(stage);

		// focusing
		focus_circle = new Clutter.CairoTexture (1024, 768);
		focus_circle.set_anchor_point_from_gravity (Clutter.Gravity.CENTER);
		focus_circle.opacity = 0;
		focus_circle.set_position (stage.width/2, stage.height/2);

		radial = new Cairo.Pattern.radial (0, 0, FOCUS_RADIUS, 0, 0, 2*FOCUS_RADIUS);
		radial.add_color_stop_rgba (0, 0, 0, 0, 0);
		radial.add_color_stop_rgb (1, 0, 0, 0);

		this.stage.add_actor (focus_circle);
		stage.set_clip(0, 0, doc.width, doc.height);

		// make the stacking container
		container = new Clutter.Group();
		stage.add_actor(container);
		container.scale_x = scale;
		container.scale_y = scale;
		
		// start the presentation
		stage.show_all();
		
		var align = new Gtk.Alignment(0.5f, 0.5f, 0, 0);
		embed.set_size_request(document.width, document.height);
		
		// set background colors to black
		align.modify_bg(Gtk.StateType.NORMAL, Color.black.gdk);
		modify_bg(Gtk.StateType.NORMAL, Color.black.gdk);
		
		// build window
		align.add(embed);
		add(align);
		fullscreen();
		show_all();
		present();
		
		can_animate = true;
		advance();
	}

	internal bool on_motion (Clutter.MotionEvent event)
	{
		if (dragging) {
			focus_circle.clear ();

			cr = focus_circle.create ();
			cr.translate (event.x, event.y);
			cr.set_source (radial);

			cr.paint ();
			cr = null;
			stage.raise_child (focus_circle, null);
		} else {
			// fade out
		}
		return true;
	}

	internal bool on_button_release (Clutter.ButtonEvent event)
	{
		dragging = false;
		// FIXME : should the focus fade time be a constant ?
		focus_circle.animate (Clutter.AnimationMode.LINEAR, 150,
							  "opacity", 0);
		return true;
	}

	internal bool on_button_press (Clutter.ButtonEvent event)
	{
		dragging = true;
		debug ("Got a mouse click at %f, %f", event.x, event.y);

		focus_circle.clear ();

		cr = focus_circle.create ();
		cr.translate (event.x, event.y);
		cr.set_source (radial);

		cr.paint ();
		cr = null;
		stage.raise_child (focus_circle, null);
		focus_circle.animate (Clutter.AnimationMode.LINEAR, 150,
							  "opacity", FOCUS_OPACITY);
		return true;
	}

	internal bool on_scroll_event (Clutter.ScrollEvent event)
	{
		debug ("Scrolling active.");
		if (event.direction == Clutter.ScrollDirection.UP) {
			FOCUS_RADIUS += 10;
		} else if (event.direction == Clutter.ScrollDirection.DOWN) {
			if (FOCUS_RADIUS > 10) {
				FOCUS_RADIUS -= 10;
			}
		}
		/* Update the shape too */
		radial = new Cairo.Pattern.radial (0, 0, FOCUS_RADIUS, 0, 0, 2*FOCUS_RADIUS);
		radial.add_color_stop_rgba (0, 0, 0, 0, 0);
		radial.add_color_stop_rgb (1, 0, 0, 0);

		focus_circle.clear ();
		cr = focus_circle.create ();
		cr.translate (event.x, event.y);
		cr.set_source (radial);

		cr.paint ();
		cr = null;
		stage.raise_child (focus_circle, null);
		return true;
	}

	internal bool on_key_press (Clutter.KeyEvent event)
	{
		/* Coded with /usr/include/clutter-1.0/clutter/clutter-keysyms.h */
		/* Ask developers about the use of that file and the lack of doc */
		debug ("Got a key press, keyval = %u", event.keyval);
		switch (event.keyval) {
		case Key.ESCAPE:
			debug ("Quitting player.");
			complete ();
			break;
		case Key.RIGHT:
		case Key.DOWN:
		case Key.ENTER:
		case Key.SPACE:
			debug ("Advancing to next slide.");
			advance ();
			break;
		case Key.LEFT:
		case Key.UP:
		case Key.BACKSPACE:
		case Key.DELETE:
			debug ("Retreating to previous slide");
			retreat ();
			break;
		default:
			debug ("Key not handled.");
			break;
		}
		return true;
	}
		
	internal void advance()
	{
		// only advance when transitions are complete
		if (!can_animate)
		{
			return;
		}
		
		// stop the advance alarm
		if (advance_alarm != null)
		{
			advance_alarm.stop();
			advance_alarm = null;
		}
	
		slide_index++;
		if (slide_index == document.slides.size) // slideshow complete
		{
			complete();
			hide_all();
			return;
		}
		
		var slide = document.get_slide(slide_index);
		
		// the first slide simply fades in
		if (slide_index == 0)
		{
			create_current_slide(slide);
			slide.request_advance.connect(on_request_advance);
			current_slide.stack(container);
			current_slide.opacity = 0;
			current_slide.animate(Clutter.AnimationMode.EASE_IN_SINE,
			                      FADE_IN_TIME, "opacity", 255);
			
			advance_alarm = new Clutter.Timeline(FADE_IN_TIME);
			advance_alarm.completed.connect(animation_complete);
			advance_alarm.start();
			
			can_animate = false;
		}
		
		// otherwise, animate as usual
		else
		{
			old_slide.slide.request_advance.disconnect(on_request_advance);
			old_slide = current_slide;
			create_current_slide(slide);
			slide.request_advance.connect(on_request_advance);
			container.add_actor(current_slide);
			
			if (old_slide.slide.transition_time > 0 &&
			    old_slide.slide.transition != Transition.NONE)
			{
				old_slide.transition(current_slide, container);
				old_slide.animation_time.completed.connect(animation_complete);
				can_animate = false;
			}
			else
			{
				animation_complete();
			}
		}
	}
	
	private void retreat()
	{
		if (slide_index == 0) {
			return;
		}
		
		if (old_slide.animation_time != null) {
			old_slide.animation_time.stop();
		}
		
		slide_index--;
		can_animate = true;
		
		container.remove_all();
		create_current_slide(document.get_slide(slide_index));
		current_slide.stack(container);
		container.add_actor(current_slide);
	}
	
	private void create_current_slide(Slide slide)
	{
		/* Would it be better to return a new SlideActor instead ? */
		/* And then in the code : current_slide = create_current_slide (... */
		current_slide = new SlideActor.from_slide(document, slide, true,
		                                          ActorContext.PRESENTATION);
	}
	
	private void animation_complete()
	{
		container.remove_all();
		
		can_animate = true;
		current_slide.stack(container);
		
		// prepare to automatically advance if necessary
		if (current_slide.slide.automatically_advance)
		{
			uint time = (uint)(1000 * current_slide.slide.advance_delay);
			
			advance_alarm = new Clutter.Timeline(time);
			advance_alarm.completed.connect(() => {
				advance();
			});
			advance_alarm.start();
		}
	}
	
	/**
	 * This is requested by video actors that have finished playing. As the
	 * calling function is on Slide, element plugins should never be aware
	 * that this functionality exists.
	 */
	private void on_request_advance(Element element)
	{
		advance();
	}
}
