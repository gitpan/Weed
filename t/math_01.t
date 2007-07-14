#!/usr/bin/perl -w
#package math_01
use Test::More tests => 899;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use Weed::Math  ();
use POSIX ();

my ( $v, $v1, $v2 );

is( $v = X3DMath::E,    2**( 1 / CORE::log(2) ), "X3DMath::E = $v" );
is( $v = X3DMath::LN10, CORE::log(10),           "X3DMath::LN10 = $v" );
is( $v = X3DMath::LN2,  CORE::log(2),            "X3DMath::LN2 = $v" );
is( $v = X3DMath::PI,    CORE::atan2( 0, -1 ),     "X3DMath::PI = $v" );
is( $v = X3DMath::PI1_4, CORE::atan2( 1, 1 ),      "X3DMath::PI1_4 = $v" );
is( $v = X3DMath::PI1_2, CORE::atan2( 1, 0 ),      "X3DMath::PI1_2 = $v" );
is( $v = X3DMath::PI3_4, CORE::atan2( 1, -1 ),     "X3DMath::PI1_4 = $v" );
is( $v = X3DMath::PI2,   CORE::atan2( 0, -1 ) * 2, "X3DMath::PI2 = $v" );
is( $v = X3DMath::SQRT1_2, CORE::sqrt(0.5), "X3DMath::SQRT1_2 = $v" );
is( $v = X3DMath::SQRT2,   CORE::sqrt(2),   "X3DMath::SQRT2 = $v" );

is( X3DMath::abs(-1),     1,                  "X3DMath::abs(-1)" );
is( X3DMath::acos(-1),    POSIX::acos(-1),    "X3DMath::acos(-1)" );
is( X3DMath::asin(-1),    POSIX::asin(-1),    "X3DMath::asin(-1)" );
is( X3DMath::atan(-1),    POSIX::atan(-1),    "X3DMath::atan(-1)" );
is( X3DMath::ceil(-1.2),  POSIX::ceil(-1.2),  "X3DMath::ceil(-1)" );
is( X3DMath::cos(-1),     CORE::cos(-1),      "X3DMath::cos(-1)" );
is( X3DMath::exp(2),      CORE::exp(2),       "X3DMath::exp(2)" );
is( X3DMath::floor(-2.3), POSIX::floor(-2.3), "X3DMath::floor(-1)" );
is( X3DMath::log(2),      CORE::log(2),       "X3DMath::log(-1)" );
is( X3DMath::log10(2),    POSIX::log10(2),    "X3DMath::log(-1)" );
is( X3DMath::min( 3, 2 ), 2, "X3DMath::min(3, 2)" );
is( X3DMath::max( 3, 2 ), 3, "X3DMath::max(3, 2)" );
is( X3DMath::clamp( -1, 3, 2 ), 2, "X3DMath::clamp(-1, 3, 2)" );
is( X3DMath::pow( 2, 4 ), 2**4, "X3DMath::pow(2, 4)" );
ok( X3DMath::random( 1, 2 ), "X3DMath::random()" );
is( X3DMath::round(-1), -1,             "X3DMath::round(-1)" );
is( X3DMath::sin(-1),   CORE::sin(-1),  "X3DMath::sin(-1)" );
is( X3DMath::sqrt(2),   CORE::sqrt(2),  "X3DMath::sqrt(-1)" );
is( X3DMath::sum(-1),   -1,             "X3DMath::sum(-1)" );
is( X3DMath::tan(-1),   POSIX::tan(-1), "X3DMath::tan(-1)" );

my ( $min, $max, $n ) = ( 10, 100, 0 );
for ( 0 .. 17_000 ) {
	$n = X3DMath::random( $min, $max );
	ok(0) if $n < $min || $n > $max;
}
ok($n);

is( X3DMath::round(0),    0 );
is( X3DMath::round(-0.4), 0 );
is( X3DMath::round(-0.5), -1 );
is( X3DMath::round(-0.6), -1 );
is( X3DMath::round(0.4),  0 );
is( X3DMath::round(0.5),  1 );
is( X3DMath::round(0.6),  1 );
is( X3DMath::round( 4,  -1 ), 0 );
is( X3DMath::round( 5,  -1 ), 10 );
is( X3DMath::round( 6,  -1 ), 10 );
is( X3DMath::round( 40, -2 ), 0 );
is( X3DMath::round( 50, -2 ), 100 );
is( X3DMath::round( 60, -2 ), 100 );

is( X3DMath::round( 12345, -2 ), 12300 );

is( X3DMath::round( 0,    0 ), 0 );
is( X3DMath::round( -0.4, 0 ), 0 );
is( X3DMath::round( -0.5, 0 ), -1 );
is( X3DMath::round( -0.6, 0 ), -1 );
is( X3DMath::round( 0.4,  0 ), 0 );
is( X3DMath::round( 0.5,  0 ), 1 );
is( X3DMath::round( 0.6,  0 ), 1 );

is( X3DMath::min( 3, 2 ), 2 );
is( X3DMath::min( 2, 3 ), 2 );
is( X3DMath::min( 4, 5, 3, 2 ), 2 );
is( X3DMath::min( 7, 7, 2, 2, 3, 4, 7, 3 ), 2 );

is( X3DMath::max( 3, 2 ), 3 );
is( X3DMath::max( 2, 3 ), 3 );
is( X3DMath::max( 4, 5, 3, 2 ), 5 );
is( X3DMath::max( 7, 7, 2, 2, 8, 4, 7, 3 ), 8 );

is( X3DMath::clamp( 4,  2, 8 ), 4 );
is( X3DMath::clamp( 1,  2, 8 ), 2 );
is( X3DMath::clamp( 10, 2, 8 ), 8 );

is( X3DMath::sum(), 0 );
is( X3DMath::sum(23), 23 );
is( X3DMath::sum( 3, 45 ), 48 );
is( X3DMath::sum( 10, 2, 8 ), 20 );
is( X3DMath::sum( 0 .. 100 ), 5050 );

is( X3DMath::pro(), 0 );
is( X3DMath::pro(23), 23 );
is( X3DMath::pro( 2, 3 ), 6 );
is( X3DMath::pro( 2, 3, 4 ), 24 );

is( X3DMath::even(-1), 0 );
is( X3DMath::even(1),  0 );
is( X3DMath::even(0),  1 );
is( X3DMath::even(2),  1 );
is( X3DMath::even(-2), 1 );

is( X3DMath::odd(-1), 1 );
is( X3DMath::odd(1),  1 );
is( X3DMath::odd(0),  0 );
is( X3DMath::odd(2),  0 );
is( X3DMath::odd(-2), 0 );

is( X3DMath::even($_), 1 ) foreach map { $_ * 2 } ( -100 .. 100 );
is( X3DMath::odd($_),  0 ) foreach map { $_ * 2 } ( -100 .. 100 );
is( X3DMath::even($_), 0 ) foreach map { 1 + $_ * 2 } ( -100 .. 100 );
is( X3DMath::odd($_),  1 ) foreach map { 1 + $_ * 2 } ( -100 .. 100 );
is( X3DMath::sig(2),   1 );

is( X3DMath::even(3), 0 );
is( X3DMath::odd(3),  1 );
is( X3DMath::sig(3),  1 );

is( X3DMath::even(-3), 0 );
is( X3DMath::odd(-3),  1 );
is( X3DMath::sig(-3),  -1 );

is( X3DMath::even(-2), 1 );
is( X3DMath::odd(-2),  0 );
is( X3DMath::sig(-2),  -1 );

ok( X3DMath::atan2( 1, 1 ) == CORE::atan2( 1, 1 ) );
ok( X3DMath::fmod( 23.5, 4.7 ) );
ok( X3DMath::fmod( 23, 5 ) == 23 % 5 );

__END__

