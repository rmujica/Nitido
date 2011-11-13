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
 * {@link Theme} tiles within the {@link WelcomeWindow}
 *
 * Each WelcomeActor is a preview of a {@link Theme}. The user can
 * click on these to create a new {@link Document} with that {@link Theme}.
 */
internal class Ease.WelcomeActor : Clutter.Group
{
	/**
	 * If this WelcomeActor is currently selected.
	 */
	private bool is_selected = false;
	
	/**
	 * A CairoTexture used to render the slide preview.
	 */
	private Clutter.CairoTexture slide_actor;
	
	/**
	 * A black background rectangle placed behind the slide preview.
	 *
	 * When the slide preview's opacity is lowered, this rectangle causes the
	 * preview to appear dark, rather than translucent.
	 */
	private Clutter.Rectangle rect;
	
	/**
	 * A highlight rectangle placed around the actor when it is selected.
	 */
	private Clutter.Rectangle hilight_rect;
	
	/**
	 * The theme previewed by this WelcomeActor.
	 */
	internal Theme theme { get; set; }
	
	// display the name of the theme
	private const string FONT_NAME = "Sans 8";
	private const float TEXT_OFFSET = 5;
	private const float TEXT_HEIGHT = 12;
	private const Clutter.Color TEXT_COLOR = {255, 255, 255, 255};
	private Clutter.Text text;
	
	// fade constants
	private const int FADE_TIME = 200;
	private const int FADE_INIT_TIME = 1000;
	private const int FADE_EASE = Clutter.AnimationMode.EASE_IN_OUT_SINE;
	private const int FADE_OPACITY = 150;
	
	// rectangle appearance
	private const Clutter.Color RECT_BG = {0, 0, 0, 255};
	private const Clutter.Color RECT_B_C = {150, 150, 150, 255};
	private const int RECT_B_W = 1;
	private const Clutter.Color HLRECT_C = {255, 255, 0, 255};
	private const int HLRECT_W = 2;
	
	/**
	 * The slide identifier to display as a preview.
	 */
	private const string PREVIEW_SLIDE = Theme.TITLE;
	
	/**
	 * Triggered when the slide preview is selected (single click).
	 */
	internal signal void selected(WelcomeActor sender);
	
	/**
	 * Triggered when the slide preview is double clicked.
	 */
	internal signal void double_click(WelcomeActor sender);
	
	/**
	 * Instantiates a WelcomeActor.
	 *
	 * @param t The theme that this WelcomeActor will display.
	 */
	internal WelcomeActor(Theme t)
	{
		theme = t;
		reactive = true;
		
		// create the background rectangle actor
		rect = new Clutter.Rectangle();
		rect.color = RECT_BG;
		rect.border_color = RECT_B_C;
		rect.border_width = RECT_B_W;
		rect.x = -RECT_B_W;
		rect.y = -RECT_B_W;
		add_actor(rect);
		
		// create the highlight rectangle
		hilight_rect = new Clutter.Rectangle();
		hilight_rect.color = {0, 0, 0, 255};
		hilight_rect.opacity = 0;
		hilight_rect.border_color = HLRECT_C;
		hilight_rect.border_width = HLRECT_W;
		hilight_rect.x = -HLRECT_W;
		hilight_rect.y = -HLRECT_W;
		add_actor(hilight_rect);
		
		// create the theme title actor
		text = new Clutter.Text.full(FONT_NAME, theme.title, TEXT_COLOR);
		text.height = TEXT_HEIGHT;
		text.line_alignment = Pango.Alignment.RIGHT;
		add_actor(text);
		
		// create the slide preview texture
		slide_actor = new Clutter.CairoTexture(1024, 768);
		add_actor(slide_actor);
		
		// fade the preview in
		opacity = 0;
		animate(FADE_EASE, FADE_INIT_TIME, "opacity", 255);
		
		// respond to click events
		button_press_event.connect((self, event) => {
            if (event.click_count == 2) {
				double_click(this);
				return false;
			}
			
			if (!is_selected) selected(this);
			return false;
		});
	}
	
	/**
	 * Sets the slide preview size.
	 *
	 * @param w The width of the slide.
	 * @param h The height of the slide.
	 */
	internal void set_slide_size(int w, int h)
	{
		// set the surface size
		slide_actor.set_surface_size((uint)w, (uint)h);
		
		// render
		try
		{
			var slide = create_slide(w, h);
			slide.cairo_render_sized(slide_actor.create(), w, h);
		}
		catch (GLib.Error e)
		{
			critical(_("Error rendering preview: %s"), e.message);
		}
	}
	
	/**
	 * Sets the size of the slide preview actor.
	 *
	 * This method does not redraw the preview, it simply scales it.
	 *
	 * @param w The width of the actor.
	 * @param h The height of the actor.
	 */
	internal void set_actor_size(float w, float h)
	{
		rect.width = Math.roundf(w) + RECT_B_W * 2;
		rect.height = Math.roundf(h) + RECT_B_W * 2;
		
		hilight_rect.width = Math.roundf(w) + HLRECT_W * 2;
		hilight_rect.height = Math.roundf(h) + HLRECT_W * 2;
		
		text.x = Math.roundf(w / 2 - text.width / 2);
		text.y = Math.roundf(h + TEXT_OFFSET);
		
		if (slide_actor != null)
		{
			slide_actor.width = Math.roundf(w);
			slide_actor.height = Math.roundf(h);
		}
	}
	
	/**
	 * Brings the preview to full brightness.
	 */
	internal void fade()
	{
		is_selected = false;
		slide_actor.animate(FADE_EASE, FADE_TIME, "opacity", FADE_OPACITY);
		hilight_rect.animate(FADE_EASE, FADE_TIME, "opacity", 0);
	}
	
	/**
	 * Dims the preview.
	 */
	internal void unfade()
	{
		is_selected = true;
		slide_actor.animate(FADE_EASE, FADE_TIME, "opacity", 255);
		hilight_rect.animate(FADE_EASE, FADE_TIME, "opacity", 255);
	}
	
	/**
	 * Creates a slide for preview of the given width and height.
	 *
	 * This method creates a slide from the WelcomeActor's {@link Theme},
	 * and substitutes some appropriate "preview" properties for specified
	 * elements. For example, the user's "real name" is placed in the "author"
	 * field.
	 *
	 * @param w The width of the slide to create.
	 * @param h The height of the slide to create.
	 */
	private Slide create_slide(int w, int h)
	{
		var slide = theme.create_slide(PREVIEW_SLIDE, w, h);
		
		foreach (var element in slide)
		{
			element.has_been_edited = true;
			switch (element.identifier)
			{
				case Theme.TITLE_TEXT:
					(element as TextElement).text = theme.title;
					break;
				case Theme.AUTHOR_TEXT:
					(element as TextElement).text = Environment.get_real_name();
					break;
			}
		}
		
		return slide;
	}
}

