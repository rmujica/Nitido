/*
  TODO :
  - escaping the description tags (or show the markup maybe?)
  - asyncing
  - getting licence and author's realname based on the IDs we get right now
  - make a nice combo-box for licenses
  - make the UI prettier
  - split out in a common Ease.ResourceImporter dialog or something
  - raise accuracy (ie use the keywords to search tags _and_ description, and others) 50% DONE
  - get the next set of photos (use the "page" param of flickr.photos.search)
  - show a tiny spinner when loading
*/

public class Ease.FlickrService : Plugin.ImportService {

	// Flickr stuff
	private const string api_key = "17c40bceda03e0d6f947b001e7c62058";
	private const string secret = "a7c16179a409418b";
	private const string URL_FORMAT =
		"http://farm%i.static.flickr.com/%s/%s_%s.jpg";

	// Json parser
	private Json.Parser parser = new Json.Parser();
	
	// CC license filter
	private Gtk.CheckButton share_alike;
	private Gtk.CheckButton for_commercial;
	
	// CC license IDs - No derivatives doesn't make sense so we don't have them
	private const string CC_BY = "4,";
	private const string CC_BY_NC = "2,";
	private const string CC_BY_NC_SA = "1,";
	private const string CC_BY_SA = "5,";
	
	public override Rest.Proxy create_proxy()
	{
		return new Rest.FlickrProxy(api_key, secret);
	}
	
	public override Rest.ProxyCall create_call(Rest.Proxy proxy, string search)
	{
		// create a string of licenses
		string licenses;
		if (share_alike.active)
		{
			licenses = CC_BY_SA;
			if (!for_commercial.active) licenses += CC_BY_NC_SA;
		}
		else
		{
			licenses = CC_BY;
			if (!for_commercial.active) licenses += CC_BY_NC;
		}
		
		var call = proxy.new_call ();
		call.set_function("flickr.photos.search");
		call.add_params("tags", search,
		                "tag_mode", "all",
		                "per_page", "10",
		                "format", "json",
		                "sort", "relevance",
		                /* Flickr adds a function around the JSON payload,
		                   setting 'nojsoncallback' disable that: we get
		                only plain JSON. */
		                "nojsoncallback", "1",
		                // chop off the last comma from the licences string
		                "license", licenses.substring(0, licenses.length - 1),
		                /* Extras info to fetch. */
		                "extras", "description,license",
		                null);
		return call;
	}
	
	public override Gtk.Widget? extra_widget()
	{
		// create a container
		var box = new Gtk.HBox(false, 4);
		
		// create checkboxes to filter CC licenses
		share_alike = new Gtk.CheckButton.with_label(_("Share Alike"));
		for_commercial =
			new Gtk.CheckButton.with_label(_("For Commercial Use"));
		
		// pack them in
		box.pack_start(share_alike, false, false, 0);
		box.pack_start(for_commercial, false, false, 0);
		
		return box;
	}
	
	public override void parse_data(string jsondata)
	{
		if (jsondata == null) return;

		try
		{
			parser.load_from_data (jsondata);
		}
		catch (Error e)
		{
			error("Couldn't parse JSON data: %s", e.message);
		}

		Json.Object obj = parser.get_root().get_object();

		var stat = obj.get_string_member("stat");
		if (stat != "ok")
		{
			warning("The request failed : \nError code: %G\nMessage: %s",
			        obj.get_int_member("code"),
			        obj.get_string_member("message"));
			return;
		}

		var photos = obj.get_object_member("photos");
		var photo_array = photos.get_array_member("photo");

		// TODO : optimization
		photo_array.foreach_element((array, index, element) => {
			iconview_add_thumbnail_from_json(array, index, element);
		});
	}
	
	public void iconview_add_thumbnail_from_json(Json.Array array,
	                                             uint index,
	                                             Json.Node element)
	{
		Json.Object photo = element.get_object();
		int64 farm = photo.get_int_member("farm");
		var secret = photo.get_string_member("secret");
		var server = photo.get_string_member("server");
		var id = photo.get_string_member("id");
		
		var image = new FlickrMedia();
		image.file_link = URL_FORMAT.printf(farm, server, id, secret, "z");
		image.thumb_link = URL_FORMAT.printf(farm, server, id, secret, "m");
		// TODO : unittest to track Flickr API changes.
		// TODO : license
		image.title = photo.get_string_member("title");
		image.description =
			photo.get_object_member("description").
			get_string_member("_content");
		image.author = photo.get_string_member("owner");
		
		add_media(image);
	}
}

