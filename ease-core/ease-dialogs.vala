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
 * Common dialog windows used in Ease.
 */
namespace Ease.Dialog
{
	private const string VERIFY_EASE_SECONDARY =
		_("The specified filename does not end with a \".ease\" extension. Would you like to append one?");
	private const string VERIFY_EASE_PRIMARY = _("Append .ease?");
	
	private const string VERIFY_OVERWRITE_TITLE = _("Replace %s?");
	private const string VERIFY_OVERWRITE_FMT =
		_("A file named %s already exists. Do you want to replace it?");
	private const string VERIFY_OVERWRITE_SECONDARY_FMT =
		_("This file already exists in the directory \"%s\". Overwriting it will replace its contents.");
		
	/**
	 * Displays a message dialog.
	 *
	 * The varargs provide text or stock IDs for buttons. These should be
	 * paired with a Gtk.ResponseType. The list must be terminated with null.
	 *
	 * @param message_type The GtkMessageType for the dialog.
	 * @param title The title of the dialog.
	 * @param main_text The large text displayed on the dialog.
	 * @param secondary_text The secondary (small) text on the dialog.
	 * @param modal A window that the dialog should be modal for.
	 * @param default_response The default response for the dialog.
	 */
	public Gtk.ResponseType message(Gtk.MessageType message_type,
	                                string title, string main_text,
	                                string secondary_text, Gtk.Window? modal,
	                                Gtk.ResponseType default_response,
	                                ...)
	{
		var dialog = new Gtk.MessageDialog.with_markup(modal,
		                                               Gtk.DialogFlags.MODAL,
		                                               message_type,
		                                               0, null);
		// set text
		dialog.use_markup = dialog.secondary_use_markup = true;
		dialog.text = main_text;
		dialog.secondary_text = secondary_text;
		
		// handle varargs
		var l = va_list();
		while (true)
		{
			// grab arguments (or break)
			string? button = l.arg();
			if (button == null) break;
			Gtk.ResponseType type = l.arg();
			
			// add the button
			dialog.add_button(button, type);
		}
		
		// set default response
		dialog.set_default_response(default_response);
		
		// run the dialog
		var ret = (Gtk.ResponseType)dialog.run();
		dialog.destroy();
		return ret;
	}
	
	/**
	 * Displays a question dialog.
	 *
	 * The varargs provide text or stock IDs for buttons. These should be
	 * paired with a Gtk.ResponseType. The list must be terminated with null.
	 *
	 * @param title The title of the dialog.
	 * @param main_text The large text displayed on the dialog.
	 * @param secondary_text The secondary (small) text on the dialog.
	 * @param modal A window that the dialog should be modal for.
	 * @param default_response The default response for the dialog.
	 */
	public Gtk.ResponseType question(string title, string main_text,
	                                 string secondary_text, Gtk.Window? modal,
	                                 Gtk.ResponseType default_response,
	                                 ...)
	{
		var dialog = new Gtk.MessageDialog.with_markup(modal,
		                                               Gtk.DialogFlags.MODAL,
		                                               Gtk.MessageType.QUESTION,
		                                               0, null);
		// set text
		dialog.use_markup = dialog.secondary_use_markup = true;
		dialog.text = main_text;
		dialog.secondary_text = secondary_text;
		
		// handle varargs
		var l = va_list();
		while (true)
		{
			// grab arguments (or break)
			string? button = l.arg();
			if (button == null) break;
			Gtk.ResponseType type = l.arg();
			
			// add the button
			dialog.add_button(button, type);
		}
		
		// set default response
		dialog.set_default_response(default_response);
		
		// run the dialog
		var ret = (Gtk.ResponseType)dialog.run();
		dialog.destroy();
		return ret;
	}
	
	/**
	 * Displays an "Open" dialog with the specified title. Returns null if
	 * cancelled, otherwise returns the selected path.
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 */
	public string? open(string title, Gtk.Window? modal)
	{
		return open_ext(title, modal, null);
	}
	
	/**
	 * Displays an "Open" dialog with the specified title. The
	 * {@link FileChooserDialogExtension} can be used to modify the
	 * dialog before it is displayed. Returns null if cancelled, otherwise
	 * returns the selected path.
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 * @param ext A function to modify the dialog before it is displayed.
	 */
	public string? open_ext(string title, Gtk.Window? modal,
	                        FileChooserDialogExtension? ext)
	{
		var dialog = new Gtk.FileChooserDialog(title,
			                                   modal,
			                                   Gtk.FileChooserAction.OPEN,
			                                   "gtk-cancel",
			                                   Gtk.ResponseType.CANCEL,
			                                   "gtk-open",
			                                   Gtk.ResponseType.ACCEPT);
		if (ext != null) ext(dialog);

		if (dialog.run() == Gtk.ResponseType.ACCEPT)
		{
			string name = dialog.get_filename();
			dialog.destroy();
			return name;
		}
		dialog.destroy();
		return null;
	}
	
	/**
	 * Displays an "Open" dialog for an Ease {@link Document}. Returns null if
	 * cancelled, otherwise returns the selected path.
	 *
	 * @param modal The window that the dialog should be modal for.
	 */
	public string? open_document(Gtk.Window? modal)
	{
		return open_ext(_("Open Document"), modal, (dialog) => {
			// add a filter for ease documents
			var filter = new Gtk.FileFilter();
			filter.add_pattern("*.ease");
			filter.set_name(_("Ease Presentations"));
			dialog.add_filter(filter);
			
			// add a filter for all files
			filter = new Gtk.FileFilter();
			filter.set_name(_("All Files"));
			filter.add_pattern("*");
			dialog.add_filter(filter);
		});
	}
	
	/**
	 * Displays an "Save" dialog with the specified title. Returns null if
	 * cancelled, otherwise returns the selected path.
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 */
	public string? save(string title, Gtk.Window? modal)
	{
		return save_real(title, modal, null, null);
	}

	/**
	 * Displays an "Save" dialog with the specified title. The
	 * {@link FileChooserDialogExtension} can be used to modify the
	 * dialog before it is displayed. Returns null if cancelled, otherwise
	 * returns the selected path.
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 * @param ext A function to modify the dialog before it is displayed.
	 */
	public string? save_ext(string title, Gtk.Window? modal,
	                        FileChooserDialogExtension ext)
	{
		return save_real(title, modal, ext, null);
	}
	
	/**
	 * Displays an "Save" dialog with the specified title. The
	 * {@link FileChooserDialogExtension} can be used to modify the
	 * dialog before it is displayed. Upon completion, a
	 * {@link FileChooserDialogVerify} can be used to modify the return value
	 * of the dialog. Returns null if cancelled, otherwise returns the selected
	 * path (with any modifications).
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 * @param ext A function to modify the dialog before it is displayed.
	 * @param verify A function to verify the dialog's return path.
	 */
	public string? save_verified(string title, Gtk.Window? modal,
	                             FileChooserDialogExtension ext,
	                             FileChooserDialogVerify verify)
	{
		return save_real(title, modal, ext, verify);
	}
	
	
	/**
	 * Displays an "Save" dialog for an Ease {@link Document}. Returns null if
	 * cancelled, otherwise returns the selected path. The title parameter
	 * is provided to differentiate between "Save", "Save as", etc.
	 *
	 * @param title The dialog's title.
	 * @param modal The window that the dialog should be modal for.
	 */
	public string? save_document(string title, Gtk.Window? modal)
	{
		return save_verified(title, modal,
			// extension function
			(dialog) => {
				// add a filter for ease documents
				var filter = new Gtk.FileFilter();
				filter.add_pattern("*.ease");
				filter.set_name(_("Ease Presentations"));
				dialog.add_filter(filter);
			
				// add a filter for all files
				filter = new Gtk.FileFilter();
				filter.set_name(_("All Files"));
				filter.add_pattern("*");
				dialog.add_filter(filter);
			},
		
			// verification function
			(dialog) => {
				// get the current filename
				var filename = Path.get_basename(dialog.get_filename());
				
				// let's see if it already has .ease
				bool has_suffix = filename.has_suffix(".ease");
				
				// if there's no .ease suffix
				if (!has_suffix)
				{
					// ask the user if they'd like to append .ease
					var code = question(VERIFY_EASE_PRIMARY,
					                    VERIFY_EASE_PRIMARY,
						                VERIFY_EASE_SECONDARY,
							            modal,
							            Gtk.ResponseType.YES,
							            _("Don't append .ease"),
							            Gtk.ResponseType.NO,
							            "gtk-cancel",
							            Gtk.ResponseType.CANCEL,
							            _("Append .ease"),
							            Gtk.ResponseType.YES,
							            null);
			
					// react to the response, nothing needs to be done for "no"
					switch (code)
					{
						case Gtk.ResponseType.CANCEL:
							return DialogCode.REJECT;
					
						case Gtk.ResponseType.YES:
							// append .ease to the filename
							dialog.set_current_name(filename + ".ease");
							break;
					}
				}
				
				// now let's check for filename collisions
				if (FileUtils.test(dialog.get_filename(), FileTest.EXISTS))
				{
					var components =
						Path.get_dirname(dialog.get_filename()).split("/");
					var folder = components[components.length - 1];
					var bname = Path.get_basename(dialog.get_filename());
					
					// ask the user if they'd like to overwrite
					var code = message(
						Gtk.MessageType.WARNING,
						VERIFY_OVERWRITE_TITLE.printf(bname),
						VERIFY_OVERWRITE_FMT.printf(bname),
						VERIFY_OVERWRITE_SECONDARY_FMT.printf(folder),
						modal,
						Gtk.ResponseType.YES,
						_("Don't overwrite %s").printf(bname),
						Gtk.ResponseType.NO,
						"gtk-cancel",
						Gtk.ResponseType.CANCEL,
						_("Overwrite %s").printf(bname),
						Gtk.ResponseType.YES,
						null);
					
					// react to the response
					switch (code)
					{
						case Gtk.ResponseType.CANCEL:
							return DialogCode.REJECT;
					
						case Gtk.ResponseType.YES:
							return DialogCode.ACCEPT;
						
						default: // NO
							return DialogCode.REINVOKE;
					}
				}
				
				// if no collisons, we're good to save
				return DialogCode.ACCEPT;
		});
	}
	
	private string save_real(string title, Gtk.Window? modal,
	                         FileChooserDialogExtension? ext,
	                         FileChooserDialogVerify? verify)
	{
		var dialog = new Gtk.FileChooserDialog(title,
			                                   modal,
			                                   Gtk.FileChooserAction.SAVE,
			                                   "gtk-save",
			                                   Gtk.ResponseType.ACCEPT,
			                                   "gtk-cancel",
			                                   Gtk.ResponseType.CANCEL,
			                                   null);
		// run the extension function if applicable
		if (ext != null) ext(dialog);
		
		// default to ACCEPT (so we leave the loop if there is no verify func)
		DialogCode code = DialogCode.ACCEPT;
		do
		{
			// return if the user cancels in the save dialog
			if (dialog.run() != Gtk.ResponseType.ACCEPT)
			{
				dialog.destroy();
				return null;
			}
			
			// (potentially temporarily) hide the dialog
			dialog.hide();
			
			// run the verification function
			if (verify != null) code = verify(dialog);
			
			// return if the user cancels in the verification function
			if (code == DialogCode.REJECT)
			{
				dialog.destroy();
				return null;
			}
			
			// if the dialog is coming back, present it
			if (code == DialogCode.REINVOKE) dialog.present();
		}
		while (code != DialogCode.ACCEPT); // otherwise, continue until accept
		
		// clean up the file dialog and return the path
		string path = dialog.get_filename();
		dialog.destroy();
		return path;
	}
	
	/**
	 * Allows a caller to manipulate a dialog before is is displayed.
	 */
	public delegate void FileChooserDialogExtension(Gtk.FileChooserDialog d);
	
	/**
	 * Allows a caller to manipulate the return value of a dialog, and
	 * potentially reinvoke it.
	 */
	public delegate DialogCode FileChooserDialogVerify(Gtk.FileChooserDialog d);
	
	/**
	 * Enumerates the possible behaviors a {@link FileChooserDialogVerify} can
	 * request.
	 */
	public enum DialogCode
	{
		/**
		 * Causes the dialog to return its (potentially modified) path
		 */
		ACCEPT,
		
		/**
		 * Causes the dialog to return null, as if no path was selected.
		 */
		REJECT,
		
		/**
		 * Causes the dialog to run again. This will rerun any associated
		 * {@link FileChooserDialogExtension} and recreate the dialog.
		 */
		REINVOKE;
	}
}

