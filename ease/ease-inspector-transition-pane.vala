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
 * The inspector pane for changing transitions
 */
internal class Ease.InspectorTransitionPane : InspectorPane
{
	internal Gtk.ComboBox effect;
	private Gtk.SpinButton transition_time;
	internal Gtk.ComboBox variant;
	private Gtk.Alignment variant_align;
	private Gtk.ComboBox start_transition;
	private Gtk.SpinButton delay;
	
	// transition preview
	private GtkClutter.Embed preview;
	private Clutter.Group preview_group;
	private Gtk.Alignment preview_align;
	private SlideActor current_slide;
	private SlideActor new_slide;
	private Clutter.Timeline preview_alarm;
	
	// the old slide, to disconnect handlers
	private Slide old_slide;
	
	// constants
	private const int PREVIEW_HEIGHT = 150;
	private const uint PREVIEW_DELAY = 500;
	private const int DEFAULT_TRANSITION_TIME = 1;
	private const int DEFAULT_ADVANCE_DELAY = 5;
	
	// silence undo if needed
	private bool silence_undo;
	
	internal InspectorTransitionPane(Document d)
	{
		base(d);
		
		// preview
		preview = new GtkClutter.Embed();
		((Clutter.Stage)(preview.get_stage())).color = {0, 0, 0, 255};
		
		preview_align = new Gtk.Alignment(0.5f, 0.5f, 1, 1);
		var frame = new Gtk.Frame(null);
		frame.shadow_type = Gtk.ShadowType.IN;
		preview_align.add(preview);
		frame.add(preview_align);
		
		pack_start(frame, false, false, 5);
		preview_group = new Clutter.Group();
		((Clutter.Stage)preview.get_stage()).add_actor(preview_group);
		
		// transition selection
		var vbox = new Gtk.VBox(false, 0);
		var hbox = new Gtk.HBox(false, 0);
		var align = new Gtk.Alignment(0, 0, 0, 0);
		align.add(new Gtk.Label(_("Effect")));
		vbox.pack_start(align, false, false, 0);
		effect = new Gtk.ComboBox.with_model(Transition.model());
		var render = new Gtk.CellRendererText();
		effect.pack_start(render, true);
		effect.set_attributes(render, "text", 0);
		align = new Gtk.Alignment(0, 0, 1, 1);
		align.add(effect);
		vbox.pack_start(align, false, false, 0);
		hbox.pack_start(vbox, true, true, 5);
		
		// transition time
		vbox = new Gtk.VBox(false, 0);
		align = new Gtk.Alignment(0, 0, 0, 0);
		align.add(new Gtk.Label(_("Duration")));
		vbox.pack_start(align, false, false, 0);
		transition_time = new Gtk.SpinButton.with_range(0, 10, 0.25);
		transition_time.digits = 2;
		align = new Gtk.Alignment(0, 0.5f, 1, 1);
		align.add(transition_time);
		vbox.pack_start(align, true, true, 0);
		hbox.pack_start(vbox, false, false, 5);
		pack_start(hbox, false, false, 5);
		
		// transition variant
		hbox = new Gtk.HBox(false, 0);
		vbox = new Gtk.VBox(false, 0);
		align = new Gtk.Alignment(0, 0, 0, 0);
		align.add(new Gtk.Label(_("Direction")));
		vbox.pack_start(align, false, false, 0);
		variant = new Gtk.ComboBox();
		render = new Gtk.CellRendererText();
		variant.pack_start(render, true);
		variant.set_attributes(render, "text", 0);
		variant_align = new Gtk.Alignment(0, 0, 1, 1);
		variant_align.add(variant);
		vbox.pack_start(variant_align, false, false, 0);
		hbox.pack_start(vbox, true, true, 5);
		pack_start(hbox, false, false, 5);
		
		// start transition
		vbox = new Gtk.VBox(false, 0);
		hbox = new Gtk.HBox(false, 0);
		align = new Gtk.Alignment(0, 0, 0, 0);
		align.add(new Gtk.Label(_("Start Transition")));
		vbox.pack_start(align, false, false, 0);
		start_transition = new Gtk.ComboBox.text();
		start_transition.append_text(_("Manually"));
		start_transition.append_text(_("Automatically"));
		start_transition.set_active(0);
		align = new Gtk.Alignment(0, 0, 1, 1);
		align.add(start_transition);
		vbox.pack_start(align, false, false, 0);
		hbox.pack_start(vbox, true, true, 5);
					
		// start transition delay
		vbox = new Gtk.VBox(false, 0);
		align = new Gtk.Alignment(0, 0, 0, 0);
		align.add(new Gtk.Label(_("Delay")));
		vbox.pack_start(align, false, false, 0);
		delay = new Gtk.SpinButton.with_range(0, 10, 0.25);
		delay.digits = 2;
		align = new Gtk.Alignment(0, 0.5f, 1, 1);
		align.add(delay);
		vbox.pack_start(align, true, true, 0);
		hbox.pack_start(vbox, false, false, 5);
		pack_start(hbox, false, false, 5);
		
		// signal handlers
		effect.changed.connect((sender) => {
			// allow the user to undo the change
			var action = new UndoAction(slide, "transition");
			action.add(slide, "variant");
			
			var already_silenced = silence_undo;
			silence_undo = true;
			
			// set the transition
			Gtk.TreeIter itr;
			if (sender.get_active_iter(out itr))
			{
				Transition transition;
				sender.model.get(itr, 1, out transition);
				
				// set transition time if required
				if (transition == Transition.NONE)
				{
					transition_time.set_value(slide.transition_time);
					transition_time.sensitive = false;
					action.add(slide, "transition-time");
				}
				else if (slide.transition == Transition.NONE)
				{
					if (slide.transition_time == 0)
					{
						slide.transition_time = DEFAULT_TRANSITION_TIME;
					}
					transition_time.set_value(slide.transition_time);
					transition_time.sensitive = true;
					action.add(slide, "transition-time");
				}
				
				// set the slide's transition
				slide.transition = transition;
				
				// with this all successful, send the UndoAction
				if (!already_silenced) slide.undo(action);
			}
			else
			{
				critical("Transition not found in model");
				action.apply();
			}
			
			// get the variants for the new transition
			variant.model = slide.transition.variant_model();
			
			// if the slide has variants, make the appropriate one active
			if (variant.model.get_iter_first(out itr))
			{
				TransitionVariant v;
				do
				{
					variant.model.get(itr, 1, out v);
					if (v == slide.variant)
					{
						variant.set_active_iter(itr);
						silence_undo = already_silenced;
						return;
					}
				}
				while (variant.model.iter_next(ref itr));
				
				// if none was set, set the variant to the first item
				variant.model.get_iter_first(out itr);
				variant.set_active_iter(itr);
			}
			
			silence_undo = already_silenced;
		});
		
		// allow the user to change the variant
		variant.changed.connect((sender) => {
			if (!silence_undo) slide.undo(new UndoAction(slide, "variant"));
			
			Gtk.TreeIter itr;
			if (sender.get_active_iter(out itr))
			{
				TransitionVariant variant;
				sender.model.get(itr, 1, out variant);
				slide.variant = variant;
			}
			else
			{
				critical("Variant not found in model");
			}
		});
		
		start_transition.changed.connect(() => {
			if (!silence_undo) slide.undo(new UndoAction(slide,
			                                       "automatically-advance"));
			if (start_transition.active == 0)
			{
				delay.sensitive = false;
				slide.automatically_advance = false;
			}
			else
			{
				delay.sensitive = true;
				slide.automatically_advance = true;
				if (slide.advance_delay == 0)
				{
					slide.advance_delay = DEFAULT_ADVANCE_DELAY;
				}
			}
		});
		
		transition_time.value_changed.connect(() => {
			if (!silence_undo)
				slide.undo(new UndoAction(slide, "transition-time"));
			slide.transition_time = transition_time.get_value();
		});
		
		delay.value_changed.connect(() => {
			if (!silence_undo)
				slide.undo(new UndoAction(slide, "advance-delay"));
			slide.advance_delay = delay.get_value();
		});
		
		// automatically scale the preview to fit in the embed
		preview.get_stage().allocation_changed.connect((box, flags) => {
			preview_group.scale_x = (box.x2 - box.x1) / slide.width;
			preview_group.scale_y = (box.y2 - box.y1) / slide.height;
		});
		
		// automatically set the correct aspect ratio for the preview
		preview_align.size_allocate.connect((widget, allocation) => {
			if (slide == null) return;
			
			preview_align.height_request =
				(int)(allocation.width / document.aspect);
		});
	}
	
	private void animate_preview()
	{
		current_slide.reset(preview_group);
		new_slide.reset(preview_group);
		new_slide.opacity = 0;
		
		preview_alarm = new Clutter.Timeline(PREVIEW_DELAY);
		preview_alarm.completed.connect(() => {
			animate_preview_start();
		});
		preview_alarm.start();
	}
	
	private void animate_preview_start()
	{
		if (slide.transition_msecs == 0 || slide.transition == Transition.NONE)
		{
			animate_preview();
			return;
		}
		
		new_slide.opacity = 255;
		
		current_slide.transition(new_slide, preview_group);
		
		preview_alarm = new Clutter.Timeline(slide.transition_msecs);
		preview_alarm.completed.connect(() => {
			animate_preview_delay();
		});
		preview_alarm.start();
	}
	
	private void animate_preview_delay()
	{
		preview_alarm = new Clutter.Timeline(PREVIEW_DELAY);
		preview_alarm.completed.connect(() => {
			animate_preview();
		});
		preview_alarm.start();
	}
	
	private void on_slide_notify(GLib.Object obj, GLib.ParamSpec spec)
	{
		var already_silenced = silence_undo;
		silence_undo = true;
		Gtk.TreeIter itr;
		switch (spec.name)
		{
			case "transition":
				if (effect.model.get_iter_first(out itr))
				{
					bool set = false;
					Transition t;
					do
					{
						effect.model.get(itr, 1, out t);
						if (t == slide.transition)
						{
							effect.set_active_iter(itr);
							set = true;
							break;
						}
					}
					while (effect.model.iter_next(ref itr));
			
					// if none was set, set the variant to the first item
					if (!set)
					{
						effect.model.get_iter_first(out itr);
						effect.set_active_iter(itr);
					}
				}
				break;
			case "variant":
				if (variant.model.get_iter_first(out itr))
				{
					TransitionVariant v;
					do
					{
						variant.model.get(itr, 1, out v);
						if (v == slide.variant)
						{
							variant.set_active_iter(itr);
							silence_undo = already_silenced;
							return;
						}
					}
					while (variant.model.iter_next(ref itr));
				
					// if none was set, set the variant to the first item
					variant.model.get_iter_first(out itr);
					variant.set_active_iter(itr);
				}
				break;
			case "transition-time":
				transition_time.set_value(slide.transition_time);
				break;
			case "advance-delay":
				delay.set_value(slide.advance_delay);
				break;
			case "start-transition":
				start_transition.set_active(slide.automatically_advance ?
				                            1 : 0);
				delay.set_value(slide.advance_delay);
				delay.sensitive = slide.automatically_advance;
				break;
		}
		silence_undo = already_silenced;
	}
	
	protected override void slide_updated()
	{
		silence_undo = true;
		
		// disconnect old signal handlers
		if (old_slide != null)
		{
			old_slide.notify["transition-time"].disconnect(on_slide_notify);
			old_slide.notify["variant"].disconnect(on_slide_notify);
			old_slide.notify["transition"].disconnect(on_slide_notify);
			old_slide.notify["advance-delay"].disconnect(on_slide_notify);
			old_slide.notify["start-transition"].disconnect(on_slide_notify);
		}
		old_slide = slide;
		
		// connect new signal handlers
		slide.notify["transition-time"].connect(on_slide_notify);
		slide.notify["variant"].connect(on_slide_notify);
		slide.notify["transition"].connect(on_slide_notify);
		slide.notify["advance-delay"].connect(on_slide_notify);
		slide.notify["start-transition"].connect(on_slide_notify);
		
		// set transition time box
		transition_time.set_value(slide.transition_time);
		transition_time.sensitive = slide.transition != Transition.NONE;
		
		// set effect and variant combo boxes
		Gtk.TreeIter itr;
		if (effect.model.get_iter_first(out itr))
		{
			bool set = false;
			Transition t;
			do
			{
				effect.model.get(itr, 1, out t);
				if (t == slide.transition)
				{
					effect.set_active_iter(itr);
					set = true;
					break;
				}
			}
			while (effect.model.iter_next(ref itr));
			
			if (variant.model.get_iter_first(out itr))
			{
				TransitionVariant v;
				do
				{
					variant.model.get(itr, 1, out v);
					if (v == slide.variant)
					{
						variant.set_active_iter(itr);
						break;
					}
				}
				while (variant.model.iter_next(ref itr));
			}
			
			// if none was set, set the variant to the first item
			if (!set)
			{
				effect.model.get_iter_first(out itr);
				effect.set_active_iter(itr);
			}
		}
		
		// set the automatic advance boxes
		start_transition.set_active(slide.automatically_advance ? 1 : 0);
		delay.set_value(slide.advance_delay);
		delay.sensitive = slide.automatically_advance;
		
		// size the preview box
		Gtk.Allocation alloc = Gtk.Allocation();
		preview_align.get_allocation(out alloc);
		preview_align.height_request = (int)(alloc.width / document.aspect);
		
		// remove the old preview slide actors
		preview_group.remove_all();
		
		// add new slide previews
		current_slide = new SlideActor.from_slide(document, slide, true,
		                                          ActorContext.INSPECTOR);
		
		new_slide = document.has_next_slide(slide) ?
		            new SlideActor.from_slide(document, slide.next, true,
		                                      ActorContext.INSPECTOR) :
		            new SlideActor.blank(document, { 0, 0, 0, 255 });
		
		preview_group.add_actor(current_slide);
		preview_group.add_actor(new_slide);
		
		// start the preview animation
		if (preview_alarm != null)
		{
			preview_alarm.stop();
		}
		animate_preview();
		
		silence_undo = false;
	}
}

