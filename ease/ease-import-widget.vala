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

internal class Ease.ImportWidget : Gtk.Alignment
{
	private const string UI_FILE_PATH = "import-widget.ui";
	private const double DARK_FACTOR = 1.1;
	
	/**
	 * Primary icon view for display of results.
	 */
	internal Gtk.IconView icons;
	
	/**
	 * Container of the icons.
	 */
	internal Gtk.Widget icons_container;
	
	/**
	 * Search field.
	 */
	internal Gtk.Entry search;
	
	/**
	 * Search button.
	 */
	internal Gtk.Button button;
	
	/**
	 * Insert button.
	 */
	internal Gtk.Button insert;
	
	/**
	 * Progress bar, displaying the percentage of images downloaded so far.
	 */
	internal Gtk.ProgressBar progress;
	
	/**
	 * Spinner displayed while REST call is being made.
	 */
	internal Gtk.Spinner spinner;
	
	/**
	 * Container of the spinner.
	 */
	internal Gtk.Widget spinner_container;
	
	/**
	 * Message displayed when no results are found
	 */
	internal Gtk.Widget no_results;
	
	/**
	 * Extra widget for the service.
	 */
	internal Gtk.Widget extra_widget;
	
	/**
	 * The ImportService associated with this 
	 */
	private Plugin.ImportService service;
	
	/**
	 * Triggers a media add.
	 */
	internal signal void add_media(Gee.Queue<Plugin.ImportMedia> media_list);
	
	/**
	 * Size of the spinner
	 */
	private const int SPINNER_SIZE = 40;

	internal ImportWidget(Plugin.ImportService serv)
	{
		service = serv;
		set_padding(0, 0, 0, 0);
		
		// darken the background
		map_event.connect((self, event) => {
			var color = style.bg[Gtk.StateType.NORMAL];
			color.red = 0;
			modify_bg(Gtk.StateType.NORMAL, color);
			return false;
		});
		
		// load the ui from GtkBuilder
		var builder = new Gtk.Builder();
		try
		{
			builder.add_from_file(data_path(Path.build_filename(Temp.UI_DIR,
				                                                UI_FILE_PATH)));
		}
		catch (Error e) { error("Error loading UI: %s", e.message); }
		
		// bottom alignment and extra widget
		extra_widget = service.extra_widget();
		if (extra_widget != null)
		{
			
			extra_widget.show_all();
			(builder.get_object("extra-alignment") as Gtk.Alignment).
				add(extra_widget);
		}
		
		// search field
		search = builder.get_object("search") as Gtk.Entry;
		search.icon_press.connect(() => search.text = "");
		search.activate.connect(() => button.activate());
		search.expose_event.connect(set_bg);
		
		// search button
		button = builder.get_object("search-button") as Gtk.Button;
		button.clicked.connect(() => service.run(search.text));
		button.expose_event.connect(set_bg);
		
		// insert button
		insert = builder.get_object("insert") as Gtk.Button;
		insert.clicked.connect(() => {
			var model = icons.model;
			Gtk.TreeIter iter = Gtk.TreeIter();
			Plugin.ImportMedia media = null;
			var list = new Gee.LinkedList<Plugin.ImportMedia>();
			icons.selected_foreach((view, path) => {
				model.get_iter(out iter, path);
				model.get(iter, Plugin.ImportService.Column.IMPORT_MEDIA,
				          out media);
				list.add(media);
			});
			add_media(list);
		});
		insert.expose_event.connect(set_bg);
		
		// progress
		progress = builder.get_object("progress-bar") as Gtk.ProgressBar;
		
		// spinner
		spinner = new Gtk.Spinner();
		spinner.visible = true;
		spinner.set_size_request(SPINNER_SIZE, SPINNER_SIZE);
		spinner_container = builder.get_object("spin-align") as Gtk.Widget;
		(spinner_container as Gtk.Bin).add(spinner);
		
		// icon view
		icons = builder.get_object("icon-view") as Gtk.IconView;
		icons_container = builder.get_object("icon-window") as Gtk.Widget;
		icons.selection_changed.connect(() => {
			insert.sensitive = icons.get_selected_items().length() > 0;
		});
		
		// no results
		no_results = builder.get_object("no-results") as Gtk.Widget;
		
		// add
		var root = builder.get_object("root") as Gtk.EventBox;
		root.expose_event.connect(set_bg);
		add(root);
		
		// service signals
		service.started.connect(() => {
			// remove the results
			icons_container.visible = false;
			no_results.visible = false;
		
			// display the spinner
			spinner.start();
			spinner_container.visible = true;
		
			// reset the progress bar
			progress.set_fraction(0);
		});
		
		service.proxy_call_complete.connect(() => {
			// remove the spinner
			spinner_container.visible = false;
			spinner.stop();
		});
		
		service.no_results.connect(() => {
			no_results.visible = true;
		});
		
		service.loading_started.connect(() => {
			// add the icon view
			icons_container.visible = true;
		
			// add the progress
			progress.visible = true;
			
			return icons;
		});
		
		service.loading_progress.connect((fraction) => {
			progress.set_fraction(fraction);
		});
		
		service.loading_complete.connect(() => {
			progress.visible = false;
		});
	}
	
	private bool set_bg(Gtk.Widget root, Gdk.EventExpose event)
	{
		// lighten or darken the background
		var color = root.style.bg[Gtk.StateType.NORMAL];
		
		// darken if it would overflow
		if (color.red * DARK_FACTOR > 65535)
		{
			color.red = (uint16)(color.red / DARK_FACTOR);
			color.blue = (uint16)(color.blue / DARK_FACTOR);
			color.green = (uint16)(color.green / DARK_FACTOR);
		}
		
		// otherwise, lighten
		else
		{
			color.red = (uint16)(color.red * DARK_FACTOR);
			color.blue = (uint16)(color.blue * DARK_FACTOR);
			color.green = (uint16)(color.green * DARK_FACTOR);
		}
		
		// set the background color
		root.modify_bg(Gtk.StateType.NORMAL, color);
		
		// only do this once
		root.expose_event.disconnect(set_bg);
		
		return false;
	}
}
