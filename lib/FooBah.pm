package FooBah;

use Weed 'FooBah : X3DUniversum { }';

our $VERSION = '0.0034';

sub initialize {
	my $this = shift;
	#printf "%s->%s %s\n", $this->getType, $this->Weed::Package::sub, $this;
	#printf "*** %s -m'%s'\n", X3DUniversal::time, __PACKAGE__;
	#printf "*** %s -m'%s' '%s'\n", X3DUniversal::time, __PACKAGE__, join "' '", @ARGV;
	printf "%s->%s %s\n", $this->getType, $this->Weed::Package::sub, $this;
	
	#sleep 1;
}

sub shutdown {
	my $this = shift;
	printf "%s->%s %s\n", $this->getType, $this->Weed::Package::sub, $this;
}

1;
__END__

=head1 NAME

FooBah

=head1 USES

L<Weed>

=head1 EXAMPLES

	system qq=echo 'FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah'=;

=head1 SEE ALSO

L<Weed>

=head1 AUTHOR

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

Das ist freie Software; du kannsts sie weiter verteilen und/oder verändern
nach den gleichen Bedingungen wie L<Perl|perl> selbst.

=cut
