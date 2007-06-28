#!/usr/bin/perl
use lib "$ENV{HOME}/perl";

use X3D;
printf "%s\n", Browser;
printf "%s\n", Browser->createX3DFromString(<DATA>);
Gtk2->main;

1;
__DATA__

COMPONENT Gtk2 1

META "name" "Outliner"
META "version" "0.01"

DEF Gtk2Main Gtk2Main {},
DEF OutlineEditorWindow Gtk2Window {
  title "OutlineEditor"
  width 300
  height 400
  child DEF OutlineEditorWidget Gtk2OutlineEditor {
    title "Outline"
	 children [
		MetadataDouble {},
		MetadataFloat {},
		MetadataInteger {},
		MetadataSet {},
		MetadataString {}
	 ]
  }
}

ROUTE OutlineEditorWindow.exitTime TO Gtk2Main.stopTime
ROUTE OutlineEditorWidget.exitTime TO Gtk2Main.stopTime
