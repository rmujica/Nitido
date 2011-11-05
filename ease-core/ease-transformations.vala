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
 * Contains transformation functions, transforming one type into a similar type.
 */
namespace Ease.Transformations
{
	private const double TO_GDK_COLOR_FACTOR = 65535.0 / 255;
	private const double TO_CLUTTER_COLOR_FACTOR = 255.0 / 65535;
	private const uint8 CLUTTER_COLOR_ALPHA = 255;
	
	/**
	 * Transforms a Clutter.Color into a Gdk.Color.
	 *
	 * @param color The Clutter.Color to transform.
	 */
	public Gdk.Color clutter_color_to_gdk_color(Clutter.Color color)
	{
		return { 0,
		          (uint16)(color.red * TO_GDK_COLOR_FACTOR),
		          (uint16)(color.green * TO_GDK_COLOR_FACTOR),
		          (uint16)(color.blue * TO_GDK_COLOR_FACTOR) };
	}
	
	/**
	 * Transforms a Gdk.Color into a Clutter.Color.
	 *
	 * @param color The Gdk.Color to transform.
	 */
	public Clutter.Color gdk_color_to_clutter_color(Gdk.Color color)
	{
		return { (uint8)(color.red * TO_CLUTTER_COLOR_FACTOR),
		          (uint8)(color.green * TO_CLUTTER_COLOR_FACTOR),
		          (uint8)(color.blue * TO_CLUTTER_COLOR_FACTOR),
		          CLUTTER_COLOR_ALPHA };
	}
}
