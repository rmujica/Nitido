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
 * An abstract subclass of {@link Element} with a path to a media file.
 */
public abstract class Ease.MediaElement : Element
{
	/**
	 * Creates a MediaElement from a JsonObject
	 */
	internal MediaElement.from_json(Json.Object obj)
	{
		base.from_json(obj);
		filename = obj.get_string_member(Theme.MEDIA_FILENAME);
		source_filename = obj.get_string_member(Theme.MEDIA_SOURCE_FILENAME);
	}
	
	internal override Json.Object to_json()
	{
		var obj = base.to_json();
		
		obj.set_string_member(Theme.MEDIA_FILENAME, filename);
		obj.set_string_member(Theme.MEDIA_SOURCE_FILENAME, source_filename);
		
		return obj;
	}
	
	public override void signals()
	{
		base.signals();
		notify["filename"].connect((o, p) => changed());
	}
	
	/**
	 * Claims this MediaElement's media file.
	 */
	public override string[] claim_media()
	{
		return { filename };
	}
	
	/**
	 * The path to a media file.
	 */
	public string filename { get; set; }
	
	/**
	 * The path where the media file was originally found.
	 */
	public string source_filename { get; set; }
	
	/**
	 * The full path to a media file.
	 */
	public string full_filename
	{
		owned get
		{
			return Path.build_filename(parent.parent.path, filename);
		}
	}
}
