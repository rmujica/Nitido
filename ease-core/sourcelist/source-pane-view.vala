/*
 * Copyright (c) 2010, Nate Stedman <natesm@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/**
 * An implementation of {@link Source.BaseView} with a Gtk.HPaned
 *
 * Source.View consists of a {@link Source.List}, a separator, and a Gtk.Bin
 * packed into a Gtk.HBox.
 */
public class Source.PaneView : BaseView
{	
	/**
	 * Creates an empty Source.View. Add groups with add_group().
	 *
	 * @param with_separator If true, a Gtk.Separator is included to the right
	 * of the drag handle.
	 */
	public PaneView(bool with_separator)
	{
		// create base widgets
		base();
		
		// create pane widgets and build the view
		var hpane = new Gtk.HPaned();
		hpane.pack1(list, false, false);
		
		// if a separator is requested, build an hbox with it and the bin
		if (with_separator)
		{
			var hbox = new Gtk.HBox(false, 0);
			hbox.pack_start(new Gtk.VSeparator(), false, false, 0);
			hbox.pack_start(bin, true, true, 0);
			hpane.pack2(hbox, true, false);
		}
		
		// otherwise, just pack the bin in
		else
		{
			hpane.pack2(bin, true, false);
		}
		
		// add the hpaned to the view
		add(hpane);
	}
}

