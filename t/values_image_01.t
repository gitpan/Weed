#!/usr/bin/perl -w
#package values_image_01
use Test::More tests => 4;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

my ( $v, $v1, $v2 );

is( $v = new X3DImage(), "0 0 0", "$v new X3DImage()" );
is( $v = new X3DImage( 2, 2, 4, [ 0xABCDEFAB, 0xABCDEFAB, 0xABCDEABF, 0xABCDABEF ] ), "2 2 4
0xabcdefab 0xabcdefab
0xabcdeabf 0xabcdabef", "new X3DImage()" );
printf "%s\n", $v;
is( $v->getClone, "2 2 4
0xabcdefab 0xabcdefab
0xabcdeabf 0xabcdabef", "new X3DImage()" );

__END__

