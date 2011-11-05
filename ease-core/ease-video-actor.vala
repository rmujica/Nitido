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
 * {@link Actor} for videos
 *
 * VideoActor uses Clutter-GStreamer, and therefore supports any video
 * format supported by the GStreamer plugins on the user's system.
 *
 * VideoActor "implements" Clutter.Media by passing through all function calls
 * to its VideoTexture.
 */
public class Ease.VideoActor : Actor, Clutter.Media
{
	/**
	 * The VideoTexture displayed by this VideoActor.
	 */
	private ClutterGst.VideoTexture video;
	
	/**
	 * The "play" button in a presentation.
	 */
	private Clutter.Texture action_button;
	
	/**
	 * The textured overlayed on the video when it is not playing.
	 */
	private Clutter.CairoTexture gloss;
	
	/**
	 * The path to the "play" button svg.
	 */
	private const string PLAY_PATH =
		Path.build_filename("svg", "video-play-button.svg");
	
	/**
	 * A group to contain the video actor and the play button.
	 */
	private Clutter.Group group;
	
	/**
	 * The amount of time it takes for the button to fade out.
	 */
	private const int BUTTON_TIME = 500;
	
	/**
	 * Easing for the button fadeout.
	 */
	private const Clutter.AnimationMode ALPHA_OPACITY = Clutter.AnimationMode.LINEAR;
	
	/**
	 * Easing for the button scale out.
	 */
	private const int ALPHA_SCALE = Clutter.AnimationMode.EASE_IN_BACK;
	
	/**
	 * Easing for the button scale in.
	 */
	private const int ALPHA_SCALE_IN = Clutter.AnimationMode.EASE_OUT_BACK;
	
	/**
	 * Start alarm.
	 */
	private Clutter.Timeline timeline;
	
	/**
	 * Fade in alarm.
	 */
	private Clutter.Timeline timeline_in;

	/**
	 * Instantiates a new VideoActor from an Element.
	 * 
	 * The VideoActor's context is particularly important due to playback.
	 * Playing back automatically in the editor would, of course, not be
	 * desired.
	 *
	 * @param e The represented element.
	 * @param c The context of this Actor (Presentation, Sidebar, Editor)
	 */
	public VideoActor(VideoElement e, ActorContext c)
	{
		base(e, c);

		video = new ClutterGst.VideoTexture();
		video.set_filename(Path.build_filename(e.parent.parent.path,
		                                       e.filename));
		group = new Clutter.Group();
		group.add_actor(video);

		// play the video if it's in the presentation
		if (c == ActorContext.PRESENTATION)
		{
			// mute the video if requested
			set_audio_volume(e.mute ? 0 : 1);
			
			// if the video should automatically play, play it
			if (e.play_auto)
			{
				video.set_playing(true);
				video.reactive = true;
				create_paused_ui(e, false);
			}
			else
			{
				// get a video frame to display (dimmed maybe?)
				video.set_playing(true);
				video.set_playing(false);
				create_paused_ui(e, true);
			}
			
			// show the pause ui when the video is paused
			video.button_press_event.connect((a, event) => {
				video.reactive = false;
				video.set_playing(false);
				
				// set overlay scale and alpha to 0
				action_button.scale_x = 1;
				action_button.scale_y = 1;
			
				// create an alarm
				timeline_in = new Clutter.Timeline(BUTTON_TIME);
				timeline_in.completed.connect(() => {
					action_button.reactive = true;
				});
				timeline_in.start();
			
				// do the animations
				gloss.animate(ALPHA_OPACITY, BUTTON_TIME, "opacity", 255);
				action_button.animate(ALPHA_OPACITY, BUTTON_TIME,
					                  "opacity", 255);
				return true;
			});
			
			// perform the video's end action when requested
			video.eos.connect((v) => {
				switch ((element as VideoElement).end_action)
				{
					case VideoEndAction.STOP:
						break;
					case VideoEndAction.LOOP:
						set_progress(0);
						video.set_playing(true);
						break;
					case VideoEndAction.CONTINUE:
						element.request_advance();
						break;
				}
			});
		}
		else
		{
			// FIXME: toggle playback to get a frame
			set_audio_volume(0);
			video.set_playing(true);
			video.set_playing(false);
		}
		
		contents = group;

		add_actor(contents);
		contents.width = e.width;
		contents.height = e.height;
		x = e.x;
		y = e.y;
		
		autosize(video);
	}
	
	private void create_paused_ui(VideoElement e, bool active)
	{
		// create the glossy overlay
		gloss = new Clutter.CairoTexture((int)e.width, (int)e.height);
		gloss.set_surface_size((int)e.width, (int)e.height);
		gloss.opacity = 100;
		var cr = gloss.create();
	
		// draw the upper, light triangle
		cr.save();
		cr.move_to(0, 0);
		cr.line_to(e.width, 0);
		cr.line_to(0, e.height);
		cr.close_path();
		cr.set_source_rgba(0, 0, 0, 0.5);
		cr.fill();
		cr.restore();
	
		// draw the lower, dark triangle
		cr.move_to(e.width, e.height);
		cr.line_to(e.width, 0);
		cr.line_to(0, e.height);
		cr.close_path();
		cr.set_source_rgba(0, 0, 0, 0.7);
		cr.fill();
		
		// create the action button
		action_button = new Clutter.Texture.from_file(data_path(PLAY_PATH));
		
		// set the position of the button
		action_button.anchor_gravity = Clutter.Gravity.CENTER;
		action_button.x = e.width / 2;
		action_button.y = e.height / 2;

		// add the actors
		group.add_actor(gloss);
		group.add_actor(action_button);
		
		// allow the button to be clicked
		action_button.button_press_event.connect((a, event) => {
			action_button.reactive = false;
			video.reactive = true;
			timeline = new Clutter.Timeline(BUTTON_TIME);
			timeline.completed.connect(() => {
				video.set_playing(true);
				video.reactive = true;
			});
			timeline.start();
			gloss.animate(ALPHA_OPACITY, BUTTON_TIME / 2, "opacity", 0);
			action_button.animate(ALPHA_OPACITY, BUTTON_TIME,
			                      "opacity", 0);
			action_button.animate(ALPHA_SCALE, BUTTON_TIME,
			                      "scale-x", 0);
			action_button.animate(ALPHA_SCALE, BUTTON_TIME,
			                      "scale-y", 0);
			return true;
		});
		
		// if requested, show the new actors
		if (!active)
		{
			action_button.opacity = 0;
			gloss.opacity = 0;
		}
		else
		{
			action_button.reactive = true;
		}
	}
	
	public double get_audio_volume()
	{
		return video.get_audio_volume();
	}
	
	public double get_buffer_fill()
	{
		return video.get_buffer_fill();
	}
	
	public bool get_can_seek()
	{
		return video.get_can_seek();
	}
	
	public double get_duration()
	{
		return video.get_duration();
	}
	
	public bool get_playing()
	{
		return video.get_playing();
	}
	
	public double get_progress()
	{
		return video.get_progress();
	}
	
	public unowned string get_subtitle_font_name()
	{
		return video.get_subtitle_font_name();
	}
	
	public unowned string get_subtitle_uri()
	{
		return video.get_subtitle_uri();
	}
	
	public unowned string get_uri()
	{
		return video.get_uri();
	}
	
	public void set_audio_volume(double volume)
	{
		video.set_audio_volume(volume);
	}
	
	public void set_filename(string filename)
	{
		video.set_filename(filename);
	}
	
	public void set_playing(bool playing)
	{
		video.set_playing(playing);
	}
	
	public void set_progress(double progress)
	{
		video.set_progress(progress);
	}
	
	public void set_subtitle_font_name(string font_name)
	{
		video.set_subtitle_font_name(font_name);
	}
	
	public void set_subtitle_uri(string uri)
	{
		video.set_subtitle_uri(uri);
	}
	
	public void set_uri(string uri)
	{
		video.set_uri(uri);
	}
}

