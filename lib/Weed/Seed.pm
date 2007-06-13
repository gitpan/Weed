package Weed::Seed;
use Weed::Perl;

our $VERSION = '0.0034';

use Weed::Universal 'X3DObject { }';

sub create {
	my $this = shift;

	$this->{comment} = '';

	#printf "%s->%s %s\n", $this->getType, $this->Weed::Package::sub, $this;
}

sub getComment { $_[0]->{comment} }

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
	%$this = ();
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
