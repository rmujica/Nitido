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
 * Interface element for manipulating the size of {@link Actor}s.
 */
internal class Ease.Handle : Clutter.CairoTexture
{	
	/**
	 * The position of this handle relative to the selection rectangle.
	 */
	internal HandlePosition position;
	
	/**
	 * If the handle is being dragged and should alter its appearance.
	 */
	private bool flipped = false;
	
	/**
	 * The size of the handle.
	 */
	private const int SIZE = 35;
	
	/**
	 * Creates a Handle. Does automatically set the Handle's position - call
	 * reposition() to do this.
	 *
	 * @param pos The position of this handle relative to the selection
	 * rectangle.
	 */
	internal Handle(HandlePosition pos)
	{
		// set the handle's size
		width = height = surface_width = surface_height = SIZE;
		
		// draw the default handle appearance
		redraw();
		
		// set the handle's position
		position = pos;
		
		// set the handle's anchor
		set_anchor_point(SIZE / 2, SIZE / 2);
		
		// react to clicks
		reactive = true;
	}
	
	/**
	 * Performs a drag of the handle, updating the selected {@link Actor}'s size
	 * and position.
	 *
	 * @param change_x The x drag distance.
	 * @param change_y The y drag distance.
	 * @param target The Element to update.
	 * @param proportional If any scaling should be proportional, if possible.
	 * @param from_center If the resize should operate from the center of the
	 * target element.
	 */
	internal void drag(float change_x, float change_y, Element target,
	                   bool proportional, bool from_center)
	{
		float translate_x = 0, translate_y = 0, resize_x = 0, resize_y = 0;
		
		switch (position)
		{
			case HandlePosition.TOP_LEFT:
				if (proportional)
				{
					if (change_x / change_y > target.width / target.height)
					{
						translate_x = change_y * (target.width / target.height);
						translate_y = change_y;
					}
					else
					{
						translate_y = change_x * (target.height / target.width);
						translate_x = change_x;
					}
					resize_x = -translate_x;
					resize_y = -translate_y;
					break;
				}
				
				translate_x = change_x;
				translate_y = change_y;
				resize_x = -change_x;
				resize_y = -change_y;
				break;
				
			case HandlePosition.TOP_RIGHT:
				if (proportional)
				{
					if (change_x / change_y > target.width / target.height)
					{
						resize_x = change_y * (target.width / target.height);
						resize_y = change_y;
					}
					else
					{
						resize_y = change_x * (target.height / target.width);
						resize_x = change_x;
					}
					translate_y = -resize_y;
					break;
				}
			
				translate_y = change_y;
				resize_x = change_x;
				resize_y = -change_y;
				break;
				
			case HandlePosition.TOP:
				if (proportional)
				{
					resize_x = -change_y * (target.width / target.height);
					translate_x = -resize_x / 2;
				}
			
				translate_y = change_y;
				resize_y = -change_y;
				break;
				
			case HandlePosition.BOTTOM:
				if (proportional)
				{
					resize_x = change_y * (target.width / target.height);
					translate_x = -resize_x / 2;
				}
			
				resize_y = change_y;
				break;
				
			case HandlePosition.LEFT:
				if (proportional)
				{
					resize_y = -change_x * (target.width / target.height);
					translate_y = -resize_y / 2;
				}
			
				translate_x = change_x;
				resize_x = -change_x;
				break;
				
			case HandlePosition.RIGHT:
				if (proportional)
				{
					resize_y = change_x * (target.width / target.height);
					translate_y = -resize_y / 2;
				}
				
				resize_x = change_x;
				break;
				
			case HandlePosition.BOTTOM_LEFT:
				if (proportional)
				{
					if (change_x / change_y > target.width / target.height)
					{
						resize_x = -change_y * (target.width / target.height);
						resize_y = -change_y;
					}
					else
					{
						resize_y = -change_x * (target.height / target.width);
						resize_x = -change_x;
					}
					
					translate_x = -resize_x;
					break;
				}
			
				translate_x = change_x;
				resize_x = -change_x;
				resize_y = change_y;
				break;
				
			case HandlePosition.BOTTOM_RIGHT:
				if (proportional)
				{
					if (change_x / change_y > target.width / target.height)
					{
						resize_x = change_y * (target.width / target.height);
						resize_y = change_y;
					}
					else
					{
						resize_y = change_x * (target.height / target.width);
						resize_x = change_x;
					}
					break;
				}
			
				resize_x = change_x;
				resize_y = change_y;
				break;
		}
		
		if (target.width + resize_x - translate_x <= target.get_minimum_width())
		{
			translate_x = 0;
			resize_x = 0;
			if (proportional)
			{
				translate_y = 0;
				resize_y = 0;
			}
		}
		if (target.height + resize_y - translate_y <=
		    target.get_minimum_height())
		{
			translate_y = 0;
			resize_y = 0;
			if (proportional)
			{
				translate_x = 0;
				resize_x = 0;
			}
		}
		
		target.x += translate_x;
		target.y += translate_y;
		target.width += resize_x;
		target.height += resize_y;
	}
	
	/**
	 * Places this Handle in its proper location, relative to the selection
	 * rectangle.
	 *
	 * @param selection The selection rectangle to position the Handle around.
	 */
	internal void reposition(Clutter.Actor selection)
	{
		switch (position)
		{
			case HandlePosition.TOP_LEFT:
				x = selection.x;
				y = selection.y;
				break;
				
			case HandlePosition.TOP_RIGHT:
				x = selection.x + selection.width;
				y = selection.y;
				break;
				
			case HandlePosition.TOP:
				x = selection.x + selection.width / 2;
				y = selection.y;
				break;
				
			case HandlePosition.LEFT:
				x = selection.x;
				y = selection.y + selection.height / 2;
				break;
				
			case HandlePosition.RIGHT:
				x = selection.x + selection.width;
				y = selection.y + selection.height / 2;
				break;
				
			case HandlePosition.BOTTOM_LEFT:
				x = selection.x;
				y = selection.y + selection.height;
				break;
				
			case HandlePosition.BOTTOM_RIGHT:
				x = selection.x + selection.width;
				y = selection.y + selection.height;
				break;
				
			case HandlePosition.BOTTOM:
				x = selection.x + selection.width / 2;
				y = selection.y + selection.height;
				break;
		}
	}
	
	/**
	 * Flips the colors of the handle.
	 */
	internal void flip(bool f)
	{
		flipped = f;
		redraw();
	}
	
	private void redraw()
	{
		// get a Cairo context
		var cr = create();
		
		// draw a circle
		cr.arc(SIZE / 2, SIZE / 2, SIZE / 4, 0, 2 * 3.1415);
		
		// fill the circle
		if (!flipped) cr.set_source_rgba(1, 1, 1, 1);
		else cr.set_source_rgba(0, 0, 0, 1);
		cr.fill_preserve();
		
		// stroke the circle
		if (!flipped) cr.set_source_rgba(0, 0, 0, 1);
		else cr.set_source_rgba(1, 1, 1, 1);
		cr.stroke();
	}
}

