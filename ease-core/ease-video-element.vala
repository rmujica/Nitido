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
 * A {@link MediaElement} subclass for playing a vide. Linked with
 * {@link VideoActor}.
 */
public class Ease.VideoElement : MediaElement
{
	private const string UI_FILE = "inspector-element-video.ui";
	private bool silence_undo;
	
	/**
	 * If the video should begin playing automatically, or display a play
	 * button.
	 */
	internal bool play_auto { get; set; default = false; }
	
	/**
	 * If the video should be muted.
	 */
	internal VideoEndAction end_action
	{
		get; set; default = VideoEndAction.STOP;
	}
	
	/**
	 * If the video should be muted.
	 */
	internal bool mute { get; set; default = false; }
	
	public VideoElement()
	{
		signals();
	}
	
	internal VideoElement.from_json(Json.Object obj)
	{
		base.from_json(obj);
		play_auto = obj.get_string_member(Theme.VIDEO_PLAY_AUTO).to_bool();
		mute = obj.get_string_member(Theme.VIDEO_MUTE).to_bool();
		end_action = VideoEndAction.from_string(
			obj.get_string_member(Theme.VIDEO_END_ACTION));
	}	
	
	public override Actor actor(ActorContext c)
	{
		return new VideoActor(this, c);
	}
	
	public override Json.Object to_json()
	{
		var obj = base.to_json();
		obj.set_string_member(Theme.VIDEO_PLAY_AUTO, play_auto.to_string());
		obj.set_string_member(Theme.VIDEO_MUTE, mute.to_string());
		obj.set_string_member(Theme.VIDEO_END_ACTION, end_action.to_string());
		return obj;
	}
	
	public override string html_render(HTMLExporter exporter)
	{
		// open the tag
		var html = "<video class=\"video element\" ";
		
		// set the video's style
		html += "style=\"";
		html += "left:" + x.to_string() + "px;";
		html += " top:" + y.to_string() + "px;";
		html += " position: absolute;\" ";
		
		// set the video's size
		html += " width=\"" + width.to_string() + "\" ";
		html += " height=\"" + width.to_string() + "\" ";
		
		// set the video's source and controls
		html += "src=\"" + exporter.path + " " +
		        filename + "\" " +
		        "controls=\"yes\">" +
		        _("Your browser does not support the video tag") + 
		        "</video>";
		        
		// copy the video file
		exporter.copy_file(filename, parent.parent.path);
		
		return html;
	}
	
	/**
	 * {@inheritDoc}
	 */
	public override Gtk.Widget inspector_widget()
	{
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		var m_button = builder.get_object("mute") as Gtk.CheckButton;
		var a_button = builder.get_object("play-auto") as Gtk.CheckButton;
		
		// connect the "fill slide" button
		(builder.get_object("fill-slide") as Gtk.Button).clicked.connect(() => {
			// don't create an unneeded undoaction
			if (width == parent.width && height == parent.height &&
			    x == 0 && y == 0) return;
			
			// create an undo acton
			var action = new UndoAction(this, "x");
			action.add(this, "y");
			action.add(this, "width");
			action.add(this, "height");
			
			// set the position of the element
			x = 0;
			y = 0;
			width = parent.width;
			height = parent.height;
			
			// emit the undoaction
			undo(action);
		});
		
		// setup mute and autoplay checkboxes
		m_button.active = mute;
		a_button.active = play_auto;
		
		m_button.toggled.connect(() => {
			mute = m_button.active;
			
			var action = new UndoAction(this, "mute");
			action.applied.connect((a) => m_button.active = mute);
			undo(action);
		});
		
		a_button.toggled.connect(() => {
			play_auto = a_button.active;
			
			var action = new UndoAction(this, "play-auto");
			action.applied.connect((a) => {
				a_button.active = play_auto;
			});
			undo(action);
		});
		
		// setup end action combo box
		var combo = builder.get_object("end-action") as Gtk.ComboBox;
		set_combobox(combo);
		
		// update the end action when the combo box is changed
		combo.changed.connect(on_set_end_action);
		
		// return the root widget
		return builder.get_object("root") as Gtk.Widget;
	}
	
	private void on_set_end_action(Gtk.ComboBox sender)
	{
		var undo_action = new UndoAction(this, "end-action");
	
		undo_action.applied.connect((a) => {
			silence_undo = true;
			set_combobox(sender);
			silence_undo = false;
		});
	
		VideoEndAction action;
		Gtk.TreeIter itr;
		sender.model.get_iter_first(out itr);
		for (int i = 0; i < sender.get_active(); i++)
		{
			sender.model.iter_next(ref itr);
		}
		sender.model.get(itr, 1, out action);
		end_action = action;
		if (!silence_undo) undo(undo_action);
	}
	
	private void set_combobox(Gtk.ComboBox combo)
	{
		combo.model = VideoEndAction.list_store();
		VideoEndAction action;
		Gtk.TreeIter itr;
		combo.model.get_iter_first(out itr);
		do
		{
			combo.model.get(itr, 1, out action);
			if (action == end_action)
			{
				combo.set_active_iter(itr);
				break;
			}
		} while (combo.model.iter_next(ref itr));
	}

	public override void cairo_render(Cairo.Context context) throws Error
	{
		// TODO: something with video frames?
	}
}

internal enum Ease.VideoEndAction
{
	STOP,
	LOOP,
	CONTINUE;
	
	/**
	 * Returns a string representation of this VideoEndAction.
	 */
	public string to_string()
	{
		switch (this)
		{
			case STOP: return Theme.VIDEO_END_STOP;
			case LOOP: return Theme.VIDEO_END_LOOP;
			case CONTINUE: return Theme.VIDEO_END_CONTINUE;
		}
		return "undefined";
	}
	
	/**
	 * Creates a VideoEndAction from a string representation.
	 */
	public static VideoEndAction from_string(string str)
	{
		switch (str)
		{
			case Theme.VIDEO_END_STOP: return STOP;
			case Theme.VIDEO_END_LOOP: return LOOP;
			case Theme.VIDEO_END_CONTINUE: return CONTINUE;
		}
		
		warning("%s is not a video aend action", str);
		return STOP;
	}
	
	/**
	 * Returns a string description of the VideoEndAction
	 */
	public string description()
	{
		switch (this)
		{
			case STOP: return _("Stop playback");
			case LOOP: return _("Loop");
			case CONTINUE: return _("Continue to next slide");
		}
		return "undefined";
	}
	
	/**
	 * Creates a ListStore with the first column set as the description
	 * and the second column set as the VideoEndAction.
	 */
	public static Gtk.ListStore list_store()
	{
		var store = new Gtk.ListStore(2, typeof(string),
		                                 typeof(VideoEndAction));
		Gtk.TreeIter itr;
		
		store.append(out itr);
		store.set(itr, 0, STOP.description(), 1, STOP);
		store.append(out itr);
		store.set(itr, 0, LOOP.description(), 1, LOOP);
		store.append(out itr);
		store.set(itr, 0, CONTINUE.description(), 1, CONTINUE);
		
		return store;
	}
}

