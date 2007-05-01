package Weed::Seed;
use strict;
use warnings;

our $VERSION = '0.0022';

use Weed::RegularExpressions '$_X3D';
use Weed::Universal 'X3DObject { }';

use overload
  '==' => sub { $_[1] == $_[0]->getId },
  '!=' => sub { $_[1] != $_[0]->getId },
  'eq' => sub { $_[1] eq "$_[0]" },
  'ne' => sub { $_[1] ne "$_[0]" },
  '0+' => \&getId,
  '""' => sub { $_[0]->toString },
  ;

sub new {
	my $self = shift;
	my $this = $self->NEW( {} );

	$this->{id}      = $this->ID;
	$this->{type}    = $this->PACKAGE;
	$this->{comment} = '';

	$this->REVERSE_CALL( "create", @_ );

	return $this;
}

sub getId { $_[0]->{id} }

sub getType { $_[0]->{type} }

sub getComment { $_[0]->{comment} }

sub getHierarchy { grep /$_X3D/, $_[0]->PATH }

sub toString {
	my ($this) = @_;

	my $string = '';
	$string .= $this->getType;
	$string .= X3DGenerator->nice_space;
	$string .= X3DGenerator->open_brace;
	$string .= X3DGenerator->nice_space;
	$string .= X3DGenerator->close_brace;

	return $string;
}

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
	#printf "%s->%s %s\n", $_[0]->PACKAGE, $_[0]->SUB, &toString( $_[0] );
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
