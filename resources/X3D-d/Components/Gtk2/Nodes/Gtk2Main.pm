package Gtk2Main;
use strict;
use warnings;

use rlib "../";

use base qw(X3DGtk2Node);

use X3DConstants;

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'startTime', new SFTime ),
	new X3DFieldDefinition( inputOutput, 'stopTime',  new SFTime ),
];

sub _startTime {
	Gtk2->main;
}

sub _stopTime {
	Gtk2->main_quit;
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
