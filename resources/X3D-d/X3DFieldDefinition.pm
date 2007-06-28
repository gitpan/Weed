package X3DFieldDefinition;
use strict;
use warnings;

use base qw(X3DObject);

use X3DFieldTypes;

sub new {
	my $self = shift;
	my $this = $self->SUPER::new;
	@$this{ "accessType", "type", "name", "value", "comment" } = @_;
	return $this;
}

sub getField {
	my ( $this, $node ) = @_;
	return $this->{type}->new( $node, @$this{ "accessType", "type", "name", "value" } );
}

sub getAccessType { $_[0]->{accessType} }
sub getValue      { $_[0]->{value} }

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= $X3DGenerator::AccessTypes->[ $this->getAccessType ];
	$string .= $X3DGenerator::SPACE;
	$string .= $this->getType;
	$string .= $X3DGenerator::SPACE;
	$string .= $this->SUPER::toString;

	return $string;
}

1;
__END__
