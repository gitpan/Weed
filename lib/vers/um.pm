package vers::um;
use strict;
use warnings;

our $VERSION = '0.0002';

BEGIN {
	use FooBah;

	printf "%s -m'::%s' ***\n", X3DUniversal::time, __PACKAGE__;
	printf "%s -m'::%s' ***\n", X3DUniversal::time, __PACKAGE__;
	printf "%s \@ARGV[%d]: @ARGV\n", time, scalar(@ARGV);
}

1;
__END__
