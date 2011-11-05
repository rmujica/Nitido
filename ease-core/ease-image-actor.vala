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
 * {@link Actor} for images
 *
 * ImageActor can represent either a bitmap or vector image, as it is
 * backed by {@link Clutter.Texture}. This should be automatically
 * handled by the represented {@link Element} and Clutter.
 */
public class Ease.ImageActor : Actor
{
	/**
	 * Instantiates a new ImageActor from an Element.
	 * 
	 * ImageActor can represent either a bitmap or vector image, as it is
	 * backed by {@link Clutter.Texture}. This should be automatically
	 * handled by the represented {@link Element} and Clutter.
	 *
	 * @param e The represented element.
	 * @param c The context of this Actor (Presentation, Sidebar, Editor)
	 */
	public ImageActor(ImageElement e, ActorContext c)
	{
		base(e, c);
		
		try
		{
			contents = new Clutter.Texture.from_file(e.full_filename);
		}
		catch (GLib.Error e)
		{
			stdout.printf(_("Error loading ImageActor: %s\n"), e.message);
		}
		finally
		{
			add_actor(contents);
			contents.width = e.width;
			contents.height = e.height;
			x = e.x;
			y = e.y;
			
			e.notify["filename"].connect((obj, spec) => {
				(contents as Clutter.Texture).filename = e.full_filename;
			});
		}
	}
}

