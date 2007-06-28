package Gtk2Window;
use strict;
use warnings;

use rlib "../";

use base qw(X3DGtk2Bin);

use X3DConstants;
use Math;

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'title',  new SFString ),
	new X3DFieldDefinition( inputOutput, 'x',      new SFInt32(-1) ),
	new X3DFieldDefinition( inputOutput, 'y',      new SFInt32(-1) ),
	new X3DFieldDefinition( inputOutput, 'width',  new SFInt32(0) ),
	new X3DFieldDefinition( inputOutput, 'height', new SFInt32(0) ),
];

sub create {
	my ($this) = @_;
	my $window = new Gtk2::Window;
	$window->signal_connect_after( "realize", \&on_realize, $this );
	$this->setWidget($window);
}

sub on_realize {
	my ( $widget, $this ) = @_;
	$this->getWidget->move( $this->x, $this->y ) unless $this->x == -1 and $this->y == -1;
	$this->getWidget->resize( Math::max(1, $this->width), Math::max(1, $this->height) );
	return;
}

sub initialize {
	my ($this) = @_;
	$this->getWidget->set_title( $this->title );
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
