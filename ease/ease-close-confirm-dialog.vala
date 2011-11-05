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
 * A "do you save before closing" dialog.
 */
internal class Ease.CloseConfirmDialog : Gtk.Dialog
{
	/**
	 * Format string for the upper, main label on the dialog.
	 */
	private const string TOP_FORMAT = "<b><big>%s</big></b>";
	
	/**
	 * Timeline to repeatedly increase the seconds/minutes/hours counter.
	 */
	private Clutter.Timeline counter;
	
	/**
	 * Amount of time until an update.
	 */
	private const uint TICK = 1000;
	
	/**
	 * The number of seconds displayed.
	 */
	internal int elapsed_seconds;
	
	/**
	 * The bottom label.
	 */
	private Gtk.Label bottom_label;
	
	/**
	 * Creates a CloseConfirmDialog.
	 *
	 * @param filename The filename (with no extra path components) of the
	 * document.
	 * @param seconds The number of seconds since the document was last saved
	 * (or was created, if it has not been saved).
	 */
	internal CloseConfirmDialog(string filename, int seconds)
	{
		title = _("Save before closing?");
		has_separator = false;
		elapsed_seconds = seconds;
		
		// dialog image
		var image = new Gtk.Image.from_stock("gtk-dialog-warning",
		                                     Gtk.IconSize.DIALOG);
		image.set_alignment(0.5f, 0);
		
		// top label
		var top_label = new Gtk.Label("");
		top_label.wrap = true;
		top_label.use_markup = true;
		top_label.set_alignment(0, 0.5f);
		top_label.selectable = true;
		top_label.can_focus = false;
		top_label.set_markup(TOP_FORMAT.printf(top_label_text(filename)));
		
		// bottom label
		bottom_label = new Gtk.Label(bottom_label_text(seconds));
		bottom_label.wrap = true;
		bottom_label.set_alignment(0, 0.5f);
		bottom_label.set_selectable(true);
		bottom_label.can_focus = false;
		
		// vbox for labels
		var vbox = new Gtk.VBox(false, 12);
		vbox.pack_start(top_label, false, false, 0);
		vbox.pack_start(bottom_label, false, false, 0);
		
		// hbox for all top content
		var hbox = new Gtk.HBox(false, 12);
		hbox.set_border_width(5);
		hbox.pack_start(image, false, false, 0);
		hbox.pack_start(vbox, true, true, 0);
		
		(get_content_area() as Gtk.Box).pack_start(hbox, true, true, 0);
		hbox.show_all();
		
		// buttons
		add_buttons(_("Close _without Saving"), Gtk.ResponseType.NO,
		            "gtk-cancel", Gtk.ResponseType.CANCEL,
		            "gtk-save", Gtk.ResponseType.YES);
		
		// response
		set_default_response(Gtk.ResponseType.YES);
		
		// increase the time
		counter = new Clutter.Timeline(TICK);
		counter.loop = true;
		counter.completed.connect(increment);
		counter.start();
	}
	
	public override void destroy()
	{
		counter.stop();
		base.destroy();
	}
	
	private void increment(Clutter.Timeline sender)
	{
		bottom_label.set_text(bottom_label_text(++elapsed_seconds));
	}
	
	/**
	 * Returns text for the bottom label.
	 *
	 * @param seconds The number of seconds since the document was last saved
	 * (or was created, if it has not been saved).
	 */
	private static string bottom_label_text(int seconds)
	{
		seconds = int.max(1, seconds);
		
		if (seconds < 55)
		{
			return ngettext("If you don't save, changes from the last second will be permanently lost.", "If you don't save, changes from the last %i seconds will be permanently lost.", seconds).printf(seconds);
		}
		if (seconds < 75)
		{
			return _("If you don't save, changes from the last minute will be permanently lost."); 
		}
		if (seconds < 110)
		{
			return ngettext("If you don't save, changes from the last minute and %i second will be permanently lost.", "If you don't save, changes from the last minute and %i seconds will be permanently lost.", seconds - 60).printf(seconds - 60);
		}
		if (seconds < 3600)
		{
			return ngettext("If you don't save, changes from the last %i minute will be permanently lost.", "If you don't save, changes from the last %i minutes will be permanently lost.", seconds / 60).printf(seconds / 60);
		}
		if (seconds < 7200)
		{
			int minutes = (seconds - 3600) / 60;
			if (minutes < 5)
			{
				return _("If you don't save, changes from the last hour will be permanently lost.");
			}
			return ngettext("If you don't save, changes from the last hour and %i minute will be permanently lost.", "If you don't save, changes from the last hour and %i minutes will be permanently lost.", minutes).printf(minutes);
		}
		
		int hours = seconds / 3600;
		return ngettext("If you don't save, changes from the last %i hour will be permanently lost.", "If you don't save, changes from the last %i hours will be permanently lost.", hours).printf(hours);
	}
	
	/**
	 * Returns text for the top label
	 *
	 * @param filename The filename (with no extra path components) of the
	 * document.
	 */
	private static string top_label_text(string filename)
	{
		return (_("Save changes to \"%s\" before closing?")).printf(
			filename);
	}
}
