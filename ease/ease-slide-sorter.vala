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
 * A widget displaying an icon view the user can use to sort and delete slides.
 */
internal class Ease.SlideSorter : Gtk.ScrolledWindow
{
	private Gtk.IconView view;
	private Document document;
	
	private const int WIDTH = 100;
	private const int WIDTH_ADDITIONAL = 300;
	private int width;
	
	internal signal void display_slide(Slide s);
	
	internal SlideSorter(Document doc, double zoom)
	{
		document = doc;
		document.slide_added.connect(on_slide_added);
		
		// render dynamic-sized pixbufs
		set_zoom(zoom);
		
		// set up the icon view
		view = new Gtk.IconView.with_model(document.slides);
		view.pixbuf_column = Document.COL_PIXBUF_DYNAMIC;
		view.markup_column = Document.COL_TITLE;
		view.reorderable = true;
		view.item_width = WIDTH;
		
		// add and show the iconview
		add(view);
		view.show();
		
		// when a slide is clicked, show it in the editor
		view.item_activated.connect((v, path) => {
			Gtk.TreeIter itr;
			Slide slide;
			view.model.get_iter(out itr, path);
			view.model.get(itr, Document.COL_SLIDE, out slide);
			display_slide(slide);
		});
	}
	
	internal Slide? delete_slide()
	{
		Slide slide = null, ret_slide = null;
		GLib.List<Slide> slides_to_remove = null;
		
		view.selected_foreach((v, path) => {
			Gtk.TreeIter itr;
			view.model.get_iter(out itr, path);
			view.model.get(itr, Document.COL_SLIDE, out slide);
			slides_to_remove.append(slide);
		});
		
		slides_to_remove.foreach(() => {
			if (document.length < 2) return;
			ret_slide = document.remove_slide(slide);
		});
		
		return ret_slide;
	}
	
	internal void set_zoom(double zoom)
	{
		width = (int)(WIDTH + zoom * WIDTH_ADDITIONAL);
		
		Slide slide;
		foreach (var itr in document.slides)
		{
			// get the slide
			document.slides.get(itr, Document.COL_SLIDE, out slide);
			
			// render a pixbuf at the appropriate size
			document.slides.set(itr, Document.COL_PIXBUF_DYNAMIC,
			                    SlideButtonPanel.pixbuf(slide, width));
		}
	}
	
	internal void on_slide_added(Slide slide, int index)
	{
		var itr = document.slides.index(index);
		document.slides.set(itr, Document.COL_PIXBUF_DYNAMIC,
		                    SlideButtonPanel.pixbuf(slide, width));
	}
}
