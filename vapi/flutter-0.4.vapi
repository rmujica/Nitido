/* flutter-0.4.vapi generated by valac 0.10.0, do not modify. */

[CCode (cprefix = "Flutter", lower_case_cprefix = "flutter_")]
namespace Flutter {
	[CCode (cheader_filename = "flutter.h")]
	public class Box : Clutter.Box, Flutter.Container {
		public Box ();
	}
	[CCode (cheader_filename = "flutter.h")]
	public class Group : Clutter.Group, Flutter.Container {
		public Group ();
	}
	[CCode (cheader_filename = "flutter.h")]
	public class Stage : Clutter.Stage, Flutter.Container {
		public Stage ();
	}
	[CCode (cheader_filename = "flutter.h")]
	public interface Container : Clutter.Container {
		[CCode (ref_function = "flutter_container_iterator_ref", unref_function = "flutter_container_iterator_unref", cheader_filename = "flutter.h")]
		public class Iterator {
			public Iterator (Flutter.Container self);
			public Clutter.Actor @get ();
			public bool next ();
		}
		public Flutter.Container.Iterator iterator ();
	}
}
