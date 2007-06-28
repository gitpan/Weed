package X3DGtk2Container;
use strict;
use warnings;

use base qw(X3DGtk2Widget);

use X3DConstants;

our $FieldDefinitions = [
  new X3DFieldDefinition( inputOutput, 'borderWidth', new SFInt32(0) ),
  new X3DFieldDefinition( inputOutput, 'children', new MFNode ),
];

sub initialize {
	my ($this) = @_;
	$this->_borderWidth( $this->borderWidth );
	$this->_children( $this->children );
}

sub _borderWidth {
	my ( $this, $value ) = @_;
	$this->getWidget->set_border_width( $value );
}

sub _children {
	my ( $this, $value ) = @_;
	$this->getWidget->remove($_) foreach $this->getWidget->get_children;
	$this->getWidget->add( map { $_->getValue->getWidget } @$value ) if $value;
}

1;
__END__
