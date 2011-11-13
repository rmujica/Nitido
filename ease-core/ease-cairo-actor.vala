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
 * An actor that automatically uses its {@link Element}'s Cairo rendering.
 */
public class Ease.CairoActor : Actor
{
	private Clutter.CairoTexture tex;
	
	public CairoActor(Element e, ActorContext ctx)
	{
		base(e, ctx);
		
		tex = new Clutter.CairoTexture((uint)e.width, (uint)e.height);
		add_actor(tex);
		contents = tex;
		contents.width = e.width;
		contents.height = e.height;
		x = e.x;
		y = e.y;
		e.changed.connect(draw);
		
		draw();
	}
	
	internal void draw()
	{
		//debug("drawing");
		tex.set_surface_size((uint)element.width, (uint)element.height);
		tex.clear();
		var cr = tex.create();
		try
		{
			element.cairo_render(cr);
		}
		catch (Error e)
		{
			critical("Error rendering CairoActor: %s", e.message);
		}
	}
}
