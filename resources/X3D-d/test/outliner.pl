#!/usr/bin/perl
use lib "$ENV{HOME}/perl";

use X3D;
use Inline::Files;

$X3DGenerator::AllFields = 0;

printf "%s\n", Browser;
printf "%s\n", Browser->createX3DFromString(<OUTLINER>);
printf "%s\n", Browser->createX3DFromString(<WORLD>);

Gtk2->main;

1;
__OUTLINER__

COMPONENT Gtk2 1

META "name" "Outliner"
META "version" "0.01"

DEF Gtk2Main Gtk2Main {},
DEF OutlineEditorWindow Gtk2Window {
  title "OutlineEditor"
  x 400
  y 300
  width 300
  height 400
  whichChoice 0
  children Gtk2OutlineEditor {
    title "Outline"
	 children [
		DEF Double MetadataDouble {}
		MetadataFloat {}
		DEF Set MetadataSet {
			value [
				MetadataDouble {}
				MetadataFloat {}
				MetadataSet {}
				MetadataString {}
			]
		}
		MetadataString {}
	 ]
  }
}

ROUTE OutlineEditorWindow.exitTime TO Gtk2Main.stopTime

__WORLD__

PROFILE Core

DEF Double MetadataDouble {}
MetadataFloat {}
DEF Set MetadataSet {
	value [
		USE Double
		MetadataFloat {}
		MetadataString {}
	]
}
MetadataString {}
