#!/usr/bin/perl -w
#package 01_values
use Test::More tests => 8;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

is (new Weed::Values::Color, "0 0 0");
is (new Weed::Values::ColorRGBA, "0 0 0 0");
is (new Weed::Values::Image, "0 0 0");
is (new Weed::Values::Rotation, "0 0 1 0");
is (new Weed::Values::Vec2, "0 0");
is (new Weed::Values::Vec3, "0 0 0");
is (new Weed::Values::Vec4, "0 0 0 0");

1;
__END__
