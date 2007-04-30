package Weed::Field;
use strict;
use warnings;

use Weed 'X3DField { }';

use constant DefaultDefinition => new X3DFieldDefinition( "", "in", "out", undef, undef, undef );

sub create {
	my $this = shift;
	$this->setDefinition(DefaultDefinition);
	$this->setValue(@_);
}

sub getDefinition { $_[0]->{definition} }

sub setDefinition {
	$_[0]->{definition} = $_[1];
	$_[0]->setAccessType( $_[1]->getAccessType );
}

sub getInitialValue { $_[0]->getDefinition->getValue }

sub getAccessType { $_[0]->{accessType} }

sub setAccessType {
	$_[0]->{accessType} = $_[1];
	$_[0]->{isReadable} = $_[1] != X3DConstants->inputOnly;
	$_[0]->{isWritable} = $_[1] & X3DConstants->inputOnly;
}

sub isReadable { $_[0]->{isReadable} }
sub isWritable { $_[0]->{isWritable} }

#sub isReadable { $_[0]->getAccessType != X3DConstants->inputOnly }
#sub isWritable { $_[0]->getDefinition->getOut }

sub getName { $_[0]->getDefinition->getName }

sub getValue { $_[0]->{value} }

sub setValue {
	my ( $this, $value ) = @_;
	$this->{value} = $value;
}

1;
__END__
