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
 * Panel on the left side of an {@link EditorWindow}
 * 
 * SlideButtonPanel contains a Gtk.TreeView with displays slides as pixbufs,
 * rendered with Cairo.
 */
internal class Ease.SlideButtonPanel : Gtk.ScrolledWindow
{
	private Document document;
	private EditorWindow owner;
	
	// tree view
	private Gtk.TreeView slides;
	private Gtk.CellRendererPixbuf renderer;
	
	// thumbnails on disk
	private static string m_temp_dir;
	private static string? temp_dir
	{
		get
		{
			if (m_temp_dir != null) return m_temp_dir;
			try { return m_temp_dir = Temp.request_str("thumbnails"); }
			catch (GLib.Error e)
			{
				critical("Could not create temporary directory for thumbnails");
			}
			return null;
		}
	}
	private static int temp_count = 0;
	
	private const int WIDTH_REQUEST = 100;
	private const int PREV_WIDTH = 76;
	private const int PADDING = 4;
	
	/**
	 * Creates a SlideButtonPanel
	 * 
	 * A SlideButtonPanel forms the left edge of an {@link EditorWindow}.
	 *
	 * @param d The Document that the {@link EditorWindow} displays.
	 * @param win The {@link EditorWindow} that this SlideButtonPanel is
	 * part of.
	 */
	internal SlideButtonPanel(Document d, EditorWindow win)
	{			
		document = d;
		owner = win;
		width_request = WIDTH_REQUEST;

		// set the scrollbar policy
		vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
		hscrollbar_policy = Gtk.PolicyType.NEVER;
		shadow_type = Gtk.ShadowType.IN;
		
		// create the tree view
		slides = new Gtk.TreeView();
		slides.reorderable = true;
		slides.headers_visible = false;
		renderer = new Gtk.CellRendererPixbuf();
		renderer.set_padding(PADDING, PADDING);
		slides.insert_column_with_attributes(-1, "Slides", renderer,
		                                     "pixbuf", Document.COL_PIXBUF);
		slides.set_model(document.slides);
		
		
		// add the tree view with a viewport
		var viewport = new Gtk.Viewport(null, null);
		viewport.set_shadow_type(Gtk.ShadowType.NONE);
		viewport.add(slides);
		add(viewport);
		
		// render pixbufs for all current slides
		Slide s;
		foreach (var itr in document.slides)
		{
			slide_redraw(itr);
			document.slides.get(itr, Document.COL_SLIDE, out s);
			s.changed.connect(on_slide_changed);
			s.background_changed.connect(on_slide_changed);
		}
		
		// switch slides when the selection changes
		slides.get_selection().changed.connect((sender) => {
			slides.get_selection().selected_foreach((m, p, itr) => {
				Slide sl;
				m.get(itr, Document.COL_SLIDE, out sl);
				owner.set_slide(document.index_of(sl));
			});
		});
		
		document.slide_added.connect((slide, index) => {
			on_slide_changed(slide);
			slide.changed.connect(on_slide_changed);
			slide.background_changed.connect(on_slide_changed);
		});
		
		document.slide_deleted.connect((slide, index) => {
			slide.changed.disconnect(on_slide_changed);
			slide.background_changed.disconnect(on_slide_changed);
		});
		
		// redraw all slides when the size allocation changes
		/*viewport.size_allocate.connect((sender, alloc) => {
			var width = alloc.width - 2 * PADDING;
			
			Gtk.TreeIter itr;
			if (!document.slides.get_iter_first(out itr)) return;
			for (; document.slides.iter_next(ref itr);)
			{
				Slide s = new Slide();
				document.slides.get(itr, 1, ref s);
				document.slides.set(itr, 0, pixbuf(s, width));
			}
		});*/
	}
	
	/**
	 * Selects a specified {@link Slide}.
	 *
	 * @param s The slide to select.
	 */
	internal void select_slide(Slide slide)
	{
		Gtk.TreeIter itr;
		Slide s = new Slide();
		if (!document.slides.get_iter_first(out itr)) return;
		do
		{
			document.slides.get(itr, Document.COL_SLIDE, ref s);
			if (s == slide)
			{
				slides.get_selection().select_iter(itr);
				break;
			}
		} while (document.slides.iter_next(ref itr));
	}
	
	/**
	 * Redraws a {@link Slide} when it is changed.
	 *
	 * @param itr An iterator pointing to the slide's row.
	 */
	private void slide_redraw(Gtk.TreeIter itr)
	{
		// grab the Slide
		Slide slide;
		document.slides.get(itr, Document.COL_SLIDE, out slide);
		
		// render the pixbuf
		var pb = pixbuf(slide, PREV_WIDTH);
		document.slides.set(itr, Document.COL_PIXBUF, pb);
	}
	
	/**
	 * Creates a Gdk.Pixbuf for a given slide.
	 *
	 * @param slide The slide to create a pixbuf of.
	 */
	internal static Gdk.Pixbuf? pixbuf(Slide slide, int width)
	{
		var height = (int)((float)width * slide.height /
		                                  slide.width);
		var surface = new Cairo.ImageSurface(Cairo.Format.RGB24, width, height);
		
		var context = new Cairo.Context(surface);
		context.save();
		context.scale((float)width / slide.width,
		              (float)height / slide.height);
		
		try
		{
			slide.cairo_render_small(context);
		}
		catch (GLib.Error e)
		{
			critical(_("Error drawing slide preview: %s"), e.message);
		}
		
		// render a black rectangle around the slide
		context.restore();
		
		context.rectangle(0, 0, width, height);
		context.set_source_rgb(0, 0, 0);
		context.stroke();
		
		// HACK: write it to a PNG, load it and return
		var path = Path.build_filename(temp_dir,
		                               (temp_count++).to_string() + ".png");
		surface.write_to_png(path);
		
		try
		{
			var pb = new Gdk.Pixbuf.from_file(path);
			FileUtils.remove(path);
			return pb;
		}
		catch (GLib.Error e) { error(e.message); return null; }
	}
	
	/**
	 * Handles {@link Slide.changed}
	 */
	private void on_slide_changed(Slide slide)
	{
		Slide s;
		foreach (var itr in document.slides)
		{
			document.slides.get(itr, Document.COL_SLIDE, out s);
			if (s == slide)
			{
				slide_redraw(itr);
				return;
			}
		}
	}
}

