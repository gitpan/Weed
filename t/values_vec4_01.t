#!/usr/bin/perl -w
#package values_vec4_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values::Vec4');
}

my ( $v, $v1, $v2 );

is( $v = new Weed::Values::Vec4(), "0 0 0 0", "$v new Weed::Values::Vec4()" );
ok !$v;
is( $v = new Weed::Values::Vec4( 1, 2, 3, 4 ), "1 2 3 4", "$v new Weed::Values::Vec4()" );
is( $v = new Weed::Values::Vec4( [ 1, 2, 3, 4 ] ), "1 2 3 4", "$v new Weed::Values::Vec4()" );
#is( $v = new Weed::Values::Vec4( 1, 2, 3 ), "1 2 3 0", "$v new Weed::Values::Vec4()" );

is $v->elementCount, 4;

$v = new Weed::Values::Vec4( 1, 0, 0, 0 );
is( $v->normalize, "1 0 0 0", "$v new Weed::Values::Vec4()" );
$v = new Weed::Values::Vec4( 0, 1, 0, 0 );
is( $v->normalize, "0 1 0 0", "$v new Weed::Values::Vec4()" );
$v = new Weed::Values::Vec4( 0, 0, 1, 0 );
is( $v->normalize, "0 0 1 0", "$v new Weed::Values::Vec4()" );
$v = new Weed::Values::Vec4( 0, 0, 0, 1 );
is( $v->normalize, "0 0 0 1", "$v new Weed::Values::Vec4()" );

is( $v1 = new Weed::Values::Vec4( 1, 2, 3, 4 ), "1 2 3 4", "$v new Weed::Values::Vec4()" );
is( $v2 = new Weed::Values::Vec4( 2, 3, 4, 5 ), "2 3 4 5", "$v new Weed::Values::Vec4()" );
is( $v = $v1 + $v2, "3 5 7 9",     "$v new Weed::Values::Vec4()" );
is( $v = $v1 - $v2, "-1 -1 -1 -1", "$v new Weed::Values::Vec4()" );
is( $v = $v1 * $v2, "2 6 12 20",   "$v new Weed::Values::Vec4()" );
ok( $v = $v1 / $v2, "$v new Weed::Values::Vec4()" );
is( $v = $v1 . $v2, "40", "$v new Weed::Values::Vec4()" );
is( $v = $v1 x $v2, "-4 -2 0 6", "$v new Weed::Values::Vec4()" );
like( $v->length, "/^7\.4/", "$v new Weed::Values::Vec4()" );

is $v->elementCount, 4;

$v->[0] = 2345;
is( $v, "2345 -2 0 6", "$v new Weed::Values::Vec4()" );

#is( $v & [ 1, -2, 1, 1 ], "2345 -2 0 6", "$v new Weed::Values::Vec4()" );

is( $v = new Weed::Values::Vec4( 1, 2, 3, 4 ), "1 2 3 4", "$v new Weed::Values::Vec4()" );
is( $v = $v & 2, "0 2 2 0", "$v &" );
is( $v = $v & [ 2, 2, 2, 2 ], "0 2 2 0", "$v &" );

is( $v = $v | 2, "2 2 2 2", "$v &" );
is( $v = $v | [ 2, 2, 2, 2 ], "2 2 2 2", "$v &" );

is( $v = $v ^ 2, "0 0 0 0", "$v ^" );
is( $v = $v ^ [ 2, 2, 2, 2 ], "2 2 2 2", "$v ^" );
is( $v = ~$v, "4294967293 4294967293 4294967293 4294967293", "$v ^" );

is( $v = new Weed::Values::Vec4( 1, 2, 3, 4 ), "1 2 3 4",   "$v new Weed::Values::Vec4()" );
is( $v = $v << 2,                              "4 8 12 16", "$v ^" );
is( $v = $v >> 2,                              "1 2 3 4",   "$v ^" );
is( $v = $v << [ 2, 2, 2, 2 ], "4 8 12 16", "$v ^" );
is( $v = $v >> [ 2, 2, 2, 2 ], "1 2 3 4",   "$v ^" );

$v->setValue( [ 1, 2, 3, 4 ] );
is $v**2, "1 4 9 16";
is 2**$v, "2 4 8 16";
ok $v;
is !$v, '';

is $v->elementCount, 4;

is sqrt $v, $v**0.5;
is tan $v, sin($v) / cos($v);
is sin($v) / cos($v), tan $v;

is Math::E**$v, exp $v;
is exp $v, Math::E**$v;
is Math::log $v, log $v;
is log $v, Math::log $v;

is Math::sum(@$v), sum $v;

__END__



