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
 * Abstract base for a simple implementation of a widget using
 * {@link Source.List}.
 *
 * Source.BaseView creates a {@link Source.List} and a Gtk.Bin. These can be
 * placed into container widgets by subclasses.
 */
public abstract class Source.BaseView : Gtk.Alignment
{
	/**
	 * The content view.
	 */
	protected Gtk.Alignment bin;
	
	/**
	 * The {@link Source.List} for this Source.BaseView.
	 */
	protected Source.List list;
	
	/**
	 * The width request of this Source.BaseView's {@link Source.List}.
	 */
	public int list_width_request
	{
		get { return list.width_request; }
		set { list.width_request = value; }
	}
	
	/**
	 * Creates the list and bin widgets. Should be called by subclass
	 * constructors.
	 */
	public BaseView()
	{
		// create widgets
		bin = new Gtk.Alignment(0, 0, 1, 1);
		list = new Source.List(bin);
		
		// set properties
		set(0, 0, 1, 1);
	}
	
	/**
	 * Adds a {@link Source.BaseGroup} subclass to this
	 * Source.BaseView's {@link Source.List}.
	 *
	 * @param group The group to add.
	 */
	public void add_group(Source.BaseGroup group)
	{
		list.add_group(group);
	}
}

