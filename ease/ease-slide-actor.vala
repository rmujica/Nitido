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
 * A Clutter actor for a Slide
 *
 * SlideActor is a subclass of Clutter.Group. It is used in both the
 * editor and player, as well as assorted other preview screens.
 */
internal class Ease.SlideActor : Clutter.Group
{
	/**
	 * The {@link Slide} represented by this SlideActor.
	 */
	internal weak Slide slide { get; set; }

	/**
	 * The actor for the slide's background.
	 */
	internal Clutter.CairoTexture background;

	/**
	 * The group for the slide's contents.
	 */
	internal Flutter.Group contents;

	/**
	 * The context of the actor (presentation, etc.)
	 */
	internal ActorContext context;
	
	/**
	 * The SlideActor's width (note that this may differ from the actual width
	 * of the actor);
	 */
	private float width_px;
	
	/**
	 * The SlideActor's height (note that this may differ from the actual height
	 * of the actor);
	 */
	private float height_px;
	
	/**
	 * The ClutterTimeline for a transition animation.
	 */
	internal Clutter.Timeline animation_time { get; set; }
	private Clutter.Alpha animation_alpha { get; set; }
	private Clutter.Timeline time1;
	private Clutter.Timeline time2;
	private Clutter.Alpha alpha1;
	private Clutter.Alpha alpha2;

	/**
	 * The easing mode for the Slide transition.
	 */
	internal const int EASE_SLIDE = Clutter.AnimationMode.EASE_IN_OUT_SINE;
	
	/**
	 * The easing mode for the Drop transition.
	 */
	internal const int EASE_DROP = Clutter.AnimationMode.EASE_OUT_BOUNCE;
	
	/**
	 * The easing mode for the Pivot transition.
	 */
	internal const int EASE_PIVOT = Clutter.AnimationMode.EASE_OUT_SINE;
	
	/**
	 * The depth of the Flip transition.
	 */
	internal const float FLIP_DEPTH = -400;
	
	/**
	 * The scale of slides in the Panel transition.
	 */
	internal const float PANEL_SCALE = 0.75f;
	
	/**
	 * The depth at which a new slide in the Open Door transition
	 * starts.
	 */
	private const float OPEN_DEPTH = -3000;
	
	/**
	 * How far outwards the "doors" in the Open Door transition
	 * move.
	 */
	private const float OPEN_MOVE = 0.15f;
	
	/**
	 * The fraction of the Open Door transition's length that the door
	 * opening should take.
	 */
	private const float OPEN_TIME = 0.8f;
	
	/**
	 * The number of slats in the Slats transition.
	 */
	private const int SLAT_COUNT = 8;
	
	/**
	 * The opacity of transiton reflections.
	 */
	private const int REFLECTION_OPACITY = 70;
	
	/**
	 * The number of particles across the slide in the explode transition.
	 */
	private const int EXPLODE_PARTICLES = 10;
	
	/**
	 * The number of tiles across the side in the assemble transition.
	 */
	private const int ASSEMBLE_TILES = 12;
	
	/**
	 * Emitted when a subactor of this SlideActor is removed.
	 */
	internal signal void ease_actor_removed(Actor actor);
	
	/**
	 * Emitted when a subactor is added to this SlideActor.
	 */
	internal signal void ease_actor_added(Actor actor);
	
	/**
	 * Creates a SlideActor from a {@link Slide} and a {@link Document}.
	 * This calls the with_dimensions() constructor with the Document's
	 * dimensions.
	 *
	 * @param document The document.
	 * @param s The slide.
	 * @param clip If the edges of the SlideActor should be clipped to its
	 * dimensions.
	 * @param ctx The {@link ActorContext} for this SlideActor.
	 */
	internal SlideActor.from_slide(Document document, Slide s, bool clip,
	                             ActorContext ctx)
	{
		with_dimensions(document.width, document.height, s, clip, ctx);
	}
	
	/**
	 * Creates a SlideActor from a {@link Slide} with the given dimensions.
	 *
	 * @param w The width of the actor.
	 * @param h The height of the actor.
	 * @param s The slide.
	 * @param clip If the edges of the SlideActor should be clipped to its
	 * dimensions.
	 * @param ctx The {@link ActorContext} for this SlideActor.
	 */
	internal SlideActor.with_dimensions(float w, float h, Slide s, bool clip,
	                                  ActorContext ctx)
	{
		slide = s;
		context = ctx;
		width_px = w;
		height_px = h;

		// clip the actor's bounds
		if (clip)
		{
			set_clip(0, 0, w, h);
		}

		// set the background
		set_background();
		add_actor(background);

		contents = new Flutter.Group();

		foreach (var e in slide)
		{
			contents.add_actor(e.actor(context));
		}

		add_actor(contents);
		
		slide.background_changed.connect((s) => set_background());
		
		slide.element_added.connect(on_element_added);
		slide.element_removed.connect(on_element_removed);
		
		slide.element_reordered.connect((s, e) => reorder());
	}
	
	/**
	 * Instantiates a SlideActor of a single color. Used for transition previews
	 * with no "next" slide.
	 *
	 * @param document The {@link Document} this slide is "part of", to make it
	 * the proper size.
	 * @param color The background color.
	 */
	internal SlideActor.blank(Document document, Clutter.Color color)
	{
		// create the background
		background = new Clutter.CairoTexture(document.width, document.height);
		
		// create a blank contents actor
		contents = new Flutter.Group();
		
		// set the background size
		background.width = width_px;
		background.height = height_px;
	}
	
	/**
	 * Handles {@link Slide.element_added}.
	 */
	internal void on_element_added(Slide slide, Element element, int index)
	{
		var actor = element.actor(context);
		contents.add_actor(actor);
		contents.lower_child(actor, null);
		
		// raise the actor to its proper position
		reorder();
		
		ease_actor_added(actor as Actor);
	}
	
	/**
	 * Handles {@link Slide.element_removed}.
	 */
	internal void on_element_removed(Slide slide, Element element, int index)
	{
		foreach (var a in contents)
		{
			if ((a as Actor).element == element)
			{
				contents.remove_actor(a);
				ease_actor_removed(a as Actor);
				break;
			}
		}
	}
	
	/**
	 * Resets all transformations on this SlideActor.
	 */
	internal void reset(Clutter.Group container)
	{
		reset_actor(this);
		reset_actor(background);
		reset_actor(contents);
		stack(container);
	}
	
	/**
	 * Resets transformations of a Clutter.Actor.
	 *
	 * @param actor The actor to reset.
	 */
	private void reset_actor(Clutter.Actor actor)
	{
		actor.depth = 0;
		actor.opacity = 255;
		actor.rotation_angle_x = 0;
		actor.rotation_angle_y = 0;
		actor.rotation_angle_z = 0;
		actor.scale_x = 1;
		actor.scale_y = 1;
		actor.x = 0;
		actor.y = 0;
	}
	
	/**
	 * Lays out this SlideActor, replacing the background and rearranging
	 * child actors if necessary.
	 */
	internal void relayout()
	{
		set_background();

		for (unowned List<Clutter.Actor>* itr = contents.get_children();
		     itr != null;
		     itr = itr->next)
		{
			((Actor)(itr->data)).reposition();
		}
	}

	/**
	 * Builds the background actor for this SlideActor.
	 */
	private void set_background()
	{
		if (background == null)
		{
			background = new Clutter.CairoTexture((uint)width_px,
			                                      (uint)height_px);
		}
		
		// render the background
		try
		{
			background.clear();
			var cr = background.create();
			slide.cairo_render_background(cr, (int)width_px,
			                              (int)height_px, false);
		}
		catch (GLib.Error e)
		{
			critical("Error rendering slide actor background: %s", e.message);
		}
		
		background.width = width_px;
		background.height = height_px;
	}
	
	/**
	 * Places all {@link Element}s of this SlideActor in the proper order.
	 */
	private void reorder()
	{
		// TODO: not do this in such an inefficient way
		foreach (var e in slide)
		{
			foreach (var a in contents)
			{
				if ((a as Actor).element == e)
				{
					a.raise_top();
					break;
				}
			}
		}
	}

	/**
	 * Places all child elements of this slide back into the SlideActor.
	 *
	 * Ease has two types of transitions. The first manipulates entire slides.
	 * For this type of transition, the background and contents of the slide
	 * should be stacked into the SlideActor. stack() is used to prepare for
	 * this.
	 *
	 * The second type of transition manipulates the content and backgrounds
	 * separately, typically fading between the backgrounds while moving the
	 * contents around. The contents need to be above both backgrounds in this
	 * case, so they are stacked inside of the container that typically holds
	 * the full SlideActors. unstack() performs this.
	 *
	 * @param container The container that holds the SlideActor and unstacked
	 * elements.
	 */
	internal void stack(Clutter.Actor container)
	{
		if (background.get_parent() != this)
		{
			background.reparent(this);
		}
		if (contents.get_parent() != this)
		{
			contents.reparent(this);
		}
		if (get_parent() != container)
		{
			reparent(container);
		}
	}

	/**
	 * Places all child elements of this slide back into the SlideActor.
	 *
	 * Ease has two types of transitions. The first manipulates entire slides.
	 * For this type of transition, the background and contents of the slide
	 * should be stacked into the SlideActor. stack() is used to prepare for
	 * this.
	 *
	 * The second type of transition manipulates the content and backgrounds
	 * separately, typically fading between the backgrounds while moving the
	 * contents around. The contents need to be above both backgrounds in this
	 * case, so they are stacked inside of the container that typically holds
	 * the full SlideActors. unstack() performs this.
	 *
	 * @param other The other SlideActor to be unstacked.
	 * @param container The container that holds the SlideActor and unstacked
	 * elements.
	 */
	internal void unstack(SlideActor other, Clutter.Actor container)
	{
		if (other.background.get_parent() != container)
		{
			other.background.reparent(container);
		}
		if (background.get_parent() != container)
		{
			background.reparent(container);
		}
		if (contents.get_parent() != container)
		{
			contents.reparent(container);
		}
		if (other.contents.get_parent() != container)
		{
			other.contents.reparent(container);
		}
	}
	
	/**
	 * Prepares for a "slide" transition (manipulation of entire slides).
	 *
	 * This method simply calls stack() for both SlideActors, but could change
	 * in the future.
	 *
	 * @param new_slide The SlideActor that will replace this one.
	 * @param container The container that holds the SlideActors and unstacked
	 * elements.
	 */
	private void prepare_slide_transition(SlideActor new_slide,
	                                      Clutter.Group container)
	{
		new_slide.stack(container);
		stack(container);
	}
	
	/**
	 * Prepares for a "stack" transition (manipulation of entire slides).
	 *
	 * This method simply calls unstack() for both SlideActors, but could
	 * change in the future.
	 */
	private void prepare_stack_transition(bool current_on_top,
	                                      SlideActor new_slide,
	                                      Clutter.Group container)
	{
		unstack(new_slide, container);
	}

	/**
	 * Starts a transition to a new SlideActor.
	 *
	 * This method calls the appropriate method for the current {@link Slide}'s
	 * {@link Transition}.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 */
	internal void transition(SlideActor new_slide,
	                       Clutter.Group container)
	{
		uint length = (uint)Math.fmax(1, slide.transition_time * 1000);

		animation_time = new Clutter.Timeline(length);

		switch (slide.transition)
		{
			case Transition.SLIDE:
				slide_transition(new_slide, container, length);
				break;

			case Transition.DROP:
				drop_transition(new_slide, container, length);
				break;

			case Transition.PIVOT:
				pivot_transition(new_slide, container, length);
				break;

			case Transition.OPEN_DOOR:
				open_door_transition(new_slide, container, length);
				break;

			case Transition.REVEAL:
				reveal_transition(new_slide, container, length);
				break;

			case Transition.SLATS:
				slats_transition(new_slide, container, length);
				break;

			case Transition.FLIP:
				flip_transition(new_slide, container, length);
				break;

			case Transition.REVOLVING_DOOR:
				revolving_door_transition(new_slide, container, length);
				break;

			case Transition.FALL:
				fall_transition(new_slide, container, length);
				break;

			case Transition.SPIN_CONTENTS:
				spin_contents_transition(new_slide, container, length);
				break;

			case Transition.SWING_CONTENTS:
				swing_contents_transition(new_slide, container, length);
				break;

			case Transition.ZOOM:
				zoom_transition(new_slide, container, length);
				break;
			
			case Transition.INTERSPERSE_CONTENTS:
				intersperse_contents_transition(new_slide, container, length);
				break;

			case Transition.SLIDE_CONTENTS:
				slide_contents_transition(new_slide, container, length);
				break;

			case Transition.SPRING_CONTENTS:
				spring_contents_transition(new_slide, container, length);
				break;

			case Transition.ZOOM_CONTENTS:
				zoom_contents_transition(new_slide, container, length);
				break;

			case Transition.PANEL:
				panel_transition(new_slide, container, length);
				break;
			
			case Transition.EXPLODE:
				explode_transition(new_slide, container, length);
				break;
				
			case Transition.ASSEMBLE:
				assemble_transition(new_slide, container, length);
				break;
				
			default: // FADE, or something undefined
				fade_transition(new_slide, container, length);
				break;
		}
		
		animation_time.start();
	}

	/**
	 * Starts a "fade" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void fade_transition(SlideActor new_slide,
	                             Clutter.Group container, uint length)
	{
		prepare_slide_transition(new_slide, container);
		new_slide.opacity = 0;
		new_slide.animate(Clutter.AnimationMode.LINEAR,
		                  length, "opacity", 255);
	}

	/**
	 * Starts a "slide" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void slide_transition(SlideActor new_slide,
	                              Clutter.Group container, uint length)
	{
		switch (slide.variant)
		{
			case TransitionVariant.UP:
				new_slide.y = slide.height;
				new_slide.animate(EASE_SLIDE, length, "y", 0);
				animate(EASE_SLIDE, length, "y", -new_slide.y);
				break;
			
			case TransitionVariant.DOWN:
				new_slide.y = -slide.height;
				new_slide.animate(EASE_SLIDE, length, "y", 0);
				animate(EASE_SLIDE, length, "y", -new_slide.y);
				break;
			
			case TransitionVariant.LEFT:
				new_slide.x = slide.width;
				new_slide.animate(EASE_SLIDE, length, "x", 0);
				animate(EASE_SLIDE, length, "x", -new_slide.x);
				break;
			
			case TransitionVariant.RIGHT:
				new_slide.x = -slide.width;
				new_slide.animate(EASE_SLIDE, length, "x", 0);
				animate(EASE_SLIDE, length, "x", -new_slide.x);
				break;
		}
	}

	/**
	 * Starts a "drop" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void drop_transition(SlideActor new_slide,
	                             Clutter.Group container, uint length)
	{
		new_slide.y = -slide.height;
		new_slide.animate(EASE_DROP, length, "y", 0);
	}

	/**
	 * Starts a "pivot" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void pivot_transition(SlideActor new_slide,
	                              Clutter.Group container, uint length)
	{
		float xpos = 0, ypos = 0, angle = 90;
		switch (slide.variant)
		{
			case TransitionVariant.TOP_RIGHT:
				xpos = slide.width;
				angle = -90;
				break;
			case TransitionVariant.BOTTOM_LEFT:
				ypos = slide.height;
				angle = -90;
				break;
			case TransitionVariant.BOTTOM_RIGHT:
				xpos = slide.width;
				ypos = slide.height;
				break;
		}
		
		// set the new slide's intial angle
		new_slide.set_rotation(Clutter.RotateAxis.Z_AXIS,
		                       angle, xpos, ypos, 0);
		animation_alpha = new Clutter.Alpha.full(animation_time,
		                                         EASE_PIVOT);
		
		// rotate the new slide in
		animation_time.new_frame.connect((m) => {
			new_slide.set_rotation(Clutter.RotateAxis.Z_AXIS,
			                       angle * (1 - animation_alpha.alpha),
			                       xpos, ypos, 0);
		});
	}

	/**
	 * Starts a "flip" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void flip_transition(SlideActor new_slide,
	                             Clutter.Group container, uint length)
	{
		// hide the new slide
		new_slide.opacity = 0;
		
		// timing
		time1 = new Clutter.Timeline(length / 2);
		time2 = new Clutter.Timeline(length / 2);
		alpha1 = new Clutter.Alpha.full(time1,
		                                Clutter.AnimationMode.EASE_IN_SINE);
		alpha2 = new Clutter.Alpha.full(time2,
		                                Clutter.AnimationMode.EASE_OUT_SINE);
		
		// axis to flip on
		Clutter.RotateAxis axis;
		
		// multiplier for angle
		float positive;
		
		// rotation points
		float x_point = 0, y_point = 0;
		
		switch (slide.variant)
		{
			case TransitionVariant.BOTTOM_TO_TOP:
				axis = Clutter.RotateAxis.X_AXIS;
				positive = 1;
				y_point = slide.height / 2;
				break;

			case TransitionVariant.TOP_TO_BOTTOM:
				axis = Clutter.RotateAxis.X_AXIS;
				positive = -1;
				break;

			case TransitionVariant.LEFT_TO_RIGHT:
				axis = Clutter.RotateAxis.Y_AXIS;
				positive = 1;
				x_point = slide.width / 2;
				break;

			default: // RIGHT_TO_LEFT
				axis = Clutter.RotateAxis.Y_AXIS;
				positive = -1;
				x_point = slide.width / 2;
				break;
		}
		
		// animate the first half of the transition
		time1.new_frame.connect((m) => {
			// rotate the slide
			set_rotation(axis, positive * 90 * alpha1.alpha,
			             x_point, y_point, 0);
			
			// zoom the slide in
			depth = (float)(FLIP_DEPTH * alpha1.alpha);
		});

		// animate the second half of the transition
		time2.new_frame.connect((m) => {
			// rotate the slide
			new_slide.set_rotation(axis, positive * -90 * (1 - alpha2.alpha),
			                       x_point, y_point, 0);
			
			// zoom the slide in
			new_slide.depth = FLIP_DEPTH * (float)(1 - alpha2.alpha);
			
			// make the new slide visible
			new_slide.opacity = 255;
		});
		
		time1.completed.connect(() => {
			// hide the current slide
			opacity = 0;
			
			// place the new slide
			new_slide.depth = FLIP_DEPTH;
			
			// start the second half
			time2.start();
		});
		
		// start the transition
		time1.start();
	}

	/**
	 * Starts a "revolving door" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void revolving_door_transition(SlideActor new_slide,
	                                       Clutter.Group container,
	                                       uint length)
	{
		// set the current slide to slightly above the new slide
		depth = 1;

		animation_alpha = new Clutter.Alpha.full(animation_time, EASE_SLIDE);
		
		// the axis of rotation
		Clutter.RotateAxis axis;
		
		// angle multiplier, -1 or 1
		float positive;
		
		// angle rotation points
		float x_point = 0, y_point = 0;
		
		switch (slide.variant)
		{
			case TransitionVariant.LEFT:
				axis = Clutter.RotateAxis.Y_AXIS;
				positive = 1;
				break;
			
			case TransitionVariant.RIGHT:
				axis = Clutter.RotateAxis.Y_AXIS;
				positive = -1;
				x_point = slide.width;
				break;
			
			case TransitionVariant.TOP:
				axis = Clutter.RotateAxis.X_AXIS;
				positive = -1;
				break;
			
			default: // BOTTOM
				axis = Clutter.RotateAxis.X_AXIS;
				positive = 1;
				y_point = slide.height;
				break;
		}
		
		// set the new slide's initial rotation
		new_slide.set_rotation(axis, 90 * positive, x_point, y_point, 0);
		
		animation_time.new_frame.connect((m) => {
			// rotate the new slide in
			new_slide.set_rotation(axis,
			                       positive * 90 * (1 - animation_alpha.alpha),
			                       x_point, y_point, 0);
			
			// rotate the old slide forwards
			set_rotation(axis,
			             positive * -110 * animation_alpha.alpha,
			             x_point, y_point, 0);
		});
	}

	/**
	 * Starts a "reveal" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void reveal_transition(SlideActor new_slide,
	                               Clutter.Group container, uint length)
	{
		(get_parent() as Clutter.Container).raise_child(this, new_slide);

		switch (slide.variant)
		{
			case TransitionVariant.UP:
				animate(EASE_SLIDE, length, "y", -(float)slide.height);
				break;
			case TransitionVariant.DOWN:
				animate(EASE_SLIDE, length, "y", (float)slide.height);
				break;
			case TransitionVariant.LEFT:
				animate(EASE_SLIDE, length, "x", -(float)slide.width);
				break;
			case TransitionVariant.RIGHT:
				animate(EASE_SLIDE, length, "x", (float)slide.width);
				break;
		}
	}

	/**
	 * Starts a "fall" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void fall_transition(SlideActor new_slide,
	                             Clutter.Group container, uint length)
	{
		depth = 1;

		animation_alpha = new Clutter.Alpha.full(animation_time,
		                                   Clutter.AnimationMode.EASE_IN_QUART);
		animation_time.new_frame.connect((m) => {
			set_rotation(Clutter.RotateAxis.X_AXIS,
			             -90 * animation_alpha.alpha,
			             0, slide.height, 0);
		});
	}

	/**
	 * Starts a "slats" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void slats_transition(SlideActor new_slide,
	                              Clutter.Group container, uint length)
	{
		// use depth testing
		Cogl.set_depth_test_enabled(true);
	
		// hide the real SlideActors
		reparent(container);
		new_slide.reparent(container);
		x = slide.width;
		new_slide.x = slide.width;

		// make arrays for the slats
		var this_slats = new Clutter.Clone[SLAT_COUNT];
		var new_slats = new Clutter.Clone[SLAT_COUNT];
		var groups = new Clutter.Group[SLAT_COUNT];

		// calculate the width of each slat
		float width = (float)slide.width / SLAT_COUNT;

		// make the slats
		for (int i = 0; i < SLAT_COUNT; i++)
		{
			// create groups
			groups[i] = new Clutter.Group();
			container.add_actor(groups[i]);

			// create clones
			this_slats[i] = new Clutter.Clone(this);
			groups[i].add_actor(this_slats[i]);
			new_slats[i] = new Clutter.Clone(new_slide);
			groups[i].add_actor(new_slats[i]);

			// clip clones
			this_slats[i].set_clip(width * i, 0,
			                       width, slide.height);
			new_slats[i].set_clip(width * i, 0,
			                      width, slide.height);

			// flip the back slats
			new_slats[i].set_rotation(Clutter.RotateAxis.Y_AXIS,
			                          180, width / 2 + i * width, 0, 0);
			
			// place the new slats behind the current ones
			new_slats[i].depth = -2;
		}

		// make an alpha for easing
		animation_alpha = new Clutter.Alpha.full(animation_time,
		                        Clutter.AnimationMode.EASE_IN_OUT_BACK);

		// animate
		animation_time.new_frame.connect((m) => {
			for (int i = 0; i < SLAT_COUNT; i++)
			{
				groups[i].set_rotation(Clutter.RotateAxis.Y_AXIS,
					                   180 * animation_alpha.alpha,
					                   (i + 0.5f) * width, 0, 0);
				
			}
		});

		animation_time.completed.connect(() => {
			// clean up the slats
			for (int i = 0; i < SLAT_COUNT; i++)
			{
				container.remove_actor(groups[i]);
			}

			// put the new slide in place
			new_slide.x = 0;
			
			// disable depth testing
			Cogl.set_depth_test_enabled(false);
		});
	}

	/**
	 * Starts an "open door" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void open_door_transition(SlideActor new_slide,
	                                  Clutter.Group container,
	                                  uint length)
	{
		// create a reflection of the new slide
		var reflection = new Clutter.Clone(new_slide);
		reflection.rotation_angle_z = 180;
		reflection.rotation_angle_y = 180;
		reflection.y = 2 * slide.height;
		reflection.opacity = REFLECTION_OPACITY;
		
		// zoom the new slide in
		new_slide.depth = OPEN_DEPTH;
		new_slide.animate(Clutter.AnimationMode.EASE_OUT_SINE,
		                  length, "depth", 0);
		
		reflection.depth = OPEN_DEPTH;
		reflection.animate(Clutter.AnimationMode.EASE_OUT_SINE,
		                   length, "depth", 0);
		container.add_actor(reflection);

		animate(Clutter.AnimationMode.LINEAR, length, "opacity", 0);
		reparent(container);
		x = slide.width;

		// create left and right half clone actors
		float width = slide.width / 2f;
		Clutter.Clone left = new Clutter.Clone(this),
		              right = new Clutter.Clone(this);

		left.set_clip(0, 0, width, slide.height);
		right.set_clip(width, 0, width, slide.height);
		
		// create left and right half reflections
		Clutter.Clone left_ref = new Clutter.Clone(left),
		              right_ref = new Clutter.Clone(right);
		
		left_ref.rotation_angle_z = 180;
		left_ref.rotation_angle_y = 180;
		left_ref.y = 2 * slide.height;
		left_ref.opacity = REFLECTION_OPACITY;
		
		right_ref.rotation_angle_z = 180;
		right_ref.rotation_angle_y = 180;
		right_ref.y = 2 * slide.height;
		right_ref.opacity = REFLECTION_OPACITY;
		
		// create left and right groups
		Clutter.Group left_group = new Clutter.Group(),
		              right_group = new Clutter.Group();

		// add actors to groups
		left_group.add_actor(left_ref);
		left_group.add_actor(left);
		right_group.add_actor(right_ref);
		right_group.add_actor(right);		
		
		// add the left and right actors
		container.add_actor(left_group);
		container.add_actor(right_group);

		// move the left and right sides outwards
		left_group.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
		                   length / 2, "x", left.x - width * OPEN_MOVE);

		right_group.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
		                    length / 2, "x", right.x + width * OPEN_MOVE);

		// animate the angles of the left and right sides
		time1 = new Clutter.Timeline((int)(OPEN_TIME * length));
		time2 = new Clutter.Timeline(length);
		animation_alpha = new Clutter.Alpha.full(time1,
		                            Clutter.AnimationMode.EASE_IN_SINE);

		time1.new_frame.connect((m) => {
			left_group.set_rotation(Clutter.RotateAxis.Y_AXIS,
			                        180 * animation_alpha.alpha,
			                        0, 0, 0);

			right_group.set_rotation(Clutter.RotateAxis.Y_AXIS,
			                        -180 * animation_alpha.alpha,
			                        width * 2, 0, 0);
		});

		// clean up
		time1.completed.connect(() => {
			container.remove_actor(left_group);
			container.remove_actor(right_group);
		});

		time1.start();
		time2.start();
	}

	/**
	 * Starts a "zoom" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void zoom_transition(SlideActor new_slide,
	                             Clutter.Group container, uint length)
	{
		switch (slide.variant)
		{
			case TransitionVariant.CENTER:
				new_slide.set_scale_full(0, 0,
				                         slide.width / 2,
				                         slide.height / 2);
				break;
			case TransitionVariant.TOP_LEFT:
				new_slide.set_scale_full(0, 0, 0, 0);
				break;
			case TransitionVariant.TOP_RIGHT:
				new_slide.set_scale_full(0, 0, slide.width, 0);
				break;
			case TransitionVariant.BOTTOM_LEFT:
				new_slide.set_scale_full(0, 0, 0, slide.height);
				break;
			case TransitionVariant.BOTTOM_RIGHT:
				new_slide.set_scale_full(0, 0,
				                         slide.width,
				                         slide.height);
				break;
			case TransitionVariant.LEFT:
				new_slide.set_scale_full(0, 0, 0, slide.height / 2);
				break;
			case TransitionVariant.RIGHT:
				new_slide.set_scale_full(0, 0, slide.width, slide.height / 2);
				break;
			case TransitionVariant.TOP:
				new_slide.set_scale_full(0, 0, slide.width / 2, 0);
				break;
			case TransitionVariant.BOTTOM:
				new_slide.set_scale_full(0, 0, slide.width / 2, slide.height);
				break;
		}
		animation_alpha = new Clutter.Alpha.full(animation_time,
		                                   Clutter.AnimationMode.EASE_OUT_SINE);
		
		animation_time.new_frame.connect((m) => {
			new_slide.set_scale(animation_alpha.alpha, animation_alpha.alpha);
		});
	}

	/**
	 * Starts a "panel" transition.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void panel_transition(SlideActor new_slide,
	                              Clutter.Group container, uint length)
	{
		float pos = 0;
		string property="";
		
		switch (slide.variant)
		{
			case TransitionVariant.UP:
				pos = slide.height;
				property = "y";
				break;
			case TransitionVariant.DOWN:
				pos = -slide.height;
				property = "y";
				break;
			case TransitionVariant.LEFT:
				pos = slide.width;
				property = "x";
				break;
			default:
				pos = -slide.width;
				property = "x";
				break;
		}

		time1 = new Clutter.Timeline(length / 4);
		time2 = new Clutter.Timeline(3 * length / 4);
		new_slide.set_scale_full(PANEL_SCALE, PANEL_SCALE,
		                         slide.width / 2,
		                         slide.height / 2);

		new_slide.set_property(property, pos);
		alpha1 = new Clutter.Alpha.full(time1,
		                                Clutter.AnimationMode.EASE_IN_OUT_SINE);

		time1.new_frame.connect((m) => {
			set_scale_full(PANEL_SCALE + (1 - PANEL_SCALE) *
			                                (1 - alpha1.alpha),
			               PANEL_SCALE + (1 - PANEL_SCALE) *
			                                (1 - alpha1.alpha),
				           slide.width / 2, slide.height / 2);
		});
		time1.completed.connect(() => {
			animate(Clutter.AnimationMode.EASE_IN_OUT_SINE, length / 2,
			        property, -pos);
			
			new_slide.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
			                  length / 2, property, 0.0f);
		});
		time2.completed.connect(() => {
			time1.new_frame.connect((m) => {
				new_slide.set_scale_full(PANEL_SCALE +
				                          (1 - PANEL_SCALE) * alpha1.alpha,
				                         PANEL_SCALE +
				                          (1 - PANEL_SCALE) * alpha1.alpha,
					                     slide.width / 2,
					                     slide.height / 2);
			});
			time1.start();
		});
		time1.start();
		time2.start();
	}

	/**
	 * Starts a "spin contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void spin_contents_transition(SlideActor new_slide,
	                                      Clutter.Group container,
	                                      uint length)
	{
		prepare_stack_transition(false, new_slide, container);

		new_slide.contents.opacity = 0;
		background.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE, length,
		                   "opacity", 0);
		time1 = new Clutter.Timeline(length / 2);
		time2 = new Clutter.Timeline(length / 2);
		alpha1 = new Clutter.Alpha.full(time1,
		                                Clutter.AnimationMode.EASE_IN_SINE);

		alpha2 = new Clutter.Alpha.full(time2,
		                                Clutter.AnimationMode.EASE_OUT_SINE);

		float angle = slide.variant == TransitionVariant.LEFT ? -90 : 90;
		time1.completed.connect(() => {
			contents.opacity = 0;
			time2.start();
		});
		time1.new_frame.connect((m) => {
			contents.set_rotation(Clutter.RotateAxis.Y_AXIS,
			                      angle * alpha1.alpha,
			                      slide.width / 2, 0, 0);
		});
		time2.new_frame.connect((m) => {
			new_slide.contents.opacity = 255;
			new_slide.contents.set_rotation(Clutter.RotateAxis.Y_AXIS,
			                                -angle * (1 - alpha2.alpha),
			                                 slide.width / 2, 0, 0);
		});
		time1.start();
	}

	/**
	 * Starts a "swing contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void swing_contents_transition(SlideActor new_slide,
	                                       Clutter.Group container,
	                                       uint length)
	{
		prepare_stack_transition(false, new_slide, container);

		new_slide.contents.opacity = 0;
		background.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
		                   length, "opacity", 0);
		
		time1 = new Clutter.Timeline(3 * length / 5);
		time2 = new Clutter.Timeline(2 * length / 5);
		
		alpha1 = new Clutter.Alpha.full(time1,
		                                Clutter.AnimationMode.EASE_IN_SINE);
		                                
		alpha2 = new Clutter.Alpha.full(time2,
		                                Clutter.AnimationMode.EASE_OUT_BACK);
		
		time1.new_frame.connect((m) => {
			foreach (var actor in contents)
			{
				actor.set_rotation(Clutter.RotateAxis.X_AXIS,
				                   270 * alpha1.alpha, 0, 0, 0);
			}
		});
		
		time2.new_frame.connect((m) => {
			foreach (var actor in new_slide.contents)
			{
				actor.set_rotation(Clutter.RotateAxis.X_AXIS,
				                   270 + 90 * alpha2.alpha, 0, 0, 0);
			}
		});
		
		time1.completed.connect(() => {
			time2.start();
			new_slide.contents.opacity = 255;
			contents.opacity = 0;
			foreach (var actor in new_slide.contents)
			{
				actor.set_rotation(Clutter.RotateAxis.X_AXIS, 270, 0, 0, 0);
			}
		});
		
		time2.completed.connect(() => {
			foreach (var actor in new_slide.contents)
			{
				actor.set_rotation(Clutter.RotateAxis.X_AXIS, 0, 0, 0, 0);
			}
		});
		
		time1.start();
	}

	/**
	 * Starts a "slide contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void slide_contents_transition(SlideActor new_slide,
	                                       Clutter.Group container,
	                                       uint length)
	{
		prepare_stack_transition(false, new_slide, container);

		background.animate(EASE_SLIDE, length, "opacity", 0);
		
		switch (slide.variant)
		{
			case TransitionVariant.RIGHT:
				new_slide.contents.x = -slide.width;
				new_slide.contents.animate(EASE_SLIDE, length, "x", 0);

				contents.animate(EASE_SLIDE,
				                 length, "x", -new_slide.contents.x);
				break;
			case TransitionVariant.LEFT:
				new_slide.contents.x = slide.width;
				new_slide.contents.animate(EASE_SLIDE, length, "x", 0);

				contents.animate(EASE_SLIDE,
				                 length, "x", -new_slide.contents.x);
				break;
			case TransitionVariant.UP:
				new_slide.contents.y = slide.height;
				new_slide.contents.animate(EASE_SLIDE, length, "y", 0);

				contents.animate(EASE_SLIDE,
				                 length, "y", -new_slide.contents.y);
				break;
			case TransitionVariant.DOWN:
				new_slide.contents.y = -slide.height;
				new_slide.contents.animate(EASE_SLIDE, length, "y", 0);

				contents.animate(EASE_SLIDE,
				                 length, "y", -new_slide.contents.y);
				break;
		}
	}

	/**
	 * Starts a "spring contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void spring_contents_transition(SlideActor new_slide,
	                                        Clutter.Group container,
	                                        uint length)
	{
		prepare_stack_transition(false, new_slide, container);

		background.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE, length,
		                   "opacity", 0);

		switch (slide.variant)
		{
			case TransitionVariant.UP:
				new_slide.contents.y = slide.height * 1.2f;
				new_slide.contents.animate(Clutter.AnimationMode.EASE_IN_OUT_ELASTIC,
				                           length, "y", 0);
				contents.animate(Clutter.AnimationMode.EASE_IN_OUT_ELASTIC,
				                 length, "y", -slide.height * 1.2);
				break;
			case TransitionVariant.DOWN:
				new_slide.contents.y = -slide.height * 1.2f;
				new_slide.contents.animate(Clutter.AnimationMode.EASE_IN_OUT_ELASTIC,
				                           length, "y", 0);
				contents.animate(Clutter.AnimationMode.EASE_IN_OUT_ELASTIC,
				                 length, "y", slide.height * 1.2);
				break;
		}
	}
	
	/**
	 * Starts a "intersperse contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void intersperse_contents_transition(SlideActor new_slide,
	                                          Clutter.Group container,
	                                          uint length)
	{
		prepare_stack_transition(false, new_slide, container);
		background.animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
		                   length, "opacity", 0);
		alpha1 = new Clutter.Alpha.full(animation_time,
		                                Clutter.AnimationMode.EASE_IN_SINE);
		                                
		alpha2 = new Clutter.Alpha.full(animation_time,
		                                Clutter.AnimationMode.EASE_OUT_SINE);
		                                
		animation_alpha = new Clutter.Alpha.full(animation_time,
		                                         Clutter.AnimationMode.LINEAR);
		
		float target_x = 0, target_y = 0, orig_x, orig_y;
		
		foreach (var actor in contents)
		{
			get_intersperse_coords(actor, out target_x, out target_y);
			
			actor.animate(Clutter.AnimationMode.EASE_IN_SINE, length,
			              "y", target_y,
			              "x", target_x);
		}
		
		foreach (var actor in new_slide.contents)
		{
			// store the original position
			orig_x = actor.x;
			orig_y = actor.y;
			
			// find the interspersed position
			get_intersperse_coords(actor, out target_x, out target_y);
			
			// set the actor off stage
			actor.x = target_x;
			actor.y = target_y;
			
			// animate back on screen
			actor.animate(Clutter.AnimationMode.EASE_OUT_SINE, length,
			              "y", orig_y,
			              "x", orig_x);
		}
	}
	
	private void get_intersperse_coords(Clutter.Actor actor, out float target_x,
	                                                      out float target_y)
	{
		var center_x = slide.width / 2;
		var center_y = slide.height / 2;
		
		if ((actor.x + actor.width / 2) - center_x == 0)
		{
			target_x = actor.x;
			target_y = (actor.y + actor.height / 2) > center_y ?
			           slide.height : -actor.height;
			return;
		}
		
		var m = ((actor.y + actor.height / 2) - center_y) /
		        ((actor.x + actor.width / 2) - center_x);
			
		var angle = Math.fmod(Math.atan2(m, 1), Math.PI * 2);
		
		if (m == 0)
		{
			target_x = (actor.x + actor.width / 2) > center_x ?
			           slide.width : -actor.width;
			target_y = actor.y;
		}
		else if (angle > Math.PI * 1.75 || angle <= Math.PI * 0.25)
		{
			target_x = slide.width;
			target_y = m * target_x + center_y;
		}
		else if (angle > Math.PI * 0.25 || angle <= Math.PI * 0.75)
		{
			target_y = -actor.height;
			target_x = (target_y - center_y) / m;
		}
		else if (angle > Math.PI * 0.75 || angle <= Math.PI * 1.25)
		{
			target_x = -actor.width;
			target_y = m * target_x + center_y;
		}
		else
		{
			target_y = slide.height;
			target_x = (target_y - center_y) / m;
		}
	}

	/**
	 * Starts a "zoom contents" transition. This transition unstacks the
	 * SlideActors.
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void zoom_contents_transition(SlideActor new_slide,
	                                      Clutter.Group container,
	                                      uint length)
	{
		prepare_stack_transition(slide.variant == TransitionVariant.OUT,
		                         new_slide, container);

		animation_alpha = new Clutter.Alpha.full(animation_time,
		                                Clutter.AnimationMode.EASE_IN_OUT_SINE);

		background.animate(Clutter.AnimationMode.LINEAR, length, "opacity", 0);
		switch (slide.variant)
		{
			case TransitionVariant.IN:
				new_slide.contents.set_scale_full(0, 0,
				                                  slide.width / 2,
				                                  slide.height / 2);

				contents.set_scale_full(1, 1,
				                        slide.width / 2,
				                        slide.height / 2);

				contents.animate(Clutter.AnimationMode.LINEAR, length / 2, "opacity", 0);
				animation_time.new_frame.connect((m) => {
					new_slide.contents.set_scale(animation_alpha.alpha,
					                             animation_alpha.alpha);

					contents.set_scale(1.0 + 2 * animation_alpha.alpha,
					   	               1.0 + 2 * animation_alpha.alpha);
				});
				break;
			case TransitionVariant.OUT:
				new_slide.contents.set_scale_full(0, 0,
				                                  slide.width / 2,
				                                  slide.height / 2);

				contents.set_scale_full(1, 1,
				                        slide.width / 2,
				                        slide.height / 2);

				new_slide.contents.opacity = 0;
				new_slide.contents.animate(Clutter.AnimationMode.EASE_IN_SINE,
				                           length / 2, "opacity", 255);
				animation_time.new_frame.connect((m) => {
					new_slide.contents.set_scale(1.0 + 2 * (1 - animation_alpha.alpha),
						                         1.0 + 2 * (1 - animation_alpha.alpha));
					contents.set_scale(1 - animation_alpha.alpha,
					   	               1 - animation_alpha.alpha);
				});
				break;
		}
	}
	
	/**
	 * Starts an "Explode" transition
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void explode_transition(SlideActor new_slide,
	                                Clutter.Group container,
	                                uint length)
	{
		// hide the real SlideActor
		reparent(container);
		new_slide.reparent(container);
		x = slide.width;

		// make an array for the particles
		var v_count = (int)Math.ceil(1 / slide.aspect * EXPLODE_PARTICLES);
		var count = EXPLODE_PARTICLES * v_count;
		var particles = new Clutter.Clone[count];
		
		// calculate the size of each particle
		var size = (float)slide.width / EXPLODE_PARTICLES;
		float center_x = slide.width / 2;
		float center_y = slide.height / 2;

		// create the particles
		int i;
		for (int vpos = 0; vpos < v_count; vpos++)
		{
			for (int hpos = 0; hpos < EXPLODE_PARTICLES; hpos++)
			{
				// make a new particle
				i = vpos * EXPLODE_PARTICLES + hpos;
				particles[i] = new Clutter.Clone(this);
				
				// clip the particle
				particles[i].set_clip(hpos * size, vpos * size, size, size);
				
				var atan = Math.atan2f(center_y - vpos * size,
				                       center_x - hpos * size);
				
				// move to the target position
				particles[i].animate(Clutter.AnimationMode.EASE_IN_SINE,
				                     explode_time(length),
				                     "x", -Math.cosf(atan) * explode_dist(),
				                     "y", -Math.sinf(atan) * explode_dist(),
				                     "depth", explode_depth(),
				                     "opacity", 0);
				
				container.add_actor(particles[i]);
				particles[i].show();
			}
		}
		
		// cleanup
		animation_time.completed.connect(() => {
			for (int j = 0; j < count; j++)
			{
				container.remove_actor(particles[j]);
			}
		});
	}
	
	/**
	 * Starts an "Assemble" transition
	 *
	 * @param new_slide The new SlideActor.
	 * @param container The container that holds the displayed SlideActors.
	 * @param length The length of the transition, in milliseconds.
	 */
	private void assemble_transition(SlideActor new_slide,
	                                Clutter.Group container,
	                                uint length)
	{
		// hide the real new SlideActor
		new_slide.reparent(container);
		new_slide.x = slide.width;

		// make an array for the particles
		var v_count = (int)Math.ceil(1 / slide.aspect * ASSEMBLE_TILES);
		var count = ASSEMBLE_TILES * v_count;
		var particles = new Clutter.Clone[count];
		
		// calculate the size of each particle
		var size = (float)slide.width / ASSEMBLE_TILES;

		// create the particles
		int i;
		for (int vpos = 0; vpos < v_count; vpos++)
		{
			for (int hpos = 0; hpos < ASSEMBLE_TILES; hpos++)
			{
				// make a new particle
				i = vpos * ASSEMBLE_TILES + hpos;
				particles[i] = new Clutter.Clone(new_slide);
				
				// clip the particle
				particles[i].set_clip(hpos * size, vpos * size,
				                      size + 1, size + 1);
				
				// randomly move the particle off of the screen
				var anim_x = false;
				switch (Random.int_range(0, 4))
				{
					case 0:
						particles[i].x = -(hpos + 1) * size - assemble_extra();
						anim_x = true;
						break;
					case 1:
						particles[i].y = -(vpos + 1) * size - assemble_extra();
						break;
					case 2:
						particles[i].x = (ASSEMBLE_TILES - hpos + 1) * size +
						                 assemble_extra();
						anim_x = true;
						break;
					case 3:
						particles[i].y = (v_count - vpos + 1) * size +
						                 assemble_extra();
						break;
				}
				
				particles[i].animate(Clutter.AnimationMode.EASE_IN_OUT_SINE,
					                 length, anim_x ? "x" : "y", 0);
				container.add_actor(particles[i]);
				particles[i].show();
			}
		}

		// cleanup
		animation_time.completed.connect(() => {
			new_slide.x = 0;
			for (int j = 0; j < count; j++)
			{
				if (particles[j].get_parent() == container)
				{
					container.remove_actor(particles[j]);
				}
			}		
		});
	}
	
	private float assemble_extra()
	{
		return Random.int_range(0, 1000);
	}
	
	private float explode_dist()
	{
		return Random.int_range(10, 200);
	}
	
	private float explode_depth()
	{
		return Random.int_range(-5, 50);
	}
	
	private uint explode_time(uint time)
	{
		return (uint)(0.25 * time + Random.next_double() * 0.75 * time);
	}

	/**
	 * Clamps a double to an opacity value, an unsigned 8-bit integer.
	 */
	private static uint8 clamp_opacity(double o)
	{
		return (uint8)(Math.fmax(0, Math.fmin(255, o)));
	}
}

