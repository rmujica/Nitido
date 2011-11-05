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

private class Ease.Archiver.Archiver : GLib.Object
{
	private string temp_path;
	private string filename;
	private Dialog.Progress dialog;
	private unowned Thread thread;
	private bool async = true;
	private int total_size = 0;
	private Gee.LinkedList<string> include_files;
	
	private static GLib.List<Archiver> archivers = new GLib.List<Archiver>();
	private const string LABEL_TEXT = _("Saving \"%s\"");
	
	/**
	 * The minimum filesize at which asynchronous saving is used.
	 */
	private const int ASYNC_SIZE = 1024 * 1024 * 5;
	
	internal Archiver(string temp, string fname, Gee.LinkedList<string> files,
	                  Dialog.Progress dlog)
	{
		temp_path = temp;
		filename = fname;
		dialog = dlog;
		include_files = files;
		archivers.append(this);
		
		// this is a little redundant, probably not a huge perf hit though
		recursive_directory(temp_path, null, (path, full_path) => {
			// if we're not going to archive that file, don't include its size
			if (!files.contains(path)) return;
			
			// add the file's size to the total
			Posix.Stat st;
			Posix.stat(full_path, out st);
			total_size += (int)st.st_size;
		});
		
		if (!Thread.supported() || total_size < ASYNC_SIZE)
		{
			// fall back on non-async archiving
			async = false;
			archive_real();
			return;
		}
		
		// show the dialog
		dialog.set_label(LABEL_TEXT.printf(filename));
		dialog.show();
		
		// archive in a thread
		thread = Thread.create(archive_real, true);
	}
	
	/**
	 * Does the actual archiving of a directory.
	 */
	private void* archive_real()
	{
		// create a writable archive
		var archive = new Archive.Write();
		var buffer = new char[ARCHIVE_BUFFER];
		
		// set archive format
		archive.set_format_pax_restricted();
		archive.set_compression_none();
		
		// open file
		if (archive.open_filename(filename) == Archive.Result.FAILED)
		{
			throw new Error(0, 0, "Error opening %s", filename);
		}
		
		// open the temporary directory
		var dir = GLib.Dir.open(temp_path, 0);
		
		// error if the temporary directory has disappeared
		if (dir == null)
		{
			throw new FileError.NOENT(
				_("Temporary directory doesn't exist: %s"), temp_path);
		}
		
		// add files
		recursive_directory(temp_path, null, (path, full_path) => {
			// skip files we aren't including
			if (!include_files.contains(path)) return;
		
			// create an archive entry for the file
			var entry = new Archive.Entry();
			entry.set_pathname(path);
			entry.set_perm(0644);
			Posix.Stat st;
			Posix.stat(full_path, out st);
			entry.copy_stat(st);
			arc_fail(archive.write_header(entry), archive);
			
			double size = (double)st.st_size;
			double size_frac = size / total_size;
			
			// write the file
			var fd = Posix.open(full_path, Posix.O_RDONLY);
			var len = Posix.read(fd, buffer, sizeof(char) * ARCHIVE_BUFFER);
			while(len > 0)
			{
				archive.write_data(buffer, len);
				len = Posix.read(fd, buffer, sizeof(char) * ARCHIVE_BUFFER);
				lock (dialog) dialog.add_fraction(size_frac * (len / size));
			}
			Posix.close(fd);
			arc_fail(archive.finish_entry(), archive);
		});
		
		// close the archive
		arc_fail(archive.close(), archive);
		
		// destroy the progress dialog in async mode
		lock (dialog) if (async) dialog.destroy();
		
		// stop tracking this archiver
		lock (archivers) { archivers.remove(this); }
		
		return null;
	}
	
	/**
	 * Produces an error if a libarchive error occurs.
	 */
	private static void arc_fail(Archive.Result result, Archive.Archive archive)
	{
		if (result != Archive.Result.OK) critical(archive.error_string());
	}
}

namespace Ease.Archiver
{
	private const int ARCHIVE_BUFFER = 4096;
	
	/**
	 * Asynchronously (if supported) creates an archive from a temporary
	 * directory. Otherwise, falls back on synchronous archiving.
	 *
	 * archive() uses libarchive to create a tarball of the temporary directory.
	 *
	 * @param temp_path The path of the temporary directory.
	 * @param filename The filename of the archive to save to.
	 * @param title The title of the progress dialog.
	 * @param files The files to include in the archive.
	 * @param win The window to display a progress dialog modal for.
	 */
	internal static void create(string temp_path,
		                        string filename,
		                        string title,
		                        Gee.LinkedList<string> files,
		                        Gtk.Window? win) throws Error
	{
		// create a progress dialog
		var img = new Gtk.Image.from_stock("gtk-save",
		                                   Gtk.IconSize.LARGE_TOOLBAR);
		var dialog = new Dialog.Progress.with_image(title, false, 1, win, img);
	
		// archive away!
		var arc = new Archiver(temp_path, filename, files, dialog);
	}
	
	/**
	 * Creates a temporary directory and extracts an archive to it.
	 *
	 * extract() uses libarchive for extraction. It will automatically request
	 * a new temporary directory, extract the archive, and return the path
	 * to the extracted files.
	 *
	 * @param filename The path of the archive to extract.
	 */
	internal static string extract(string filename) throws GLib.Error
	{
		// initialize the archive
		var archive = new Archive.Read();
		
		// automatically detect archive type
		archive.support_compression_all();
		archive.support_format_all();
		
		// open the archive
		archive.open_filename(filename, ARCHIVE_BUFFER);
		
		// create a temporary directory to extract to
		string path = Temp.request();
		
		// extract the archive
		weak Archive.Entry entry;
		while (archive.next_header(out entry) == Archive.Result.OK)
		{
			var fpath = Path.build_filename(path, entry.pathname());
			var file = GLib.File.new_for_path(fpath);
			
			if (Posix.S_ISDIR(entry.mode()))
			{
				file.make_directory_with_parents(null);
			}
			else
			{
				var parent = file.get_parent();
				if (!parent.query_exists(null))
				{
					parent.make_directory_with_parents(null);
				}
				
				file.create(FileCreateFlags.REPLACE_DESTINATION, null);
				int fd = Posix.open(fpath, Posix.O_WRONLY, 0644);
				archive.read_data_into_fd(fd);
				Posix.close(fd);
			}
		}
		
		return path;
	}
}
