package Weed::Parse::Double;
use Weed::Perl;

use Weed::RegularExpressions '$_double';

use Exporter 'import';

our @EXPORT_OK = qw.double.;

sub double {
	my ($string) = @_;
	return $1 if $$string =~ m.$_double.gc;
	return;
}


1;
__END__
