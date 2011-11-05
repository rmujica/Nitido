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
 * Abstract base class for a group in a {@link Source.List}.
 *
 * Source.BaseGroup can contain any amount of {@link Source.Item}s. Above
 * these items, a header is shown in order to categorize a {@link Source.List}.
 */
public abstract class Source.BaseGroup : Gtk.Alignment
{
	/**
	 * The group header, displayed on top of the {@link Source.Item}s.
	 */
	private Gtk.Label header;
	
	/**
	 * The Gtk.VBox containing all {@link Source.Item}s.
	 */
	private Gtk.VBox items_box;
	
	/**
	 * Alignment containing header. This widget should be packed in subclasses,
	 * not header itself.
	 */
	protected Gtk.Alignment header_align;
	
	/**
	 * Alignment containing items_box. This widget should be packed in
	 * subclasses, not items_box itself.
	 */
	protected Gtk.Alignment items_align;
	
	/**
	 * Format string for the group header.
	 */
	private const string HEADER_FORMAT = "<b>%s</b>";
	
	/**
	 * Padding between each {@link Source.Item}.
	 */
	private const int ITEM_PADDING = 2;
	
	/**
	 * Padding to the left of all items.
	 */
	private const int ITEMS_PADDING_LEFT = 5;
	
	/**
	 * Padding to the right of all items.
	 */
	private const int ITEMS_PADDING_RIGHT = 5;
	
	/**
	 * Padding above the set of items.
	 */
	private const int ITEMS_PADDING_TOP = 5;
	
	/**
	 * Padding below the set of all items.
	 */
	private const int ITEMS_PADDING_BOTTOM = 10;
	
	/**
	 * Emitted when a child {@link Source.Item} of this group is clicked.
	 *
	 * @param sender The {@link Source.Item} that was clicked.
	 */
	public signal void clicked(Item sender);
	
	/**
	 * Base constructor for subclasses of Source.BaseGroup.
	 *
	 * @param title The header of the Source.BaseGroup.
	 */
	public BaseGroup(string title)
	{
		// create subwidgets
		items_box = new Gtk.VBox(true, ITEM_PADDING);
		items_align = new Gtk.Alignment(0, 0, 1, 0);
		items_align.set_padding(ITEMS_PADDING_TOP,
		                        ITEMS_PADDING_BOTTOM,
		                        ITEMS_PADDING_LEFT,
		                        ITEMS_PADDING_RIGHT);
		header = new Gtk.Label(HEADER_FORMAT.printf(title));
		header.use_markup = true;
		header_align = new Gtk.Alignment(0, 0, 0, 0);
		
		set(0, 0, 1, 0);
		
		// assemble contents
		items_align.add(items_box);
		header_align.add(header);
	}
	
	/**
	 * Adds a {@link Source.Item} to the end of this group.
	 *
	 * @param item The {@link Source.Item} to add.
	 */
	public void add_item(Item item)
	{
		items_box.pack_start(item, false, false, 0);
		item.clicked.connect((sender) => clicked(sender));
	}
}

