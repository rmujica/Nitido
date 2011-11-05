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

namespace Ease
{
	/**
	 * The local data path.
	 */
	private const string LOCAL_DATA = "data";
	
	/**
	 * The installed data path.
	 */
	private const string SYS_DATA = "ease";
	
	/**
	 * The autotools-determined data path.
	 */
	private extern const string DATA_DIR;
	
	private string[] get_data_dirs()
	{
		return { LOCAL_DATA,
		         Path.build_filename(DATA_DIR, SYS_DATA) };
	}
	
	
	/**
	 * Display a simple error message.
	 *
	 * @param title The title of the dialog.
	 * @param message The error message.
	 */
	public void error_dialog(string title, string message)
	{
		var dialog = new Gtk.MessageDialog(null, 0,
		                                   Gtk.MessageType.ERROR,
		                                   Gtk.ButtonsType.CLOSE,
		                                   "%s", message);
		dialog.title = title;
		dialog.border_width = 5;
		dialog.run();
		dialog.destroy();
	}
	
	/**
	 * Finds the given path in the data directories (ie /usr/share). Return null
	 * if the path cannot be found.
	 *
	 * @param path The path to search for.
	 */
	public string? data_path(string path)
	{
		foreach (string dir in get_data_dirs())
		{
			var sys_file = query_file(dir, path);
			if (sys_file != null) return sys_file;
		}
		
		return null;
	}
	
	/**
	 * Queries the given folder for the file, returning it if it is found.
	 *
	 * Otherwise, the function returns null.
	 *
	 * @param dir The base directory.
	 * @param path The path to search for.
	 */
	private string? query_file(string dir, string path)
	{
		var filename = Path.build_filename(dir, path);
		var file = File.new_for_path(filename);
		
		return file.query_exists(null) ? filename : null;
	}
	
	/**
	 * Returns a list containing every directory in the data directories.
	 */
	public Gee.LinkedList<string> data_contents()
	{
		var list = new Gee.LinkedList<string>();
		
		foreach (var dir in get_data_dirs())
		{
			// don't open nonexistent directories
			var test = File.new_for_path(dir);
			if (!test.query_exists(null)) continue;
			
			var directory = GLib.Dir.open(dir, 0);
			string name = directory.read_name();
			while (name != null)
			{
				list.add(Path.build_filename(dir, name));
				name = directory.read_name();
			}
		}
		
		return list;
	}
	
	/**
	 * Returns a list containing all contents of folders in the data directory
	 * with the specified name.
	 */
	public Gee.LinkedList<string> data_contents_folder(string folder)
	{
		var list = new Gee.LinkedList<string>();
		
		foreach (var dir in get_data_dirs())
		{
			// don't open nonexistent directories
			var test = File.new_for_path(dir);
			if (!test.query_exists(null)) continue;
			
			var directory = Dir.open(dir, 0);
			string name = directory.read_name();
			while (name != null)
			{
				if (name == folder)
				{
					// don't open nonexistent directories
					test = File.new_for_path(Path.build_filename(dir, name));
					if (!test.query_exists(null)) continue;
					
					var child = Dir.open(Path.build_filename(dir, name), 0);
					string child_name = child.read_name();
					while (child_name != null)
					{
						list.add(Path.build_filename(dir, folder, child_name));
						child_name = child.read_name();
					}
				}
				name = directory.read_name();
			}
		}
		
		return list;
	}
	
	/**
	 * Performs a recursive iteration on a directory, with callbacks.
	 *
	 * The caller can provide two {@link RecursiveDirAction}s: one for files,
	 * and another for directories. These callbacks can both be null
	 * (although if they both were, the call would do nothing). The directory
	 * callback is executed before the recursion continues.
	 * recursive_directory_after does the opposite.
	 *
	 * The directory callback is not performed on the toplevel directory.
	 *
	 * @param directory The directory to iterate.
	 * @param directory_action A {@link RecursiveDirAction} to perform on all
	 * directories.
	 * @param file_action A {@link RecursiveDirAction} to perform on all files.
	 */
	public void recursive_directory(string directory,
	                                RecursiveDirAction? directory_action,
	                                RecursiveDirAction? file_action)
	                                throws Error
	{
		do_recursive_directory(directory,
		                       directory_action,
		                       file_action,
		                       "",
		                       true);
	}
	
	/**
	 * Performs a recursive iteration on a directory, with callbacks.
	 *
	 * The caller can provide two {@link RecursiveDirAction}s: one for files,
	 * and another for directories. These callbacks can both be null
	 * (although if they both were, the call would do nothing). The directory
	 * callback is executed after the recursion continues. recursive_directory
	 * does the opposite.
	 *
	 * The directory callback is not performed on the toplevel directory.
	 *
	 * @param directory The directory to iterate.
	 * @param directory_action A {@link RecursiveDirAction} to perform on all
	 * directories.
	 * @param file_action A {@link RecursiveDirAction} to perform on all files.
	 */
	public void recursive_directory_after(string directory,
	                                      RecursiveDirAction? directory_action,
	                                      RecursiveDirAction? file_action)
	                                      throws Error
	{
		do_recursive_directory(directory,
		                       directory_action,
		                       file_action,
		                       "",
		                       false);
	}
	
	/**
	 * Used for execution of recursive_directory(). Should never be called, 
	 * except by that function.
	 */
	private void do_recursive_directory(string directory,
	                                    RecursiveDirAction? directory_action,
	                                    RecursiveDirAction? file_action,
	                                    string rel_path,
	                                    bool dir_first)
	                                    throws Error
	{
		var dir = GLib.Dir.open(directory, 0);
		string child_path;
		
		while ((child_path = dir.read_name()) != null)
		{
			var child_full_path = Path.build_filename(directory, child_path);
			var child_rel_path = Path.build_filename(rel_path, child_path);
			if (FileUtils.test(child_full_path, FileTest.IS_DIR))
			{
				if (directory_action != null && dir_first)
				{
					directory_action(child_rel_path, child_full_path);
				}
				
				// recurse
				do_recursive_directory(child_full_path,
				                       directory_action, file_action,
				                       child_rel_path,
				                       dir_first);
				
				if (directory_action != null && !dir_first)
				{
					directory_action(child_rel_path, child_full_path);
				}
			}
			else // the path is a file
			{
				if (file_action != null)
				{
					file_action(child_rel_path, child_full_path);
				}
			}
		}
	}
	
	public delegate void RecursiveDirAction(string path, string full_path)
	                                       throws GLib.Error;
	
	/**
	 * Recursively removes a directory.
	 *
	 * @param path The directory to be recursively deleted.
	 */
	public void recursive_delete(string path) throws GLib.Error
	{
		var dir = GLib.Dir.open(path, 0);
		
		if (dir == null)
		{
			throw new FileError.NOENT(
				_("Directory to remove doesn't exist: %s"), path);
		}
		
		recursive_directory_after(path,
			(p, full_path) => {
				DirUtils.remove(full_path);
			},
			(p, full_path) => {
				FileUtils.unlink(full_path);
			});
		
		DirUtils.remove(path);	
	}
	
	/**
	 * Recursive copies a directory.
	 *
	 * @param from_dir The directory to copy from.
	 * @param to_dir The directory to copy to.
	 */
	public void recursive_copy(string from_dir, string to_dir) throws GLib.Error
	{
		var top = File.new_for_path(to_dir);
		if (!top.query_exists(null))
		{
			top.make_directory_with_parents(null);
		}
		
		recursive_directory(from_dir,
			(path, full_path) => {
				var dir = File.new_for_path(Path.build_filename(to_dir, path));
				if (!dir.query_exists(null)) dir.make_directory(null);
			},
			(path, full_path) => {
				var from = File.new_for_path(full_path);
				var to = File.new_for_path(Path.build_filename(to_dir, path));
				from.copy(to, FileCopyFlags.OVERWRITE, null, null);
			});
	}
	
	/**
	 * Locates a color in the current GTK theme.
	 *
	 * @param color The color to find.
	 */
	public Gdk.Color? theme_color(string color)
	{
		// find the appropriate color
		var settings = Gtk.Settings.get_default();
		var colors = settings.gtk_color_scheme.split_set("\n;");
		for (int i = 0; i < colors.length; i++)
		{
			colors[i] = colors[i].strip();
			
			if (colors[i].has_prefix(color))
			{
				for (; !colors[i].has_prefix("#") && colors[i].length > 3;
			         colors[i] = colors[i].substring(1, colors[i].length - 1));
				
				Gdk.Color gdk_color;
				Gdk.Color.parse(colors[i], out gdk_color);
				return gdk_color;
			}
		}
		
		warning("Could not find color: %s", color);
		return null;
	}
	
	/**
	 * Locates a color in the current GTK theme, as a Clutter.Color.
	 *
	 * @param color The color to find.
	 */
	public Clutter.Color theme_clutter_color(string color)
	{
		return Transformations.gdk_color_to_clutter_color(theme_color(color));
	}
	
	/**
	 * Returns the parent window of the specified widget.
	 */
	public Gtk.Window widget_window(Gtk.Widget widg)
	{
		while (widg.get_parent() != null) widg = widg.get_parent();
		return widg as Gtk.Window;
	}
	
	/**
	 * Returns an absolute path for the given path.
	 */
	public static string absolute_path(string path)
	{
		var file = GLib.File.new_for_path(path);
		return file.resolve_relative_path(".").get_path();
	}
}
