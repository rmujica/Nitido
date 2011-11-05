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
 * A {@link Item} with a Gtk.Spinner on the right side.
 */
public class Source.SpinnerItem : Source.Item
{
	/**
	 * The spinner on the right side of the widget.
	 */
	private Gtk.Spinner spinner = new Gtk.Spinner();
	
	/**
	 * Stops and hides the spinner.
	 */
	public void stop()
	{
		spinner.stop();
		if (spinner.get_parent() == right_align) right_align.remove(spinner);
	}
	
	/** 
	 * Starts and shows the spinner.
	 */
	public void start()
	{
		spinner.start();
		if (spinner.get_parent() != right_align) right_align.add(spinner);
	}
	
	/**
	 * Whether or not the spinner is currently visible and spinning.
	 */
	public bool spinning
	{
		get { return spinner.get_parent() == right_align; }
		set
		{
			spinner.visible = value;
			if (value) spinner.start();
			else spinner.stop();
		}
	}
	 
	/**
	 * Creates a Source.SpinnerItem with a customizable icon and text.
	 *
	 * @param text The text to display in the source item.
	 * @param img The image widget to use (note that this icon should use
	 * the Gtk.IconSize constant ICON_SIZE to fit in with other items).
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public SpinnerItem(string text, Gtk.Image img, Gtk.Widget? widg)
	{
		base(text, img, widg);
		spinner.show();
	}
	
	/**
	 * Creates a Source.SpinnerItem with a stock icon and customizable text.
	 *
	 * @param text The text to display in the source item.
	 * @param item The stock item to take the icon from.
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public SpinnerItem.from_stock_icon(string text, string item,
	                                   Gtk.Widget? widg)
	{
		this(text, new Gtk.Image.from_stock(item, ICON_SIZE), widg);
	}
	
	/**
	 * Creates a Source.SpinnerItem with a stock icon and customizable text.
	 *
	 * @param text The text to display in the source item.
	 * @param item The stock item to take the label from.
	 * @param img The image widget to use (note that this icon should use
	 * the Gtk.IconSize constant ICON_SIZE to fit in with other items).
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public SpinnerItem.from_stock_text(string item, Gtk.Image img,
	                                   Gtk.Widget? widg)
	{
		Gtk.StockItem stock = Gtk.StockItem();
		if (Gtk.stock_lookup(item, stock))
		{
			this(stock.label.replace("_", ""), img, widg);
		}
	}
	
	/**
	 * Creates a Source.SpinnerItem with a stock icon and text.
	 *
	 * @param item The stock item to take the icon and text from.
	 * @param widg The widget that this Source.Item should be linked with.
	 * If null, this Source.Item will only emit the clicked signal when 
	 * clicked, without any automatic UI changes.
	 */
	public SpinnerItem.from_stock(string item, Gtk.Widget? widg)
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
