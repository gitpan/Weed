#!/usr/bin/perl -w
#package values_01
use Test::More tests => 8;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

is (new X3DColor, "0 0 0");
is (new X3DColorRGBA, "0 0 0 0");
is (new X3DImage, "0 0 0");
is (new X3DRotation, "0 0 1 0");
is (new X3DVec2, "0 0");
is (new X3DVec3, "0 0 0");
is (new X3DVec4, "0 0 0 0");

1;
__END__

