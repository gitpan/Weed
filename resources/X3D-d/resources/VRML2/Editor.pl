#!/usr/freeware/bin/perl -w
use strict;

BEGIN {
	use lib "/usr/people/holger/perl";
	use Carp;

	use Gnome;
	use VRML2::Editor;
}

Gnome->init(__PACKAGE__);
my $editor = new VRML2::Editor;
$editor->fileImport("/usr/people/holger/vrml/test/test.wrl");
#$editor->fileImport("/usr/people/holger/vrml/demos/solaris/solarisV1/collision.wrl");
Gtk->main;

1;


__END__
