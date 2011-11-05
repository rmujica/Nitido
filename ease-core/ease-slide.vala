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
 * The internal representation of a slide
 *
 * A Slide is owned by a {@link Document} and has {@link Element}
 * children. The currently selected Slide is often acted upon by an
 * EditorWindow (from main Ease, not core).
 */
public class Ease.Slide : GLib.Object, UndoSource
{
	public const string IMAGE_TYPE = "EaseImageElement";
	public const string SHAPE_TYPE = "EaseShapeElement";
	public const string VIDEO_TYPE = "EaseVideoElement";
	public const string PDF_TYPE = "EasePdfElement";

	/**
	 * The {@link Element}s contained by this Slide
	 */
	internal Gee.LinkedList<Element> elements = new Gee.LinkedList<Element>();
	
	/**
	 * The Slide's transition
	 */
	public Transition transition { get; set; }
	
	/**
	 * The variant (if any) of the Slide's transition
	 */
	public TransitionVariant variant { get; set; }
	
	/**
	 * The duration of this Slide's transition
	 */
	public double transition_time { get; set; }
	
	/**
	 * The duration of this Slide's transition, in milliseconds
	 */
	public uint transition_msecs
	{
		get { return (uint)(transition_time * 1000); }
		set { transition_time = value / 1000f; }
	}
	
	/**
	 * If the slide advances automatically or on key press
	 */
	public bool automatically_advance { get; set; }
	
	/**
	 * If the slide advances automatically, the amount of delay
	 */
	public double advance_delay { get; set; }
	
	/**
	 * The background of this Slide.
	 */
	public Background background { get; set; }
	
	/**
	 * The absolute path of the background image, if one is set.
	 */
	public string background_abs
	{
		owned get
		{
			string p = parent == null ? theme.path : parent.path;
			return Path.build_filename(p, background.image.filename);
		}
	}
	
	/**
	 * The {@link Document} that this Slide is part of
	 */
	internal Document parent { get; set; }
	
	/**
	 * The width of the Slide's parent {@link Document}.
	 */
	public int width { get { return parent.width; } }
	
	/**
	 * The height of the Slide's parent {@link Document}.
	 */
	public int height { get { return parent.height; } }
	
	/**
	 * The aspect ratio of the Slide's parent {@link Document}.
	 */
	public float aspect { get { return parent.aspect; } }
	
	/**
	 * The {@link Theme} that this Slide is based on.
	 */
	internal Theme theme { get; set; }
	
	/**
	 * The master slide ID this slide is based on.
	 */
	public string master { get; set; }
	
	/**
	 * The number of {@link Element}s on this Slide
	 */
	public int count { get { return elements.size; } }
	
	/**
	 * Requests that the player advance past this Slide.
	 */
	public signal void request_advance(Element sender);
	
	/**
	 * The next Slide in this Slide's {@link Document}.
	 */
	public Slide? next
	{
		owned get
		{
			for (int i = 0; i < parent.slides.size - 1; i++)
			{
				if (parent.get_slide(i) == this)
				{
					return parent.get_slide(i + 1);
				}
			}
			return null;
		}
	}
	
	/**
	 * The previous Slide in this Slide's {@link Document}.
	 */
	public Slide? previous
	{
		owned get
		{
			for (int i = 1; i < parent.slides.size; i++)
			{
				if (parent.get_slide(i) == this)
				{
					return parent.get_slide(i - 1);
				}
			}
			return null;
		}
	}
	
	/**
	 * Emitted when an {@link Element} or property of this Slide is changed.
	 */
	public signal void changed(Slide self);
	
	/**
	 * Emitted when the background of this Slide is altered in any way.
	 */
	public signal void background_changed(Slide self);
	
	/**
	 * Emitted when an {@link Element} is added to this Slide.
	 */
	public signal void element_added(Slide self, Element element, int index);
	
	/**
	 * Emitted when an {@link Element} is added to this Slide.
	 */
	public signal void element_removed(Slide self, Element element, int index);
	
	/**
	 * Emitted when an {@link Element} is repositioned.
	 */
	public signal void element_reordered(Slide self, Element element);
	
	/**
	 * Updates this slide's title.
	 */
	internal signal void title_changed(Slide self, string title);
	
	/**
	 * Resets this slide's title to its default.
	 */
	internal signal void title_reset(Slide self);
	
	/**
	 * Create a new Slide.
	 */
	public Slide()
	{
		background = new Background();
		
		// inspect undo actions passed through the slide, check for bg changes
		undo.connect((item) => {
			if (background.owns_undoitem(item)) background_changed(this);
		});
		
		// update the slide's title when the title element changes
		forwarded.connect((item) => {
			if (item is UndoAction)
			{
				foreach (var pair in (item as UndoAction).pairs)
				{
					if (pair.property == "text") update_title(pair.object);
				}
			}
		});
	}
	
	/**
	 * Create a new Slide assigned to a {@link Document}.
	 * 
	 * Used for loading previously saved files. 
	 *
	 * @param owner The {@link Document} this slide is a part of.
	 */
	public Slide.with_owner(Document owner)
	{
		this();
		parent = owner;
	}
	
	/**
	 * Constructs a Slide from a JsonObject.
	 */
	internal Slide.from_json(Json.Object obj, Document owner)
	{
		this();
		
		parent = owner;
		
		var slide = new Slide();
		
		// get the slide's master
		master = obj.get_string_member("master");
		
		// read the slide's transition properties
		transition = Transition.from_string(
			obj.get_string_member("transition"));
			
		variant = TransitionVariant.from_string(
			obj.get_string_member("variant"));
			
		transition_time = obj.get_string_member("transition_time").to_double();
			
		automatically_advance = 
			obj.get_string_member("automatically_advance").to_bool();
			
		advance_delay =
			obj.get_string_member("advance_delay").to_double();
		
		// read the slide's background properties
		background =
			new Background.from_json(obj.get_object_member(Theme.BACKGROUND));
		
		// parse the elements
		var elements = obj.get_array_member("elements");
		
		for (var i = 0; i < elements.get_length(); i++)
		{
			var node = elements.get_object_element(i);
			
			// find the proper type
			var type = node.get_string_member(Theme.ELEMENT_TYPE);
			Element e;
			
			switch (type)
			{
				case IMAGE_TYPE:
					e = new ImageElement.from_json(node);
					break;
				case SHAPE_TYPE:
					e = new ShapeElement.from_json(node);
					break;
				case VIDEO_TYPE:
					e = new VideoElement.from_json(node);
					break;
				case PDF_TYPE:
					e = new PdfElement.from_json(node, this);
					break;
				default: // text element, probably plugins later...
					e = new TextElement.from_json(node);
					break;
			}
			
			e.element_type = type;
			append(e);
		}
	}
	
	internal Json.Node to_json()
	{
		var node = new Json.Node(Json.NodeType.OBJECT);
		var obj = new Json.Object();
		
		// write the slide's master
		obj.set_string_member("master", master);
		
		// write the slide's transition properties
		obj.set_string_member("transition", transition.to_string());
		obj.set_string_member("variant", variant.to_string());
		obj.set_string_member("transition_time", transition_time.to_string());
		obj.set_string_member("automatically_advance",
		                      automatically_advance.to_string());
		obj.set_string_member("advance_delay", advance_delay.to_string());
		
		// write the slide's background properties
		obj.set_object_member(Theme.BACKGROUND, background.to_json());
		
		// add the slide's elements
		var json_elements = new Json.Array();
		foreach (var e in elements)
		{
			Json.Node e_node = new Json.Node(Json.NodeType.OBJECT);
			e_node.set_object(e.to_json());
			json_elements.add_element(e_node.copy());
		}

		obj.set_array_member("elements", json_elements);
		
		node.set_object(obj);
		return node;
	}
	
	/**
	 * Adds an {@link Element} to this slide at a specified index.
	 *
	 * @param index The index to add the {@link Element} at.
	 * @param e The {@link Element} to add.
	 */
	public void add(int index, Element e)
	{
		add_actual(index, e, true);
	}
	
	/**
	 * Actual adds an Element.
	 */
	internal void add_actual(int index, Element e, bool emit_undo)
	{
		e.parent = this;
		elements.insert(index, e);
		element_added(this, e, index);
		listen(e);
		update_title(e);
		if (emit_undo) undo(new ElementAddUndoAction(e));
		changed(this);
	}
	
	/**
	 * Adds an {@link Element} to this slide at the end index.
	 * 
	 * @param e The element to add;.
	 */
	public void append(Element e)
	{
		add(count, e);
	}
	
	/**
	 * Removes an {@link Element} from this slide.
	 */
	public void remove(Element e)
	{
		remove_actual(e, true);
	}
	
	/**
	 * Actually removes an Element.
	 */
	internal void remove_actual(Element e, bool emit_undo)
	{
		if (emit_undo) undo(new ElementRemoveUndoAction(e));
		var index = index_of(e);
		elements.remove(e);
		element_removed(this, e, index);
		silence(e);
		
		if (e is TextElement)
		{
			if ((e as TextElement).identifier == Theme.TITLE_TEXT ||
			    (e as TextElement).identifier == Theme.HEADER_TEXT)
			{
				title_reset(this);
			}
		}
		changed(this);
	}
	
	/**
	 * Removed an {@link Element} from this slide, by index.
	 */
	public void remove_at(int index)
	{
		var e = elements.get(index);
		remove(e);
	}
	
	/**
	 * Returns the index of the specified {@link Element}
	 */
	public int index_of(Element e)
	{
		return elements.index_of(e);
	}
	
	/**
	 * Returns the {@link Element} at the specified index.
	 */
	public Element element_at(int i)
	{
		return elements.get(i);
	}
	
	/**
	 * Raises the given element up one index. Automatically sends an
	 * {@link UndoItem}.
	 */
	public void raise(Element element)
	{
		if (element == elements.last()) return;
		
		var index = elements.index_of(element);
		var temp = elements.get(index + 1);
		elements.set(index + 1, element);
		elements.set(index, temp);
		element_reordered(this, element);
		undo(new ElementReorderUndoAction(element, index, index + 1));
	}
	
	/**
	 * Lowers the given element down one index. Automatically sends an
	 * {@link UndoItem}.
	 */
	public void lower(Element element)
	{
		if (element == elements.first()) return;
		
		var index = elements.index_of(element);
		var temp = elements.get(index - 1);
		elements.set(index - 1, element);
		elements.set(index, temp);
		element_reordered(this, element);
		undo(new ElementReorderUndoAction(element, index, index - 1));
	}
	
	/**
	 * Raises the element to the top. Automatically sends an
	 * {@link UndoItem}.
	 */
	public void raise_top(Element element)
	{
		if (element == elements.last()) return;
		
		var index = elements.index_of(element);
		elements.remove(element);
		elements.offer_tail(element);
		element_reordered(this, element);
		undo(new ElementReorderUndoAction(element, index,
		                                  elements.index_of(element)));
	}
	
	/**
	 * Lowers the element to the bottom. Automatically sends an
	 * {@link UndoItem}.
	 */
	public void lower_bottom(Element element)
	{
		if (element == elements.first()) return;
		
		var index = elements.index_of(element);
		elements.remove(element);
		elements.offer_head(element);
		element_reordered(this, element);
		undo(new ElementReorderUndoAction(element, index,
		                                  elements.index_of(element)));
	}
	
	/**
	 * Reorders an Element. Does not create an {@link UndoItem}.
	 */
	internal void reorder(Element element, int current, int target)
	{
		elements.remove(element);
		elements.insert(target, element);
		element_reordered(this, element);
	}
	
	/** 
	 * Draws the {@link Slide} to a Cairo.Context.
	 *
	 * @param context The Cairo.Context to draw to.
	 */
	public void cairo_render(Cairo.Context context,
	                         bool use_small) throws GLib.Error
	{
		if (parent == null)
			throw new GLib.Error(0, 0, "Slide must have a parent document");
		
		cairo_render_sized(context, parent.width, parent.height, use_small);
	}
	
	/**
	 * Draws the slide with Cairo at a specified size.
	 *
	 * @param context The Cairo.Context to draw to.
	 * @param w The width to render at.
	 * @param h The height to render at.
	 */
	public void cairo_render_sized(Cairo.Context context, int w, int h,
	                               bool use_small) throws GLib.Error
	{
		context.save();
		cairo_render_background(context, w, h, use_small);
		context.restore();
		
		foreach (var e in elements)
		{
			context.save();
			context.translate(e.x, e.y);
			e.cairo_render(context, use_small);
			context.restore();
		}
	}
	
	/** 
	 * Draws the slide's background to a Cairo.Context at a specified size.
	 *
	 * @param cr The Cairo.Context to draw to.
	 * @param w The width to render at.
	 * @param h The height to render at.
	 */
	public void cairo_render_background(Cairo.Context cr,
	                                    int w, int h,
	                                    bool use_small) throws GLib.Error
	{
		background.cairo_render(cr, w, h,
		                        parent == null ? theme.path : parent.path,
		                        use_small);
	}
	
	/**
	 * Creates HTML markup for this Slide.
	 * 
	 * The <div> tag for this Slide is appended to the "HTML" parameter.
	 *
	 * @param html The HTML string in its current state.
	 * @param exporter The {@link HTMLExporter}, for the path and progress.
	 * @param amount The amount progress should increase by when done.
	 * @param index The index of this slide.
	 */
	public void to_html(ref string html,
	                    HTMLExporter exporter,
	                    double amount,
	                    int index)
	{
		// create the slide opening tag
		html += "<div class=\"slide\" id=\"slide" +
		        index.to_string() + "\" ";
		
		switch (background.background_type)
		{
			case BackgroundType.COLOR:
				// give the slide a background color
				html += "style=\"background-color: " +
					    background.color.clutter.to_string().
					    substring(0, 7) + "\">";
				break;
			
			case BackgroundType.GRADIENT:
				// close opening div
				html += ">";
				
				var dir = Temp.request();
				var surface = new Cairo.ImageSurface(Cairo.Format.ARGB32,
						                             (int)width, (int)height);
				var cr = new Cairo.Context(surface);
				cairo_render(cr, false);
		
				var path = Path.build_filename(
					dir, exporter.render_index.to_string());
				surface.write_to_png(path);
				var output = exporter.copy_rendered(path);
		
				// open the img tag
				html += "<img ";
		
				// set the image's style
				html += "style=\"";
				html += "left: 0px;";
				html += " top: 0px;";
				html += " width:" + parent.width.to_string() + "px;";
				html += " height:" + parent.height.to_string() + "px;";
				html += " position: absolute;\" ";
		
				// add the image
				html += "src=\"" +
						(exporter.basename +
						 " Media/" + output).replace(" ", "%20") +
						"\" alt=\"PDF\" />";
						      
				break;
			
			case BackgroundType.IMAGE:
				// close the tag
				html += ">";
			
				// add the background image
				html += "<img src=\"" +
					    (exporter.basename + " " +
					     background.image.filename).replace(" ", "%20") +
					    "\" alt=\"Background\" width=\"" +
					    parent.width.to_string() + "\" height=\"" +
					    parent.height.to_string() + "\"/>";

				// copy the image file
				exporter.copy_file(background.image.filename, parent.path);
				break;
		}
		
		// add tags for each Element
		foreach (var e in elements)
		{
			e.to_html(ref html, exporter, amount / elements.size);
		}
		
		html += "</div>\n";
	}
	
	/**
	 * Updates the slide's title if the given object is a TextElement with the
	 * {@link Theme.TITLE_TEXT} or {@link Theme.HEADER_TEXT} identifier.
	 */
	private void update_title(GLib.Object object)
	{
		if (object is TextElement)
		{
			if ((object as TextElement).identifier == Theme.TITLE_TEXT || 
			    (object as TextElement).identifier == Theme.HEADER_TEXT)
			{
				title_changed(this, (object as TextElement).text);
			}
		}
	}
	
	/**
	 * Return's the slide's title from an element, or null if it doesn't have
	 * one.
	 */
	internal string? get_title()
	{
		foreach (var element in this)
		{
			if (element is TextElement)
			{
				if ((element as TextElement).identifier == Theme.TITLE_TEXT || 
					(element as TextElement).identifier == Theme.HEADER_TEXT)
				{
					var ret = (element as TextElement).text;
					return ret.length > 0 ? ret : null;
				}
			}
		}
		return null;
	}

	// foreach iteration
	
	/**
	 * Returns an iterator that can be used with foreach.
	 */
	public Iterator iterator()
	{
		return new Iterator(this);
	}
	
	/**
	 * Iterates over this Slide's elements.
	 */
	public class Iterator
	{
		private int i = 0;
		private Slide self;
		
		public Iterator(Slide slide)
		{
			self = slide;
		}
		
		public bool next()
		{
			return i < self.elements.size;
		}
		
		public Element get()
		{
			i++;
			return self.elements.get(i - 1);
		}
	}
}

