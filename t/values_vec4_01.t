#!/usr/bin/perl -w
#package values_vec4_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

my ( $v, $v1, $v2 );

is( $v = new X3DVec4(), "0 0 0 0", "$v new X3DVec4()" );
ok !$v;
is( $v = new X3DVec4( [1, 2, 3, 4] ), "1 2 3 4", "$v new X3DVec4()" );
is( $v = new X3DVec4( [ 1, 2, 3, 4 ] ), "1 2 3 4", "$v new X3DVec4()" );
#is( $v = new X3DVec4( 1, 2, 3 ), "1 2 3 0", "$v new X3DVec4()" );

is $v->elementCount, 4;

$v = new X3DVec4( [1, 0, 0, 0 ]);
is( $v->normalize, "1 0 0 0", "$v new X3DVec4()" );
$v = new X3DVec4( [0, 1, 0, 0] );
is( $v->normalize, "0 1 0 0", "$v new X3DVec4()" );
$v = new X3DVec4( [0, 0, 1, 0] );
is( $v->normalize, "0 0 1 0", "$v new X3DVec4()" );
$v = new X3DVec4( [0, 0, 0, 1] );
is( $v->normalize, "0 0 0 1", "$v new X3DVec4()" );

is( $v1 = new X3DVec4( [1, 2, 3, 4] ), "1 2 3 4", "$v new X3DVec4()" );
is( $v2 = new X3DVec4( [2, 3, 4, 5] ), "2 3 4 5", "$v new X3DVec4()" );
is( $v = $v1 + $v2, "3 5 7 9",     "$v new X3DVec4()" );
is( $v = $v1 - $v2, "-1 -1 -1 -1", "$v new X3DVec4()" );
is( $v = $v1 * $v2, "2 6 12 20",   "$v new X3DVec4()" );
ok( $v = $v1 / $v2, "$v new X3DVec4()" );
is( $v = $v1 . $v2, "40", "$v new X3DVec4()" );
is( $v = $v1 x $v2, "-4 -2 0 6", "$v new X3DVec4()" );
like( $v->length, "/^7\.4/", "$v new X3DVec4()" );

is $v->elementCount, 4;

$v->[0] = 2345;
is( $v, "2345 -2 0 6", "$v new X3DVec4()" );

#is( $v & [ 1, -2, 1, 1 ], "2345 -2 0 6", "$v new X3DVec4()" );

is( $v = new X3DVec4( [1, 2, 3, 4] ), "1 2 3 4", "$v new X3DVec4()" );
is( $v = $v & 2, "0 2 2 0", "$v &" );
is( $v = $v & [ 2, 2, 2, 2 ], "0 2 2 0", "$v &" );

is( $v = $v | 2, "2 2 2 2", "$v &" );
is( $v = $v | [ 2, 2, 2, 2 ], "2 2 2 2", "$v &" );

is( $v = $v ^ 2, "0 0 0 0", "$v ^" );
is( $v = $v ^ [ 2, 2, 2, 2 ], "2 2 2 2", "$v ^" );
is( $v = ~$v, "4294967293 4294967293 4294967293 4294967293", "$v ^" );

is( $v = new X3DVec4( [1, 2, 3, 4] ), "1 2 3 4",   "$v new X3DVec4()" );
is( $v = $v << 2,                              "4 8 12 16", "$v ^" );
is( $v = $v >> 2,                              "1 2 3 4",   "$v ^" );
is( $v = $v << [ 2, 2, 2, 2 ], "4 8 12 16", "$v ^" );
is( $v = $v >> [ 2, 2, 2, 2 ], "1 2 3 4",   "$v ^" );
is $v->divide(8)->round(2), '0.12 0.25 0.38 0.5';

$v->setValue( [ 1, 2, 3, 4 ] );
is $v**2, "1 4 9 16";
is 2**$v, "2 4 8 16";
ok $v;
is !$v, '';

is $v->elementCount, 4;

is sqrt $v, $v**0.5;
is tan $v, sin($v) / cos($v);
is sin($v) / cos($v), tan $v;

is X3DMath::E**$v, exp $v;
is exp $v, X3DMath::E**$v;
is X3DMath::log $v, log $v;
is log $v, X3DMath::log $v;

is X3DMath::sum(@$v), sum $v;

__END__



