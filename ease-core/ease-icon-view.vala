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
 * A reimplentation, with Clutter, of a large part of the GtkIconView interface.
 */
public class Ease.IconView : Clutter.Group
{
	private const uint ICON_FADE_TIME = 350;
	private const float ICON_FADE_SCALE = 0f;
	private const int ICON_FADE_MODE = Clutter.AnimationMode.EASE_OUT_BACK;

	/**
	 * The amount of spacing, in pixels, between columns.
	 */
	public float column_spacing
	{
		get { return layout.column_spacing; }
		set { layout.column_spacing = value; }
	}
	
	public int columns { get; set; default = -1; }
	
	/**
	 * The amount of padding around each item.
	 */
	public int item_padding { get; set; default = 6; }
	
	/**
	 * The width of each item.
	 */
	public float item_width
	{
		get { return layout.min_column_width; }
		set
		{
			layout.max_column_width = layout.min_column_width = value;
			box.foreach((actor) => (actor as Icon).contents_width = value);
		}
	}
	
	/**
	 * The amount of space at the edges of the icon view.
	 */
	public int margin { get; set; default = 6; }
	
	/**
	 * The column which contains markup. If this is set to anything except -1,
	 * the icon view will use markup and will ignore {@link text_column}.
	 */
	public int markup_column { get; set; default = -1; }
	
	/**
	 * The TreeModel that this icon view is representing. Changes to the model
	 * will be (relatively) immediately reflected in the icon view.
	 */
	public Gtk.TreeModel model
	{
		get { return _model; }
		set
		{
			// don't do extra work please
			if (_model == value) return;
			
			// disconnect old handlers
			_model.row_changed.disconnect(on_model_row_changed);
			_model.row_deleted.disconnect(on_model_row_deleted);
			_model.row_inserted.disconnect(on_model_row_inserted);
			_model.rows_reordered.disconnect(on_model_rows_reordered);
			
			// remove old actors
			box.foreach((actor) => {
				remove_actor(actor);
			});
			
			_model = value;
			
			// add new actors
			_model.foreach((model, path, iter) => {
				box.pack(create_icon(iter), null);
				return false;
			});
			show_all();
			size_box();
			
			// add new handlers
			_model.row_changed.connect(on_model_row_changed);
			_model.row_deleted.connect(on_model_row_deleted);
			_model.row_inserted.connect(on_model_row_inserted);
			_model.rows_reordered.connect(on_model_rows_reordered);
		}
	}
	private Gtk.TreeModel _model;
	
	/**
	 * The amount of pixels surrounding the icon view.
	 */
	public int padding { get; set; default = 6; }
	
	/**
	 * The column containing pixbufs to display.
	 */
	public int pixbuf_column { get; set; default = -1; }
	
	/**
	 * Whether or not the icon view can be rearranged by dragging.
	 */
	public bool reorderable { get; set; default = false; }
	
	/**
	 * The amount of spacing between rows of the icon view.
	 */
	public float row_spacing
	{
		get { return layout.row_spacing; }
		set { layout.row_spacing = value; }
	}
	
	/**
	 * The selection mode of the icon view. Defaults to single selection.
	 */
	public Gtk.SelectionMode selection_mode
		{ get; set; default = Gtk.SelectionMode.SINGLE; }
	
	/**
	 * The amount of space that is placed between the icon and text of an item.
	 */
	public int spacing { get; set; default = 0; }
	
	/**
	 * The column which contains text. If {@link markup_column} is not set to
	 * -1, this property is ignored.
	 */
	public int text_column { get; set; default = -1; }
	
	/**
	 * The color of the text labels.
	 */
	public Clutter.Color text_color { get; set; }
	
	/**
	 * The column that contains tooltips to be displayed.
	 */
	public int tooltip_column { get; set; default = -1; }
	
	/**
	 * The layout manager which actually lays out the icon view and does
	 * the hard work.
	 */
	private Clutter.FlowLayout layout;
	
	/**
	 * The box that contains the arranged actors.'
	 */
	private Clutter.Box box;
	
	/**
	 * The current selection "origin" (where shift-select originates from).
	 */
	private Gtk.TreeRowReference select_origin = null;
	
	/**
	 * Emitted when an icon is activated (ie double clicked).
	 */
	public signal void item_activated(IconView iconview, Gtk.TreePath path);
	
	/**
	 * Emitted when the selection changes.
	 */
	public signal void selection_changed(IconView iconview);
	
	/**
	 * Creates an IconView and sets its model.
	 *
	 * @param model The model to use for the IconView.
	 */
	public IconView.with_model(Gtk.TreeModel model)
	{
		this.model = model;
	}
	
	construct
	{
		// automagic layout makes this whole thing work
		layout = new Clutter.FlowLayout(Clutter.FlowOrientation.HORIZONTAL);
		box = new Clutter.Box(layout);
		add_actor(box);
		
		// defaults
		layout.homogeneous = true;
		row_spacing = 6;
		column_spacing = 6;
		text_color = { 0, 0, 0, 255 };
		
		// size the box appropriately
		notify["width"].connect(() => size_box());
		notify["padding"].connect(() => size_box());
		layout.layout_changed.connect(() => size_box());
		
		// handle column changes
		notify["text-column"].connect(() => {
			if (markup_column != -1) return;
			box.foreach((actor) => {
				(actor as Icon).update_text(text_column, false);
			});
		});
		
		notify["markup-column"].connect(() => {
			if (markup_column == -1) return;
			box.foreach((actor) => {
				(actor as Icon).update_text(markup_column, true);
			});
		});
		
		notify["pixbuf-column"].connect(() => {
			box.foreach((actor) => {
				(actor as Icon).update_pixbuf(pixbuf_column);
			});
		});
		
		notify["text-color"].connect(() => {
			box.foreach((actor) => (actor as Icon).text.color = text_color);
		});
		
		// handle selection mode changes
		notify["selection-mode"].connect(() => {
			switch (selection_mode)
			{
				case Gtk.SelectionMode.NONE:
					box.foreach((actor) => {
						(actor as Icon).selected = false;
					});
				case Gtk.SelectionMode.SINGLE:
				case Gtk.SelectionMode.BROWSE: {
					bool done = true;
					box.foreach((actor) => {
						if ((actor as Icon).selected)
						{
							(actor as Icon).selected = done;
							done = false;
						}
					});
					break;
				}
			}
		});
	}
	
	/**
	 * Resizes the box and icon view to their proper sizes.
	 */
	private void size_box()
	{
		box.x = padding;
		box.y = padding;
		box.width = width - 2 * padding;
		height = box.height + 2 * padding;
	}
	
	/**
	 * Calls the specified {@link ForeachFunc} for each selected icon in the
	 * IconView.
	 *
	 * @param callback The function to call.
	 */
	public void selected_foreach(ForeachFunc callback)
	{
		box.foreach((actor) => {
			if ((actor as Icon).selected)
			{
				callback(this, (actor as Icon).reference.get_path());
			}
		});
	}
	
	/**
	 * A delegate for iterating over an IconView.
	 */ 
	public delegate void ForeachFunc(IconView view, Gtk.TreePath path); 
	
	// signal handlers for model rows
	private void on_model_row_changed(Gtk.TreeModel model,
	                                  Gtk.TreePath path,
	                                  Gtk.TreeIter iter)
	{
		box.foreach((actor) => {
			if (path.compare((actor as Icon).reference.get_path()) == 0)
			{
				(actor as Icon).update_pixbuf(pixbuf_column);
				(actor as Icon).update_text(markup_column != -1 ?
				                            markup_column :
				                            text_column,
				                            markup_column == -1);
			}
		});
		size_box();
	}
	
	private void on_model_row_deleted(Gtk.TreeModel model, Gtk.TreePath path)
	{
		bool removed = false;
		box.foreach((actor) => {
			if (removed) return;
			if ((actor as Icon).reference.get_path().compare(path) == 0)
			{
				// disconnect signals
				(actor as Icon).select.connect(on_icon_select);
				(actor as Icon).activate.connect(on_icon_activate);
				
				// deselect the actor if it is selected, independently of others
				on_icon_select(actor as Icon,
				               Clutter.ModifierType.CONTROL_MASK);
				
				// fade out
				(actor as Icon).fadeout();
				
				// don't remove any more
				removed = true;
			}
		});
	}
	
	private void on_model_row_inserted(Gtk.TreeModel model,
	                                   Gtk.TreePath path,
	                                   Gtk.TreeIter iter)
	{
		// how many icons should go before this one?
		int count = 0;
		box.foreach((actor) => {
			if ((actor as Icon).reference.get_path().compare(path) == -1)
			{
				count++;
			}
		});
		
		// create and add the icon
		var icon = create_icon(iter);
		icon.contents_width = item_width;
		box.pack_at(icon, count, null);
		icon.show();
		size_box();
		
		// fade the icon in
		icon.scale_x = icon.scale_y = ICON_FADE_SCALE;
		icon.scale_gravity = Clutter.Gravity.CENTER;
		icon.animate(ICON_FADE_MODE, ICON_FADE_TIME,
		             "scale-x", 1.0, "scale-y", 1.0, null);
	}
	
	private void on_model_rows_reordered(Gtk.TreeModel model,
	                                     Gtk.TreePath path,
	                                     Gtk.TreeIter iter,
	                                     void* new_order)
	{
		// vapi problem again
		int[] order = (int[])new_order;
	}
	
	// icon signal handlers
	private void on_icon_activate(Icon icon)
	{
		item_activated(this, icon.reference.get_path());
	}
	
	private void on_icon_select(Icon icon, Clutter.ModifierType modifiers)
	{
		// nothing can be selected (not entirely sure why this would be set)
		if (selection_mode == Gtk.SelectionMode.NONE) return;
		
		if ((((modifiers & Clutter.ModifierType.CONTROL_MASK) == 0) &&
		     ((modifiers & Clutter.ModifierType.SHIFT_MASK) == 0)) ||
		    selection_mode == Gtk.SelectionMode.SINGLE ||
		    selection_mode == Gtk.SelectionMode.BROWSE)
		{
			// deselect all others and count how many were selected
			int count = 0;
			box.foreach((actor) => {
				if (actor == icon) return;
				if ((actor as Icon).selected)
				{
					(actor as Icon).selected = false;
					count++;
				}
			});
			
			if (count > 0 || selection_mode == Gtk.SelectionMode.BROWSE)
			{
				// keep the current icon selected or select it
				icon.selected = true;
				select_origin = icon.reference;
			}
			else
			{
				// select/deselect the current icon
				icon.selected = !icon.selected;
				select_origin = icon.selected ? icon.reference : null;
			}
		}
		
		else if ((modifiers & Clutter.ModifierType.CONTROL_MASK) != 0)
		{
			// count the number of currently selected items
			int count = 0;
			selected_foreach(() => count++);
			
			// flip this item
			icon.selected = !icon.selected;
			
			// if this item was the first to be selected
			if (icon.selected && count == 0)
			{
				select_origin = icon.reference;
			}
			
			// if this item was the origin and was deselected
			else if (!icon.selected && select_origin == icon.reference)
			{
				// set the origin to null
				select_origin = null;
				
				// see if there's another selected icon to take its place
				box.foreach((actor) => {
					if (select_origin == null && (actor as Icon).selected)
					{
						select_origin = (actor as Icon).reference;
					}
				});
			}
		}
		else if ((modifiers & Clutter.ModifierType.SHIFT_MASK) != 0)
		{
			// deselect everything if used on the current origin
			if (select_origin == icon.reference)
			{
				// deselect all others and count how many were
				int count = 0;
				box.foreach((actor) => {
					if (actor == icon) return;
					if ((actor as Icon).selected)
					{
						(actor as Icon).selected = false;
						count++;
					}
				});
				
				if (count == 0)
				{
					// deselect the current icon
					icon.selected = false;
					select_origin = null;
				}
			}
			
			// if there's no current origin, ignore the shift
			if (select_origin == null)
			{
				icon.selected = true;
				select_origin = icon.reference;
			}
			
			// select relative to the origin
			else
			{
				var orig_path = select_origin.get_path();
				var icon_path = icon.reference.get_path();
				switch (orig_path.compare(icon_path))
				{
					// origin is before the clicked icon
					case -1:
						box.foreach((actor) => {
							var path = (actor as Icon).reference.get_path();
							(actor as Icon).selected =
								orig_path.compare(path) != 1 &&
							    icon_path.compare(path) != -1;
						});
						break;
					
					// origin is after the clicked icon
					case 1:
						box.foreach((actor) => {
							var path = (actor as Icon).reference.get_path();
							(actor as Icon).selected =
								orig_path.compare(path) != -1 &&
							    icon_path.compare(path) != 1;
						});
						break;
				}
			}
		}
	}
	
	/**
	 * Constructs an Icon for a given tree iterator.
	 */
	private Icon create_icon(Gtk.TreeIter iter)
	{
		// get data from model
		string text;
		Gdk.Pixbuf pixbuf;
		model.get(iter, text_column, out text, pixbuf_column, out pixbuf, -1);
		
		// create an icon
		var p = new Gtk.TreePath.from_string(model.get_string_from_iter(iter));
		var icon = new Icon(new Gtk.TreeRowReference(model, p),
		                    markup_column != -1 ? markup_column : text_column,
		                    markup_column == -1, pixbuf_column,
		                    text_color);
		
		// connect signals
		icon.select.connect(on_icon_select);
		icon.activate.connect(on_icon_activate);
		
		return icon;
	}
	
	/**
	 * An icon (pixbuf and text pair) in the IconView.
	 */
	private class Icon : Clutter.Group
	{
		public Clutter.Texture texture;
		public Clutter.Text text;
		public Gtk.TreeRowReference reference;
		public bool selected
		{
			get { return _selected; }
			set
			{
				_selected = value;
				texture.opacity = selected ? 100 : 255;
			}
		}
		private bool _selected;
		
		public float contents_width
		{
			get { return _contents_width; }
			set
			{
				texture.width = value;
				text.width = value;
				text.y = texture.height + 6;
				_contents_width = value;
			}
		}
		private float _contents_width;
		
		public signal void activate(Icon icon);
		public signal void select(Icon icon, Clutter.ModifierType modifiers);
		
		public Icon(Gtk.TreeRowReference reference, int text_col,
		            bool use_markup, int pixbuf_col,
		            Clutter.Color text_color)
		{
			this.reference = reference;
			
			// create the text actor
			text = new Clutter.Text.with_text("Sans 8", " ");
			text.line_alignment = Pango.Alignment.CENTER;
			text.single_line_mode = false;
			text.color = text_color;
			add_actor(text);
			
			// initial "update" of text and pixbuf
			update_text(text_col, use_markup);
			update_pixbuf(pixbuf_col);
			
			// select or activate when clicked
			reactive = true;
			texture.reactive = true;
			button_press_event.connect((event) => {
				if (event.click_count < 2)
				{
					select(this, event.modifier_state);
				}
				else
				{
					activate(this);
				}
				return false;
			});
		}
		
		/**
		 * Updates the icon's text, using the specified model column.
		 *
		 * @param column The text column in the model.
		 * @param use_markup Whether or not to use Pango markup.
		 */
		public void update_text(int column, bool use_markup)
		{
			// are we using markup?
			text.use_markup = use_markup;
			
			// get an iterator
			var str = reference.get_path().to_string();
			Gtk.TreeIter iter;
			if (reference.get_model().get_iter_from_string(out iter, str))
			{
				// get and set the text
				str = text.text;
				reference.get_model().get(iter, column, out str);
				text.text = str;
			}
		}
		
		/**
		 * Updates the icon's pixbuf, using the specified model column.
		 *
		 * @param column The pixbuf column in the model.
		 */
		public void update_pixbuf(int column)
		{
			// remove the current texture
			if (texture != null)
			{
				remove_actor(texture);
			}
			
			// get an iterator
			var str = reference.get_path().to_string();
			Gtk.TreeIter iter;
			if (reference.get_model().get_iter_from_string(out iter, str))
			{
				// get and set the pixbuf
				Gdk.Pixbuf pb;
				reference.get_model().get(iter, column, out pb);
				
				if (pb == null) return;
				texture =
					GtkClutter.texture_new_from_pixbuf(pb) as Clutter.Texture;
				
				// if all was successful, add the texture	
				if (texture != null)
				{
					texture.keep_aspect_ratio = true;
					texture.width = contents_width;
					text.y = texture.height + 6;
					add_actor(texture);
				}
			}
		}
		
		/**
		 * Removes this Icon from its view.
		 */
		public void fadeout()
		{
			(get_parent() as Clutter.Container).remove_actor(this);
		}
	}
}
