#!/usr/bin/perl -w
#package 01_values_notations2
use Test::More tests => 19;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values::Vector');
	use_ok('Weed::Values::Vec2');
	use_ok('Weed::Values::Vec3');
	use_ok('Weed::Values::Vec4');
	use_ok('Weed::Values::Color');
	use_ok('Weed::Values::ColorRGBA');
	use_ok('Weed::Values::Rotation');
}

use Weed::Perl;

my $v2 = new Weed::Values::Vec2( 1, 2 );
my $v3 = new Weed::Values::Vec3( 1, 2, 3 );
my $v4  = new Weed::Values::Vec4( 2, 4, 3, 4 );
my $c3  = new Weed::Values::Color( $v3 / 11 );
my $c4  = new Weed::Values::ColorRGBA( $v4 / 11 );
my $c41 = new Weed::Values::ColorRGBA($c3);

my $r1 = new Weed::Values::Rotation( $c4, $v3 );
my $r2 = new Weed::Values::Rotation( $v3 / 11, $v3 );

is [ 2, 4 ] *$v2, '2 8';
is [ 2, 4 ] +$v2, '3 6';
is( $v2 * [ 2, 4 ], '2 8' );
is( $v2 + [ 2, 4 ], '3 6' );

is [ 2, 4, 6 ] *$v3, '2 8 18';
is [ 2, 4, 6 ] +$v3, '3 6 9';
is( $v3 * [ 2, 4, 6 ], '2 8 18' );
is( $v3 + [ 2, 4, 6 ], '3 6 9' );

is [ 2, 4, 6, 8 ] *$v4, '4 16 18 32';
is [ 2, 4, 6, 8 ] +$v4, '4 8 9 12';
is( $v4 * [ 2, 4, 6, 8 ], '4 16 18 32' );
is( $v4 + [ 2, 4, 6, 8 ], '4 8 9 12' );

1;
__END__
