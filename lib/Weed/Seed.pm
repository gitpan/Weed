package Weed::Seed;
use strict;
use warnings;

use Weed::Universal 'X3DObject { }';

use Weed::Generator::Symbols;

use overload
  '==' => sub { $_[1] == $_[0]->getId },
  '!=' => sub { $_[1] != $_[0]->getId },
  'eq' => sub { $_[1] eq "$_[0]" },
  'ne' => sub { $_[1] ne "$_[0]" },
  ;

sub new {
	my $self = shift;
	my $this = $self->NEW({});

	$this->{id}      = $this->ID;
	$this->{type}    = $this->PACKAGE;
	$this->{comment} = '';

	$this->REVERSE_CALL("create", @_);

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

################################################################################
# debug ########################################################################
################################################################################

sub shutdown {
	printf "%s->%s %s\n", $_[0]->PACKAGE, $_[0]->SUB, &toString($_[0]);
}

1;
__END__

=head1 NAME

Weed::Seed

=head1 SUPERTYPES

-+- L<X3DUniversal|Weed::Universal>

=head1 SYNOPSIS

	use Weed::Seed;
	
	my $seed1 = new X3DObject;

=head1 FUNCTIONS

=head2 getId

=head2 getType

=head2 toString

This method is used to overload the "" operator

=head1 SEE ALSO

L<Weed::Seed>

L<Weed::Field>, L<Weed::ArrayField>

L<Math::Vectors>

=head1 AUTHOR

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

Das ist freie Software; du kannsts sie weiter verteilen und/oder verändern
nach den gleichen Bedingungen wie L<Perl|perl> selbst.

=cut
