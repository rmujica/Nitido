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
 * An animated {@link ZoomSlider}.
 *
 * AnimatedZoomSlider smoothly animates (with ClutterAnimation)
 * when the + or - buttons are pressed.
 */
public class Ease.AnimatedZoomSlider : ZoomSlider, Clutter.Animatable
{
	private Clutter.Animation zoom_anim;
	private const int ZOOM_TIME = 100;
	private const int ZOOM_MODE = Clutter.AnimationMode.EASE_IN_OUT_SINE;
	
	/**
	 * Whether or not the AnimatedZoomSlider should animate its zoom when the
	 * + and - buttons are clicked. Setting this to false will make the
	 * AnimatedZoomSlider perform identically to a {@link ZoomSlider}.
	 *
	 * Set to "true" by default.
	 */
	public bool animate { get; set; default = true; }
	
	/** 
	 * Creates a new AnimatedZoomSlider.
	 *
	 * @param adjustment The Gtk.Adjustment to use.
	 * @param button_values The values that the slider should stop on when the
	 * zoom in and out buttons are pressed.
	 */
	public AnimatedZoomSlider(Gtk.Adjustment adjustment, int[] button_values)
	{
		base(adjustment, button_values);
	}
	
	/**
	 * {@inheritDoc}
	 *
	 * If {@link animate} is set to true, this will be a smoothed transition.
	 */
	protected override void change_zoom(double value)
	{
		if (animate)
		{
			zoom_anim = new Clutter.Animation();
			zoom_anim.object = this;
			zoom_anim.bind("sliderpos", value);
			zoom_anim.duration = ZOOM_TIME;
			zoom_anim.mode = ZOOM_MODE;
			zoom_anim.timeline.start();
		}
		else base.change_zoom(value);
	}
	
	private bool animate_property(Clutter.Animation animation,
	                                      string property_name,
	                                      GLib.Value initial_value,
	                                      GLib.Value final_value,
	                                      double progress,
	                                      GLib.Value value)
	{
		if (property_name != "sliderpos") { return false; }
		
		value.set_double(initial_value.get_double() * (1 - progress) + 
		                 final_value.get_double() * progress);
		return true;
	}
}
