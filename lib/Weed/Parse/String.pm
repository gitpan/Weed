package Weed::Parse::String;
use Weed::Perl;

use Weed::RegularExpressions '$_string';

use Exporter 'import';

our @EXPORT_OK = qw.string.;

sub string {
	my ($string) = @_;
	return $1 if $$string =~ m.$_string.gc;
	return;
}

1;
__END__
