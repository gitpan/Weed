package X3DGtk2Bin;
use strict;
use warnings;

use base qw(X3DGtk2Container);

use X3DConstants;

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'whichChoice', new SFInt32(-1) ),
];

sub _whichChoice {
	my ($this, $value) = @_;
}

sub _children {
	my ( $this, $value ) = @_;

	$this->getWidget->remove($_) foreach $this->getWidget->get_children;
	$this->getWidget->add( $value->[ $this->whichChoice ]->getValue->getWidget )
	  if $this->whichChoice < $value->length
	  and $this->whichChoice != -1;
}

1;
__END__
