package Weed::FieldDefinition;
use strict;
use warnings;

our $VERSION = '0.0013';

use Weed 'X3DFieldDefinition { }';

sub new {
	my ( $self, $type, $in, $out, @args ) = @_;
	my $this = $self->SUPER::new($type);

	$this->setInOut( $in, $out );
	@$this{ "name", "value", "range" } = @args;

	return $this;
}

sub isIn  { $_[0]->{in} }
sub isOut { $_[0]->{out} }

sub setInOut {
	my ( $this, $in, $out ) = @_;
	$this->{in}  = $in  ? X3DConstants->TRUE : X3DConstants->FALSE;
	$this->{out} = $out ? X3DConstants->TRUE : X3DConstants->FALSE;
}

sub getAccessType { ($_[0]->{out} << 1) | $_[0]->{in} }

sub getName { $_[0]->{name} }

sub getValue { $_[0]->{value} }

sub getRange { $_[0]->{range} }

sub createField {
	my ( $this, $node ) = @_;
	my $field = $this->getType->new( $this->{value} );
	$field->setDefinition($this);
	return $field;
}

use Weed::Generator::Symbols;

sub toString : Overload("") { sprintf $string_, $_[0]->getType }

sub shutdown {
	printf "%s->%s %s\n", $_[0]->PACKAGE, $_[0]->SUB, &toString($_[0]);
}

1;
__END__

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

