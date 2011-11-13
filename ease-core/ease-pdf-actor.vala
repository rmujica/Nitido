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
 * Actor displaying a {@link PdfElement}.
 */
public class Ease.PdfActor : Actor
{
	private Clutter.CairoTexture texture;
	private int current_page;
	private Poppler.Document doc;
	private PdfElement pdf_element;
	
	/**
	 * Instantiates a new PdfActor from an Element.
	 *
	 * @param e The represented element.
	 * @param c The context of this Actor (Presentation, Sidebar, Editor)
	 */
	public PdfActor(PdfElement e, ActorContext c)
	{
		base(e, c);
		
		pdf_element = e;
		
		contents = new Clutter.Group();
		contents.width = e.width;
		contents.height = e.height;
		x = e.x;
		y = e.y;
		add_actor(contents);
		
		current_page = e.displayed_page;
		doc = e.pdf_doc;
		draw_page();
		
		// redraw when the element is changed
		e.changed.connect(() => {
			current_page = e.displayed_page;
			draw_page();
		});
	}
	
	private void draw_page()
	{
		// get the current page
		var page = doc.get_page(current_page);
		double width = 0, height = 0;
		page.get_size(out width, out height);
		
		// create a texture
		if (texture == null)
		{
			texture = new Clutter.CairoTexture((int)width, (int)height);
			(contents as Clutter.Group).add_actor(texture);
			
			texture.width = contents.width;
			texture.height = contents.height;
			
			contents.notify["width"].connect((obj, pspec) => {
				texture.width = contents.width;
			});
			
			contents.notify["height"].connect((obj, pspec) => {
				texture.height = contents.height;
			});
		}
		
		// otherwise, set the size
		else
		{
			texture.set_surface_size((int)width, (int)height);
		}
		
		// draw the texture
		texture.clear();
		var cr = texture.create();
		pdf_element.background.cairo_render(cr, (int)width, (int)height,
		                                    element.parent.parent.path);
		page.render(cr);
	}
}
