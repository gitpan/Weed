package Weed::Parse::Int32;
use Weed::Perl;

our $VERSION = '0.001';

use Weed::RegularExpressions qw.$_int32.;

use Exporter 'import';

our @EXPORT_OK = qw.parseInt int32.;

#parseInt(s, [radix])
sub parseInt { &int32( \$_[0] ) }

sub int32 {
	return defined $2 ? hex($1) : 0 + $1 if ${ $_[0] } =~ m.$_int32.gc;
	return;
}

1;
__END__

