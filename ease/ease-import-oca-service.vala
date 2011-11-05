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

internal class Ease.OCAService : Plugin.ImportService
{	
	private const string REST_URL =
		"http://www.openclipart.org/media/feed/rss/";
	
	protected override Rest.Proxy create_proxy()
	{
		return new Rest.Proxy(REST_URL, false);
	}

	protected override Rest.ProxyCall create_call(Rest.Proxy proxy,
	                                              string search)
	{
		var call = proxy.new_call();
		call.set_function(search);
		return call;
	}
	
	internal override void parse_data(string data)
	{	
		Xml.Parser.init();
		
		Xml.Doc* doc = Xml.Parser.parse_doc(data);
		// TODO: better error handling
		if (doc == null) return;
		
		Xml.Node* root = doc->get_root_element();
		
		// find the "channel" node
		Xml.Node* channel = root->children;
		for (; channel->name != "channel"; channel = channel->next);
		
		// loop over outermost nodes
		for (Xml.Node* itr = channel->children;
		     itr != null; itr = itr->next)
		{
			if (itr->type != Xml.ElementType.ELEMENT_NODE) continue;
			
			// if the node is an item, add it
			if (itr->name == "item")
			{
				OCAMedia image = new OCAMedia();
				
				for (Xml.Node* tag = itr->children;
				     tag != null; tag = tag->next)
				{
					switch (tag->name)
					{
						case "title":
							image.title = tag->children->content;
							break;
						case "link":
							image.link = tag->children->content;
							break;
						case "dc:creator":
							image.creator = tag->children->content;
							break;
						case "license":
							image.license = tag->children->content;
							break;
						case "description":
							image.description = tag->children->content;
							break;
						case "enclosure":
							for (Xml.Attr* prop = tag->properties;
							     prop != null; prop = prop->next)
							{
								if (prop->name == "url")
								{
									image.file_link = prop->children->content;
								}
							}
							break;
						case "thumbnail":
							for (Xml.Attr* prop = tag->properties;
							     prop != null; prop = prop->next)
							{
								if (prop->name == "url")
								{
									var thumb = prop->children->content;
									image.thumb_link = thumb.replace("90px",
									                                 "125px");
								}
							}
							break;
					}
				}
				
				add_media(image);
			}
		}
	}
}

