package Weed::Seed;
use strict;
use warnings;

use Weed::Universal;
use base 'X3DUniversal';
use Weed::Universal 'X3DObject { }';

use Weed::Generator::Symbols;

use overload
  '==' => sub { $_[1] == $_[0]->getId },
  '!=' => sub { $_[1] != $_[0]->getId },
  'eq' => sub { $_[1] eq "$_[0]" },
  'ne' => sub { $_[1] ne "$_[0]" },
  ;

sub new {
	my ( $self, $type ) = @_;
	my $this = $self->NEW({});

	$this->{id}      = $this->ID;
	$this->{type}    = $type || $this->PACKAGE;
	$this->{comment} = '';

	return $this;
}

sub getId : Overload(0+) { $_[0]->{id} }

sub getType { $_[0]->{type} }

sub getComment { $_[0]->{comment} }

sub getHierarchy { grep /^X3D/o, $_[0]->PATH }

sub toString : Overload("") { sprintf $seed_, $_[0]->getType }

sub dispose {
	my $this = shift;
	#X3DError::Debug ref $this, $this->getType;
	$this->CALL("shutdown");
	%$this = ();
}

#debug

sub shutdown {
	printf "%s->%s %s\n", $_[0]->PACKAGE, $_[0]->SUB, &toString($_[0]);
}

1;
__END__
