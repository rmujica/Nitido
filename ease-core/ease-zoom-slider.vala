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
 * A zoom widget containing a Gtk.HScale and two (+/-) buttons.
 *
 * ZoomSlider uses ClutterAnimation to smoothly adjust the slider when th
 * zoom in or zoom out button is clicked.
 */
public class Ease.ZoomSlider : Gtk.Alignment
{
	private Gtk.HScale zoom_slider;
	private Gtk.Button zoom_in_button;
	private Gtk.Button zoom_out_button;
	
	/** 
	 * The position of the zoom slider's value.
	 */
	public Gtk.PositionType value_pos
	{
		get { return zoom_slider.value_pos; }
		set { zoom_slider.value_pos = value; }
	}
	
	/** 
	 * The number of digits that the zoom slider displays.
	 */
	public int digits
	{
		get { return zoom_slider.digits; }
		set { zoom_slider.digits = value; }
	}
	
	/**
	 * The position of the zoom slider.
	 */
	public double sliderpos
	{
		get { return zoom_slider.get_value(); }
		set { zoom_slider.set_value(value); }
	}
	
	/**
	 * The update policy of the slider.
	 */
	public Gtk.UpdateType update_policy
	{
		get { return zoom_slider.update_policy; }
		set { zoom_slider.update_policy = value; }
	}
	
	/**
	 * Private store for buttons_shown property.
	 */
	private bool buttons_shown_priv = true;
	
	/**
	 * If the + and - buttons should be shown. Defaults to true.
	 */
	public bool buttons_shown
	{
		get { return buttons_shown; }
		set
		{
			if (value == buttons_shown_priv) return;
			
			buttons_shown_priv = value;
			zoom_in_button.visible = value;
			zoom_out_button.visible = value;
		}
	}
	
	/**
	 * The adjustment of the slider.
	 */
	public Gtk.Adjustment adjustment
	{
		get { return zoom_slider.adjustment; }
		set { zoom_slider.adjustment = value; }
	}
	
	/**
	 * The values on which the slider should stop when the +/- buttons are
	 * clicked.
	 */
	public int[] values;
	
	/** 
	 * Creates a new ZoomSlider.
	 *
	 * @param adjustment The Gtk.Adjustment to use.
	 * @param button_values The values that the slider should stop on when the
	 * zoom in and out buttons are pressed.
	 */
	public ZoomSlider(Gtk.Adjustment adjustment, int[] button_values)
	{
		values = button_values;
		
		var hbox = new Gtk.HBox(false, 5);
		
		// create zoom slider
		zoom_slider = new Gtk.HScale(adjustment);
		zoom_slider.width_request = 200;
		zoom_slider.draw_value = false;
		zoom_slider.digits = 0;
		
		// zoom in button
		zoom_in_button = new Gtk.Button();
		zoom_in_button.add(new Gtk.Image.from_stock("gtk-zoom-in",
		                                            Gtk.IconSize.MENU));
		zoom_in_button.relief = Gtk.ReliefStyle.NONE;
		
		// zoom out button
		zoom_out_button = new Gtk.Button();
		zoom_out_button.add(new Gtk.Image.from_stock("gtk-zoom-out",
		                                             Gtk.IconSize.MENU));
		zoom_out_button.relief = Gtk.ReliefStyle.NONE;
		
		// put it all together
		var align = new Gtk.Alignment(0, 0.5f, 1, 0);
		align.add(zoom_out_button);
		hbox.pack_start(align, false, false, 0);
		
		align = new Gtk.Alignment(0, 0.5f, 1, 0);
		align.add(zoom_slider);
		hbox.pack_start(align, false, false, 0);
		
		align = new Gtk.Alignment(0, 0.5f, 1, 0);
		align.add(zoom_in_button);
		hbox.pack_start(align, false, false, 0);
		
		set(1, 1, 1, 1);
		add(hbox);
		
		zoom_slider.value_changed.connect(() => value_changed());
		
		zoom_in_button.clicked.connect(() => zoom_in());
		
		zoom_out_button.clicked.connect(() => zoom_out());
		
		zoom_in_button.show.connect(buttons_show_handler);
		zoom_out_button.show.connect(buttons_show_handler);
		
		zoom_slider.format_value.connect(val => {
			return "%i%%".printf((int)val);
		});
	}
	
	private void buttons_show_handler(Gtk.Widget sender)
	{
		buttons_shown_priv = true;
	}
	
	/** 
	 * Returns the value of the zoom slider.
	 */
	public double get_value()
	{
		return zoom_slider.get_value();
	}
	
	public void zoom_out()
	{
		for (var i = values.length - 1; i > -1; i--)
		{
			if (zoom_slider.get_value() > values[i])
			{
				change_zoom(values[i]);
				break;
			}
		}
	}
	
	public void zoom_in()
	{
		for (var i = 0; i < values.length; i++)
		{
			if (zoom_slider.get_value() < values[i])
			{
				change_zoom(values[i]);
				break;
			}
		}
	}
	
	protected virtual void change_zoom(double value)
	{
		sliderpos = value;
	}
	
	/** 
	 * Fires when the value of the zoom slider changes.
	 */
	public signal void value_changed();
}
