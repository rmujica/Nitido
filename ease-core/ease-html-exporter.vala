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
 * Exports Ease {@link Document}s as HTML5 files
 *
 * HTMLExporter creates a save dialog and a progress dialog. The actual
 * exporting is done with the {@link Document}, {@link Slide}, and
 * {@link Element} classes. The exported {@link Document} reports back to
 * HTMLExported when the export is complete, allowing the dialog to close.
 *
 * HTMLExporter also handles copying media files to the output directory.
 */
public class Ease.HTMLExporter : GLib.Object
{
	private Gtk.Dialog window;
	private Gtk.ProgressBar progress;
	
	public int render_index
	{
		get { return render_index_priv++; }
	}
	private int render_index_priv = 0;
	
	/**
	 * The path to export HTML to.
	 */
	public string path { get; private set; }
	
	/**
	 * The final path component of the export path.
	 */
	public string basename
	{
		owned get
		{
			var file = File.new_for_path(path);
			return file.get_basename();
		}
	}
	
	/**
	 * Creates a new HTMLExporter.
	 */
	public HTMLExporter()
	{
		progress = new Gtk.ProgressBar();
	}
	
	/**
	 * Asks the user for an output path
	 *
	 * Shows a file chooser dialog. If the user does not cancel the export,
	 * creates a the progress dialog. Returns false if the user cancels,
	 * otherwise returns true.
	 * 
	 * @param win The window that the dialog should be modal for
	 */
	public bool request_path(Gtk.Window win)
	{
		path = Dialog.save(_("Export to HTML"), win);
		
		if (path != null)
		{	
			// create the progress dialog
			window = new Gtk.Dialog();
			window.width_request = 400;
			window.set_title(_("Exporting as HTML"));
			Gtk.VBox vbox = (Gtk.VBox)(window.get_content_area());
			vbox.pack_start(progress, true, true, 5);
			window.show_all();
			
			return true;
		}
		
		return false;
	}
	
	/**
	 * Adds to the progress dialog's progress bar, which ranges from 0 to 1
	 *
	 * @param amount The amount of progress to add
	 */
	public void add_progress(double amount)
	{
		progress.set_fraction(progress.get_fraction() + amount);
	}
	
	/**
	 * Finishes exporting and hides the progress dialog
	 */
	public void finish()
	{
		window.hide_all();
		window.destroy();
	}
	
	/**
	 * Copies a file to the output path
	 *
	 * To show images or videos in an HTML presentation, they must be
	 * copied to a path relative to the HTML document.
	 *
	 * @param end_path The file's path relative to the Ease file
	 * @param base_path The output directory and filename
	 */
	public void copy_file(string end_path, string base_path)
	{
		var source = File.new_for_path(Path.build_path("/",
		                                               base_path, end_path));
		var destination = File.new_for_path(path + " " + end_path);

		try
		{
			// if the destination directory doesn't exist, make it
			var parent = destination.get_parent();
			if (!parent.query_exists(null))
			{
				parent.make_directory_with_parents(null);
			}
			
			// copy the image
			source.copy(destination,
				        FileCopyFlags.OVERWRITE,
				        null,
				        null);
		}
		catch (GLib.Error e)
		{
			error_dialog(_("Error Copying File"), e.message);
		}
	}
	
	/**
	 * Copies a rendered file to the output path. Returns the filename.
	 */
	public string copy_rendered(string rendered)
	{	
		var source = File.new_for_path(rendered);
		var dest_path = Path.build_filename("Rendered",
                                            render_index.to_string() + ".png");
		var destination = File.new_for_path(Path.build_filename(path + " Media",
		                                                        dest_path));

		try
		{
			// if the destination directory doesn't exist, make it
			var parent = destination.get_parent();
			if (!parent.query_exists(null))
			{
				parent.make_directory_with_parents(null);
			}
			
			// copy the image
			source.copy(destination,
				        FileCopyFlags.OVERWRITE,
				        null,
				        null);
		}
		catch (GLib.Error e)
		{
			error_dialog(_("Error Copying File"), e.message);
		}
		
		return dest_path;
	}
	
	/**
	 * HTML header for presentations.
	 */
	public static const string HEADER =
"""<!DOCTYPE html>
<html>
<head>
	<title>Presentation</title>
	
	<script type="text/javascript">
		var slide = -1;

		function load() {
			advance();
		}

		function keydown(e) {
			var code = e.keyCode;
			if (code == 32 || code == 39 || code == 13 || code == 40 || code == 39) {
				advance();
			}
	
			else if (code == 8 || code == 46 || code == 37 || code == 38) {
				retreat();
			}
		}

		function advance() {
			if (document.getElementById("slide" + (slide + 1)) != null) {
				if (slide >= 0) {
					document.getElementById("slide" + slide).style.display = "none";
				}
				slide++;
				document.getElementById("slide" + slide).style.display = "block";
			}
		}

		function retreat() {
			if (slide > 0) {
				document.getElementById("slide" + slide).style.display = "none";
				slide--;
				document.getElementById("slide" + slide).style.display = "block";
			}
		}

		document.onkeydown = keydown;
	</script>
	
	<style>
		.slide {
			width: %ipx;
			height: %ipx;
			display: none;
			overflow: hidden;
			position: relative;
			margin: 20px auto 20px auto;
		}
		html {
			padding: 0px;
			margin: 0px;
			background-color: black;
		}
	</style>
</head>
<body onload=load()>
""";

}

