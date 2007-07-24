package Weed::Parse::Double;
use Weed::Perl;

our $VERSION = '0.009';

use Weed::RegularExpressions qw.$_double $_nan $_inf.;

use Exporter 'import';

our @EXPORT_OK = qw.parseDouble double.;

sub parseDouble { &double( \$_[0] ) }

sub double {
	return 0 + $1 if ${ $_[0] } =~ m.$_double.gc;
	#return 0  if $$string =~ m.$_nan.gc;
	#return ...  if $$string =~ m.$_inf.gc;
	return;
}

1;
__END__
