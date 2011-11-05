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
 * An expandable group in a {@link Source.List}.
 *
 * Source.ExpandableGroup can contain any amount of {@link Source.Item}s.
 * Above these items, a header is shown in order to categorize a
 * {@link Source.List}. Unlike {@link Source.Group}, which is VBox based,
 * ExpandableGroup can be expanded and contracted.
 */
public class Source.ExpandableGroup : BaseGroup
{
	/**
	 * The Gtk.Expander containing the header and items_box.
	 */
	private Gtk.Expander expander = new Gtk.Expander("");
	
	/**
	 * If the ExpandableGroup's expander is expanded.
	 */
	public bool expanded
	{
		get { return expander.expanded; }
		set { expander.expanded = value; }
	}
	
	/**
	 * Create a new, empty, Source.ExpandableGroup.
	 *
	 * @param title The header of the Source.Group.
	 * @param expanded If the group should be expanded by default.
	 */
	public ExpandableGroup(string title, bool expanded)
	{
		base(title);
		
		expander.label_widget = header_align;
		expander.can_focus = false;
		expander.set_expanded(expanded);
		expander.add(items_align);
		add(expander);
	}
}
