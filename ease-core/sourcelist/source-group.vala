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
 * A group in a {@link Source.List}.
 *
 * Source.Group can contain any amount of {@link Source.Item}s. Above these items,
 * a header is shown in order to categorize a {@link Source.List}.
 */
public class Source.Group : BaseGroup
{
	/**
	 * The Gtk.VBox containing the header and items_box.
	 */
	private Gtk.VBox all_box;
	
	/**
	 * Create a new, empty, Source.Group.
	 *
	 * @param title The header of the Source.Group.
	 */
	public Group(string title)
	{
		base(title);
		
		all_box = new Gtk.VBox(false, 0);
		all_box.pack_start(header_align, false, false, 0);
		all_box.pack_start(items_align, false, false, 0);
		add(all_box);
	}
}

