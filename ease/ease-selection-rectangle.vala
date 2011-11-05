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
 * Rectangle displayed around the border of selected {@link Actor}s.
 */
internal class Ease.SelectionRectangle : Clutter.Group
{
	private Clutter.Rectangle top;
	private Clutter.Rectangle bottom;
	private Clutter.Rectangle left;
	private Clutter.Rectangle right;
	
	private const Clutter.Color INNER_COLOR = { 255, 255, 255, 255 };
	private const Clutter.Color OUTER_COLOR = { 0, 0, 0, 255 };
	private const int HEIGHT = 6;
	private const int BORDER = 2;
	
	internal SelectionRectangle()
	{
		make(out top);
		make(out bottom);
		make(out left);
		make(out right);
		
		top.height = HEIGHT;
		top.anchor_y = HEIGHT / 2;
		
		bottom.height = HEIGHT;
		bottom.anchor_y = HEIGHT / 2;
		
		left.width = HEIGHT;
		left.anchor_x = HEIGHT / 2;
		
		right.width = HEIGHT;
		right.anchor_x = HEIGHT / 2;
		
		notify["width"].connect((self, pspec) => {
			top.width = width;
			bottom.width = width;
			right.x = width;
		});
		
		notify["height"].connect((self, pspec) => {
			left.height = height;
			right.height = height;
			bottom.y = height;
		});
	}
	
	private void make(out Clutter.Rectangle rect)
	{
		rect = new Clutter.Rectangle();
		rect.color = INNER_COLOR;
		rect.border_color = OUTER_COLOR;
		rect.border_width = BORDER;
		add_actor(rect);
	}
}

