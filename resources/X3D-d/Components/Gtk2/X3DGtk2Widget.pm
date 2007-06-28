package X3DGtk2Widget;
use strict;
use warnings;

use base qw(X3DGtk2Node);

use X3DConstants;

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'minWidth',    new SFInt32(-1) ),
	new X3DFieldDefinition( inputOutput, 'minHeight',   new SFInt32(-1) ),
	new X3DFieldDefinition( outputOnly,  'exitTime', new SFTime ),
];

sub setWidget {
	my ( $this, $widget ) = @_;
	$this->{widget} = $widget;
	$widget->signal_connect( "delete-event", \&on_delete_event, $this );
	return;
}

sub getWidget { $_[0]->{widget} }

sub initialize {
	my ( $this ) = @_;
	$this->getWidget->set_size_request( $this->minWidth, $this->minHeight );
	$this->getWidget->show_all;
}

sub _minWidth {
	my ($this) = @_;
	$this->getWidget->set_size_request( $this->width, $this->height );
}

sub _minHeight {
	my ($this) = @_;
	$this->getWidget->set_size_request( $this->width, $this->height );
}

sub on_delete_event {
	my ( $widget, $event, $this ) = @_;
	X3DError::Debug time;

	$this->getWidget->hide;

	$this->exitTime(time);
	$this->processEvents;

	return 1;
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
