/*  Flutter: Foreach-enabled Clutter containers for Vala
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
 * Clutter container mixin, iterable with foreach()
 */
public interface Flutter.Container : Clutter.Container
{
	public Iterator iterator()
	{
		return new Iterator(this);
	}

	public class Iterator
	{
		private unowned List<Clutter.Actor>* itr;
		
		public Iterator(Container self)
		{
			itr = self.get_children();
		}
		
		public bool next()
		{
			return itr != null;
		}
		
		public Clutter.Actor get()
		{
			var actor = (Clutter.Actor)(itr->data);
			itr = itr->next;
			return actor;
		}
	}
}

/**
 * ClutterGroup with {@link Container} mixin.
 */
public class Flutter.Group : Clutter.Group, Container
{
}

/**
 * ClutterStage with {@link Container} mixin.
 */
public class Flutter.Stage : Clutter.Stage, Container
{
}

/**
 * ClutterBox with {@link Container} mixin.
 */
public class Flutter.Box : Clutter.Box, Container
{
}


