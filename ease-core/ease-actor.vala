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
 * The basic Ease actor, subclassed for different types of
 * {@link Element}.
 *
 * The Actor class should never be instantiated - instead,
 * subclasses such as {@link TextActor} and {@link ImageActor}
 * are placed on a SlideActor to form Ease presentations.
 */
public abstract class Ease.Actor : Clutter.Group
{
	// the contents of the actor
	protected Clutter.Actor contents;

	/**
	 * The {@link Element} this Actor represents
	 */
	public weak Element element;

	/**
	 * Where this actor is (editor, player, sidebar).
	 */
	public ActorContext context;
	
	/**
	 * If the Actor is a slide background.
	 */
	public bool is_background;
	
	/**
	 * The rectangle surrounding the actor in the editor.
	 */
	private Clutter.Rectangle editor_rect;
	
	/**
	 * The color of the surrounding rectangle in the editor.
	 */
	private const Clutter.Color RECT_COLOR = {0, 0, 0, 0};
	
	/**
	 * The border color of the surrounding rectangle in the editor.
	 */
	private const Clutter.Color RECT_BORDER = {100, 100, 100, 255};
	
	/**
	 * The widget of the surrounding rectangle in the editor.
	 */
	private const uint RECT_WIDTH = 1;

	/**
	 * Instantiate a new Actor
	 * 
	 * Instantiates the Actor base class. In general, this should only be
	 * called by subclasses.
	 *
	 * @param e The {@link Element} this Actor represents.
	 * @param c The context of this Actor - sidebar, presentation, editor.
	 */
	public Actor(Element e, ActorContext c)
	{
		element = e;
		context = c;
		is_background = false;
		
		// in the editor, draw a gray rectangle around the actor
		if (c == ActorContext.EDITOR)
		{
			editor_rect = new Clutter.Rectangle.with_color(RECT_COLOR);
			editor_rect.border_color = RECT_BORDER;
			editor_rect.border_width = RECT_WIDTH;
			editor_rect.width = e.width;
			editor_rect.height = e.height;
			add_actor(editor_rect);
		}
		
		// update the actor's position when changed in the element
		e.notify["x"].connect((o, p) => x = element.x);
		e.notify["y"].connect((o, p) => y = element.y);
		e.notify["width"].connect((o, p) => {
			width = element.width;
			contents.width = element.width;
			if (editor_rect != null) editor_rect.width = width;
		});
		e.notify["height"].connect((o, p) => {
			height = element.height;
			contents.height = element.height;
			if (editor_rect != null) editor_rect.height = height;
		});
	}
	
	/**
	 * Automatically resizes an actor to fit within this Actor's bounds.
	 *
	 * @param actor The actor to automatically scale.
	 */
	public void autosize(Clutter.Actor actor)
	{
		contents.notify["width"].connect(() => {
			actor.width = width;
		});
		
		contents.notify["height"].connect(() => {
			actor.height = height;
		});
	}
	
	/**
	 * Rereads the Actor's {@link Element} to position it properly.
	 *
	 * Used after reverting an action.
	 */
	public void reposition()
	{
		x = element.x;
		y = element.y;
		width = element.width;
		height = element.height;
		contents.width = width;
		contents.height = height;
		
		if (editor_rect != null)
		{
			editor_rect.width = width;
			editor_rect.height = height;
		}
	}
	
	/**
	 * Move this Actor and update its {@link Element}
	 * 
	 * Used in the editor and tied to Clutter MotionEvents.
	 *
	 * @param x_change The amount of X motion.
	 * @param y_change The amount of Y motion.
	 */
	public void translate(float x_change, float y_change)
	{
		x += x_change;
		y += y_change;
		
		element.x = x;
		element.y = y;
	}
	
	/**
	 * Resize this Actor and update its {@link Element}
	 * 
	 * Used in the editor and tied to Clutter MotionEvents on handles.
	 *
	 * @param w_change The amount of width change.
	 * @param h_change The amount of height change.
	 * @param proportional If the resize should be proportional only
	 */
	public void resize(float w_change, float h_change, bool proportional)
	{
		if (proportional)
		{
			if (w_change / h_change > width / height)
			{
				w_change = h_change * (width / height);
			}
			else if (w_change / h_change < width / height)
			{
				h_change = w_change * (height / width);
			}
		}
	
		if (width + w_change > 1)
		{
			width += w_change;
			contents.width += w_change;
		}
		if (height + h_change > 1)
		{
			height += h_change;
			contents.height += h_change;
		}
		
		element.width = width;
		element.height = height;
	}
	
	/**
	 * Called when the actor should be edited. Subclasses should override this.
	 *
	 * @param sender The widget this Actor is on.
	 */
	public virtual void edit(Gtk.Widget sender) {}
	
	/**
	 * Called when the actor end editing. Subclasses with editing that is not
	 * instant (popping up a dialog box) should override this.
	 *
	 * @param sender The widget this Actor is on.
	 */
	public virtual void end_edit(Gtk.Widget sender) {}
}

