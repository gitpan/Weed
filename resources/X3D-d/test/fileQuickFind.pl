#!/usr/bin/perl
use lib "$ENV{HOME}/perl";

use X3D;
printf "%s\n", Browser;
printf "%s\n", Browser->createX3DFromString(<DATA>);
Gtk2->main;

1;
__DATA__

COMPONENT Gtk2 1

META "name" "FileQuickFind"
META "version" "0.01"

DEF Gtk2Main Gtk2Main {},
DEF FileQuickFindWindow Gtk2Window {
  title "FileQuickFind"
  child Gtk2FileQuickFind {
	 dropPocket Gtk2DropPocket {
	   file DEF File File {
			url ""
		}
	 }
	 pathBar Gtk2PathBar {
	   file USE File
	 }
	 pathnameField	Gtk2PathnameField {
	   file USE File
    }
	 recycleButton Gtk2RecycleButton {
	   file USE File
	 }
  }
}

ROUTE FileQuickFindWindow.exitTime TO Gtk2Main.stopTime
