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
 * Internal representation of Ease themes.
 */
public class Ease.Theme : GLib.Object
{
	// file paths
	private const string DEFAULTS_PATH = "theme-defaults.json";
	public const string JSON_PATH = "Theme.json";
	private const string MEDIA_PATH = "Media";
	
	// json root elements
	private const string MASTERS = "masters";
	private const string ELEMENTS = "elements";
	private const string MASTER_DEF = "master-defaults";
	private const string ELEMENT_DEF = "element-defaults";
	private const string THEME_TITLE = "title";
	private const string THEME_AUTHOR = "author";
	
	// master slides
	public const string TITLE = "title";
	public const string CONTENT = "content";
	public const string CONTENT_HEADER = "content-header";
	public const string CONTENT_DUAL = "content-dual";
	public const string CONTENT_DUAL_HEADER = "content-dual-header";
	public const string MEDIA = "media";
	public const string MEDIA_HEADER = "media-header";
	public const string EMPTY = "empty";
	
	/**
	 * String identifiers for all master slides available in Ease.
	 */
	public const string[] MASTER_SLIDES = {
		TITLE,
		CONTENT_HEADER,
		CONTENT,
		/*CONTENT_DUAL_HEADER,
		CONTENT_DUAL,
		MEDIA_HEADER,
		MEDIA*/
		EMPTY
	};
	
	// master slide properties
	public const string BACKGROUND_COLOR = "background-color";
	public const string BACKGROUND_GRADIENT = "background-gradient";
	public const string BACKGROUND_IMAGE = "background-image";
	public const string BACKGROUND_IMAGE_SOURCE = "background-image-source";
	public const string BACKGROUND_IMAGE_FILL = "background-image-fill";
	public const string S_IDENTIFIER = "slide-identifier";
	
	// background types
	private const string BACKGROUND_TYPE = "background-type";
	private const string BACKGROUND_TYPE_COLOR = "background-type-color";
	private const string BACKGROUND_TYPE_GRADIENT = "background-type-gradient";
	private const string BACKGROUND_TYPE_IMAGE = "background-type-image";
	public const string BACKGROUND = "background";
	
	// text content types
	public const string TITLE_TEXT = "title-text";
	public const string AUTHOR_TEXT = "author-text";
	public const string CONTENT_TEXT = "content-text";
	public const string HEADER_TEXT = "header-text";
	public const string CUSTOM_TEXT = "custom-text";
	
	// text properties
	public const string TEXT_FONT = "text-font";
	public const string TEXT_SIZE = "text-size";
	public const string TEXT_STYLE = "text-style";
	public const string TEXT_VARIANT = "text-variant";
	public const string TEXT_WEIGHT = "text-weight";
	public const string TEXT_ALIGN = "text-align";
	public const string TEXT_COLOR = "text-color";
	public const string TEXT_TEXT = "text";
	
	// media content types
	public const string CONTENT_MEDIA = "content-media";
	public const string CUSTOM_MEDIA = "custom-media";
	
	// media properties
	public const string MEDIA_FILENAME = "media-filename";
	public const string MEDIA_SOURCE_FILENAME = "media-source-filename";
	
	// shape properties
	public const string SHAPE_TYPE = "shape-type";
	
	// pdf properties
	public const string PDF_DEFAULT_PAGE = "pdf-default-page";
	public const string PDF_ALLOW_FLIPPING = "pdf-allow-flipping";
	
	// gradient types
	public const string GRAD_LINEAR = "linear";
	public const string GRAD_LINEAR_MIRRORED = "linear-mirrored";
	public const string GRAD_RADIAL = "radial";
	
	// image fill types
	public const string IMAGE_STRETCH = "image-fill-stretch";
	public const string IMAGE_ASPECT = "image-fill-aspect";
	public const string IMAGE_ORIGINAL = "image-fill-original";
	
	// video properties
	public const string VIDEO_PLAY_AUTO = "video-play-automatically";
	public const string VIDEO_MUTE = "video-mute";
	public const string VIDEO_END_ACTION = "video-end-action";
	
	// video end actions
	public const string VIDEO_END_STOP = "video-end-stop";
	public const string VIDEO_END_LOOP = "video-end-loop";
	public const string VIDEO_END_CONTINUE = "video-end-continue";
	
	// generic element properties
	public const string E_IDENTIFIER = "element-identifier";
	public const string ELEMENT_TYPE = "element-type";
	
	/**
	 * The text properties, excluding color, which must be set in a custom way.
	 */
	private const string[] TEXT_PROPS = {
		TEXT_FONT,
		TEXT_SIZE,
		TEXT_STYLE,
		TEXT_VARIANT,
		TEXT_WEIGHT,
		TEXT_ALIGN
	};
	
	// generic element properties
	public const string PAD_LEFT = "padding-left";
	public const string PAD_RIGHT = "padding-right";
	public const string PAD_TOP = "padding-top";
	public const string PAD_BOTTOM = "padding-bottom";
	public const string WIDTH = "width";
	public const string HEIGHT = "height";
	public const string X = "x";
	public const string Y = "y";
	public const string HAS_BEEN_EDITED = "has-been-edited";
	
	/**
	 * The title of the Theme.
	 */
	public string title;
	
	/**
	 * The path to the theme's extracted files.
	 */
	public string path { get; set; }
	
	/**
	 * A map of internal master slide settings overriden by the theme.
	 */
	private Gee.Map<string, Gee.Map<string, string>> masters;
	
	/**
	 * A map of internal element settings overriden by the theme.
	 */
	private Gee.Map<string, Gee.Map<string, string>> elements;
	
	/**
	 * A map of master slide settings, used as a fallback for all masters when
	 * the specified master does not provide the given property.
	 *
	 * For example, the background properties are typically the same
	 * throughout the theme. This is an efficient place for those properties.
	 */
	private Gee.Map<string, string> master_defaults;
	
	/**
	 * A map of element settings, used as a fallback for all elements when
	 * the specified element does not provide the given property.
	 *
	 * For example, the text-font property is often the same throughout the
	 * theme. This is an efficient place for properties like that.
	 */
	private Gee.Map<string, string> element_defaults;
	
	/**
	 * A Theme containing default values for elements and master slides.
	 */
	private static Theme defaults
	{
		get
		{
			if (defaults_store != null) return defaults_store;
			return defaults_store = new Theme.json(data_path(DEFAULTS_PATH));
		}
	}
	
	/**
	 * Storage for "defaults" property.
	 */
	private static Theme defaults_store;

	/**
	 * Loads a themes from a directory.
	 *
	 * @param path The path to the theme's directory.
	 */
	public Theme(string dir_path)
	{
		path = dir_path;
		load_from_json(Path.build_filename(path, JSON_PATH));
	}
	
	/**
	 * Loads a Theme from pure JSON, (no archive).
	 *
	 * This constructor is used to load the defaults. It is also used when
	 * loading a previously saved {@link Document}.
	 *
	 * @param json_path The path to the JSON file.
	 */
	public Theme.json(string json_path)
	{
		load_from_json(json_path);
	}
	
	/**
	 * Creates a "shallow" copy of a Theme.
	 *
	 * This constructor does not copy any data from the provided Theme. It
	 * instead creates a new set of references to the same data.
	 *
	 * @param copy_from The Theme to copy from.
	 */
	private Theme.copy(Theme copy_from)
	{
		// note that this doesn't duplicate the maps
		masters = copy_from.masters;
		elements = copy_from.elements;
		master_defaults = copy_from.master_defaults;
		element_defaults = copy_from.element_defaults;
		title = copy_from.title;
		path = copy_from.path;
	}
	
	/**
	 * Copies a Theme's data files to a specified path, returning a Theme
	 * pointing to those files.
	 *
	 * This method uses the private Theme.copy() constructor. This constructor
	 * performs a shallow copy - thus, the Gee.Maps holding the Theme's data
	 * are the same for both themes. This is OK, because Themes should never be
	 * modified after they are first loaded.
	 *
	 * @param copy_to The path to copy the Theme to.
	 */
	public Theme copy_to_path(string copy_to) throws Error
	{
		// copy data files
		recursive_copy(path, copy_to);
		
		// create a copy of this theme and change its path
		var theme = new Theme.copy(this);
		theme.path = copy_to;
		return theme;
	}
	
	/**
	 * Loads a Theme's information from JSON
	 *
	 * This function is used to load the defaults and  to load each
	 * extracted theme.
	 *
	 * @param json_path The path to the JSON file.
	 */
	private void load_from_json(string json_path)
	{
		var parser = new Json.Parser();
		try
		{
			parser.load_from_file(json_path);
		}
		catch (Error e)
		{
			error(_("Error loading theme: %s"), e.message);
		}
		
		// create collections
		masters = new Gee.HashMap<string, Gee.Map<string, string>>();
		elements = new Gee.HashMap<string, Gee.Map<string, string>>();
		master_defaults = new Gee.HashMap<string, string>();
		element_defaults = new Gee.HashMap<string, string>();
		
		// get the document's root element
		unowned Json.Node node = parser.get_root();
		if (node == null) return;
		var root = node.get_object();
		if (root == null) return;
		
		// load theme information, if applicable
		if (root.has_member(THEME_TITLE))
			title = root.get_member(THEME_TITLE).get_string();
		
		// find all masters and element overrides
		fill_map(root, MASTERS, masters);
		fill_map(root, ELEMENTS, elements);
		
		if (root.has_member(MASTER_DEF))
			fill_single_map(root.get_object_member(MASTER_DEF),
			                master_defaults);
		if (root.has_member(ELEMENT_DEF))
			fill_single_map(root.get_object_member(ELEMENT_DEF),
			                element_defaults);
	}
	
	/**
	 * Copies all files under Media/ to a new directory.
	 *
	 * @param target The path to copy media files to.
	 */
	public void copy_media(string target) throws GLib.Error
	{
		var origin_path = Path.build_filename(path, MEDIA_PATH);
		
		if (!File.new_for_path(origin_path).query_exists(null)) return;
		
		var target_path = Path.build_filename(target, MEDIA_PATH);
		
		recursive_copy(origin_path, target_path);
	}
	
	/**
	 * Creates a slide from a theme master.
	 *
	 * @param master The string identifier for the master to use. This should be
	 * a string constant of this class (TITLE, CONTENT, etc.)
	 * @param width The width of the slide.
	 * @param height The height of the slide.
	 */
	public Slide? create_slide(string master, int width, int height)
	{
		Slide slide = new Slide();
		slide.theme = this;
		slide.master = master;
		
		// set the slide background property
		switch (master_get(master, BACKGROUND_TYPE))
		{
			case BACKGROUND_TYPE_COLOR:
				slide.background.color = new Color.
					from_string(master_get(master, BACKGROUND_COLOR));
				slide.background.background_type = BackgroundType.COLOR;
				break;
			case BACKGROUND_TYPE_GRADIENT:
				slide.background.gradient = new Gradient.
					from_string(master_get(master, BACKGROUND_GRADIENT));
				slide.background.background_type = BackgroundType.GRADIENT;
				break;
			case BACKGROUND_TYPE_IMAGE:
				slide.background.image.filename =
					master_get(master, BACKGROUND_IMAGE);
				slide.background.background_type = BackgroundType.IMAGE;
				break;
				
		}
		
		switch (master)
		{
			case TITLE:
				// create the presentation's title
				int left = element_get(TITLE_TEXT, PAD_LEFT).to_int(),
				    h = element_get(TITLE_TEXT, HEIGHT).to_int();
				slide.append(create_text(
					TITLE_TEXT,
					left,
					height / 2 - h - element_get(TITLE_TEXT, PAD_BOTTOM).to_int(),
					width - left - element_get(TITLE_TEXT, PAD_RIGHT).to_int(),
					h
				));
				
				// create the presentation's author field
				left = element_get(AUTHOR_TEXT, PAD_LEFT).to_int();
				slide.append(create_text(
					AUTHOR_TEXT,
					left,
					height / 2 + element_get(AUTHOR_TEXT, PAD_TOP).to_int(),
					width - left - element_get(AUTHOR_TEXT, PAD_RIGHT).to_int(),
					element_get(AUTHOR_TEXT, HEIGHT).to_int()
				));
				break;
				
			case CONTENT:
				int left = element_get(CONTENT_TEXT, PAD_LEFT).to_int(),
				    top = element_get(CONTENT_TEXT, PAD_TOP).to_int();
				
				slide.append(create_text(
					CONTENT_TEXT,
					left,
					top,
					width - left - element_get(CONTENT_TEXT, PAD_RIGHT).to_int(),
					height - top - element_get(HEADER_TEXT, PAD_BOTTOM).to_int()
				));
				break;
				
			case CONTENT_HEADER:
				// create the slide's header
				int left = element_get(HEADER_TEXT, PAD_LEFT).to_int(),
				    top = element_get(HEADER_TEXT, PAD_TOP).to_int();
				
				slide.append(create_text(
					HEADER_TEXT,
					left,
					top,
					width - left - element_get(HEADER_TEXT, PAD_RIGHT).to_int(),
					element_get(HEADER_TEXT, HEIGHT).to_int()
				));
				
				// create the slide's content
				left = element_get(CONTENT_TEXT, PAD_LEFT).to_int();
				top += element_get(HEADER_TEXT, HEIGHT).to_int() +
				       element_get(HEADER_TEXT, PAD_BOTTOM).to_int() +
				       element_get(CONTENT_TEXT, PAD_TOP).to_int();
				slide.append(create_text(
					CONTENT_TEXT,
					left,
					top,
					width - left - element_get(CONTENT_TEXT, PAD_RIGHT).to_int(),
					height - top - element_get(CONTENT_TEXT, PAD_BOTTOM).to_int()
				));
				break;
			
			case CONTENT_DUAL:
			case CONTENT_DUAL_HEADER:
			case MEDIA:
			case MEDIA_HEADER:
			case EMPTY: // empty slides don't have anything
				break;
			default:
				error(_("Invalid master slide title: %s"), master);
				return null;
		}
		
		return slide;
	}
	
	/**
	 * Returns a custom {@link TextElement} with its x and y positions set to 0.
	 */
	public TextElement create_custom_text()
	{
		return create_text(CUSTOM_TEXT, 0, 0,
		                   element_get(CUSTOM_TEXT, WIDTH).to_int(),
		                   element_get(CUSTOM_TEXT, HEIGHT).to_int());
	}
	
	/**
	 * Creates a text element, given an element type and dimensions.
	 */
	private TextElement create_text(string type, int x, int y, int w, int h)
	{
		// error if an improper element type is used
		if (!(type == TITLE_TEXT || type == AUTHOR_TEXT ||
		      type == CUSTOM_TEXT || type == CONTENT_TEXT ||
		      type == HEADER_TEXT))
		{
			error(_("Not a valid text element type: %s"), type);
		}
		
		// otherwise, construct the text element
		var text = new TextElement();
		
		// set text properties
		text.text_font = element_get(type, TEXT_FONT);
		text.text_size_from_string(element_get(type, TEXT_SIZE));
		text.text_style_from_string(element_get(type, TEXT_STYLE));
		text.text_variant_from_string(element_get(type, TEXT_VARIANT));
		text.text_weight_from_string(element_get(type, TEXT_WEIGHT));
		text.text_align_from_string(element_get(type, TEXT_ALIGN));
		
		// set the color property
		text.color = new Color.from_string(element_get(type, TEXT_COLOR));
		
		// set size properties
		text.x = x;
		text.y = y;
		text.width = w;
		text.height = h;
		
		// set base properties
		text.identifier = type;
		text.has_been_edited = false;
		text.text = "";
		
		return text;
	}
	
	/**
	 * Retrieves an element property.
	 *
	 * @param element The element name to search for.
	 * @param prop The property name to search for.
	 */
	private string element_get(string element, string prop)
	{
		// try local specifics
		var map = elements.get(element);
		if (map != null)
		{
			var str = map.get(prop);
			if (str != null) return str;
		}
		
		// try local generics
		var str = element_defaults.get(prop);
		if (str != null) return str;
		
		// use default settings
		if (defaults == this)
		{
			error(_("Could not find property %s on element type %s."),
			      prop, element);
		}
		
		return defaults.element_get(element, prop);
	}
	
	/**
	 * Retrieves an master property.
	 *
	 * @param master The master name to search for.
	 * @param prop The property name to search for.
	 */
	private string master_get(string master, string prop)
	{
		// try local specifics
		var map = masters.get(master);
		if (map != null)
		{
			var str = map.get(prop);
			if (str != null) return str;
		}
		
		// try local generics
		var str = master_defaults.get(prop);
		if (str != null) return str;
		
		// use default settings
		if (defaults == this)
		{
			error(_("Could not find property %s on master type %s."),
			      prop, master);
		}
		
		return defaults.master_get(master, prop);
	}
	
	/**
	 * Returns a string description for a specified master identifier.
	 *
	 * @param master The identifier. This should be a constant of this class.
	 */
	public static string master_description(string master)
	{
		return master_mnemonic_description(master).replace("_", "");
	}
	
	/**
	 * Returns a string description, with mnemonic, for a specified master
	 * identifier.
	 *
	 * @param master The identifier. This should be a constant of this class.
	 */
	public static string master_mnemonic_description(string master)
	{
		switch (master)
		{
			case TITLE:
				return _("_Title slide");
			case CONTENT:
				return _("Content slide _without header");
			case CONTENT_HEADER:
				return _("_Content slide");
			case CONTENT_DUAL:
				return _("Two column slide without _header");
			case CONTENT_DUAL_HEADER:
				return _("T_wo column slide with header");
			case MEDIA:
				return _("M_edia slide without header");
			case MEDIA_HEADER:
				return _("_Media slide");
			case EMPTY:
				return _("Em_pty Slide");
		}
		
		critical(_("%s is not a valid identifier"), master);
		return master;
	}
	
	/**
	 * Finds the master identifier associated with the provided description.
	 *
	 * The description may be a mnemonic.
	 *
	 * @param desc The description, provided by master_description or
	 * master_mnemonic_description.
	 */
	public static string master_from_description(string desc)
	{
		var replaced = desc.replace("_", "");
		
		foreach (var master in MASTER_SLIDES)
		{
			if (master_description(master) == replaced) return master;
		}
		
		critical("Not a valid master description: %s", desc);
		return desc;
	}
	
	/**
	 * Fills a Gee.Map with style property overrides in the form of more
	 * Gee.Maps.
	 *
	 * @param obj The root object.
	 * @param name The name of the JSON array to use.
	 * @param map The map to fill with submaps.
	 */
	private void fill_map(Json.Object obj, string name,
	                      Gee.Map<string, Gee.Map<string, string>> map)
	{
		if (!obj.has_member(name)) return;
		var sub = obj.get_object_member(name);
		if (sub == null) return;
		
		for (unowned List<string>* i = sub.get_members();
		     i != null; i = i->next)
		{
			// get the current object (an array)
			var curr_obj = sub.get_member(i->data).get_object();
			
			// create a map for the values
			var submap = new Gee.HashMap<string, string>();
		
			// add each override to the map
			fill_single_map(curr_obj, submap);
			
			// add the map to the map of overrides
			map.set(i->data, submap);
		}
	}
	
	/**
	 * Fill a Gee.Map with key/value pairs.
	 *
	 * @param obj The json object to use.
	 * @param map The map to fill.
	 */
	private void fill_single_map(Json.Object obj, Gee.Map<string, string> map)
	{
		for (unowned List<string>* j = obj.get_members();
		     j != null; j = j->next)
		{
			map.set(j->data, obj.get_member(j->data).get_string());
		}
	}
}

