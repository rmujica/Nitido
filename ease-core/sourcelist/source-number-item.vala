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
 * A {@link Item} that can display a number on the right side.
 */
public class Source.NumberItem : Source.Item
{
	/**
	 * The right label widget, which can display a number if desired.
	 */
	private Gtk.Label right_label;
	
	/**
	 * A number, displayed on the righthand side of the Source.Item. If
	 * notification is 0, the label is not displayed.
	 */
	public int notification
	{
		get { return notification_priv; }
		set
		{
			if (value == notification_priv) return;
			
			// if value is 0, notification_priv can't be
			if (value == 0)
			{
				// therefore, the widget has been added, so remove it
				right_align.remove(right_label);
			}
			
			// update the label
			right_label.label = (selected ?
			                     FORMAT_RIGHT_OLD : 
			                     FORMAT_RIGHT_NEW).printf(value);
			
			// if necessary, add the label
			if (notification_priv == 0)
			{
				right_align.add(right_label);
			}
			
			// store the value
			notification_priv = value;
		}
	}
	
	/**
	 * Private store for notification value
	 */
	private int notification_priv = 0;
	
	/**
	 * Creates a Source.NumberItem with a customizable icon and text.
	 *
	 * @param text The text to display in the source item.
	 * @param img The image widget to use (note that this icon should use
	 * the Gtk.IconSize constant ICON_SIZE to fit in with other items).
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public NumberItem(string text, Gtk.Image img, Gtk.Widget? widg)
	{
		base(text, img, widg);
		
		right_label = new Gtk.Label("");
		right_label.use_markup = true;
		
		clicked.connect((self) => {
			// remove bold from notification text
			right_label.label = FORMAT_RIGHT_OLD.printf(notification);
		});
	}
	
	/**
	 * Creates a Source.NumberItem with a stock icon and customizable text.
	 *
	 * @param text The text to display in the source item.
	 * @param item The stock item to take the icon from.
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public NumberItem.from_stock_icon(string text, string item,
	                                  Gtk.Widget? widg)
	{
		this(text, new Gtk.Image.from_stock(item, ICON_SIZE), widg);
	}
	
	/**
	 * Creates a Source.NumberItem with a stock icon and customizable text.
	 *
	 * @param text The text to display in the source item.
	 * @param item The stock item to take the label from.
	 * @param img The image widget to use (note that this icon should use
	 * the Gtk.IconSize constant ICON_SIZE to fit in with other items).
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public NumberItem.from_stock_text(string item, Gtk.Image img,
	                                  Gtk.Widget? widg)
	{
		Gtk.StockItem stock = Gtk.StockItem();
		if (Gtk.stock_lookup(item, stock))
		{
			this(stock.label.replace("_", ""), img, widg);
		}
	}
	
	/**
	 * Creates a Source.NumberItem with a stock icon and text.
	 *
	 * @param item The stock item to take the icon and text from.
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public NumberItem.from_stock(string item, Gtk.Widget? widg)
	{
		Gtk.StockItem stock = Gtk.StockItem();
		if (Gtk.stock_lookup(item, stock))
		{
			this(stock.label.replace("_", ""),
			     new Gtk.Image.from_stock(item, ICON_SIZE),
			     widg);
		}
	}
}
