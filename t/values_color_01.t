#!/usr/bin/perl -w
#package values_color_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

use Math::Trig qw(pi);

my ( $v, $v1, $v2 );

is( $v = new X3DColor(), "0 0 0", "$v new X3DColor()" );

#is join( " ", @{ $v->getValue } ), '0 0 0';

ok !$v;
isa_ok( $v, "X3DColor" );
is( $v = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v new X3DColor()" );
is( $v = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v new X3DColor()" );
is( $v = $v->getClone, "0.1 0.2 0.3", "$v new X3DColor()" );
is( "$v", "0.1 0.2 0.3", "$v ''" );

is $v->elementCount, 3;

is( $v = @{ X3DColor->getDefaultValue }, 3, "$v getDefaultValue" );

is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->x, "0.1", "$v x" );
is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->y, "0.2", "$v y" );
is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->z, "0.3", "$v z" );

is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->x, "0.1", "$v x" );
is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->y, "0.2", "$v y" );
is( $v = X3DColor->new( [ 0.1, 0.2, 0.3 ] )->z, "0.3", "$v z" );

is( $v = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v new X3DColor()" );
$v->r = 2;
$v->g = 3;
$v->b = 4;

ok( $v->x == $v->r, "$v x" );
ok( $v->x == $v->r, "$v x" );
ok( $v->x == $v->r, "$v x" );

ok( $v->y == $v->g, "$v y" );
ok( $v->y == $v->g, "$v y" );
ok( $v->y == $v->g, "$v y" );

ok( $v->z == $v->b, "$v z" );
ok( $v->z == $v->b, "$v z" );
ok( $v->z == $v->b, "$v z" );

is( $v->[0], "2", "$v [0]" );
is( $v->[1], "3", "$v [1]" );
is( $v->[2], "4", "$v [2]" );

ok( X3DColor->new( [ 0.1, 0.2, 0.3 ] ) eq "0.1 0.2 0.3", "$v eq" );

is( $v = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v new X3DColor()" );

is( $v->getClone, "0.1 0.2 0.3", "$v getClone" );

ok( $v eq new X3DColor( [ 0.1, 0.2, 0.3 ] ), "$v eq" );
ok( $v == new X3DColor( [ 0.1, 0.2, 0.3 ] ), "$v ==" );
ok( $v ne new X3DColor( [ 0, 0.2, 0.3 ] ), "$v ne" );
ok( $v != new X3DColor( [ 0, 0.2, 0.3 ] ), "$v !=" );

is( $v1 = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v1 v1" );
is( $v2 = new X3DColor( [ 0.2, 0.3, 0.4 ] ), "0.2 0.3 0.4", "$v2 v2" );

is( $v = -$v1,      "0.9 0.8 0.7",   "$v -" );
is( $v = $v1 + $v2, "0.3 0.5 0.7",   "$v +" );
is( $v = $v1 - $v2, "0 0 0",         "$v -" );
is( $v = $v1 * 2,   "0.2 0.4 0.6",   "$v *" );
is( $v = $v1 / 2,   "0.05 0.1 0.15", "$v /" );
is( $v = $v1 . $v2, "0.2",           "$v ." );
is( $v = $v1 x $v2, "0 0.02 0",      "$v x" );
is( $v = $v1 . [ 2, 3, 4 ], "2",       "$v ." );
is( $v = $v1 x [ 2, 3, 4 ], "0 0.2 0", "$v x" );

is $v->elementCount, 3;

is( sprintf( "%0.0f", $v = $v1->length ), "0", "$v length" );

is( $v1 += $v2, "0.3 0.5 0.7", "$v1 +=" );
is( $v1 -= $v2, "0.1 0.2 0.3", "$v1 -=" );
is( $v1 *= 2, "0.2 0.4 0.6", "$v1 *=" );
is( $v1 /= 2, "0.1 0.2 0.3", "$v1 /=" );

$v1->setHSV( 0 / 6 * 2 * pi, 1, 1 );
is( $v1, "1 0 0", "$v1 setHSV" );

$v1->setHSV( 1 / 6 * 2 * pi, 1, 1 );
is( $v1, "1 1 0", "$v1 setHSV" );

$v1->setHSV( 2 / 6 * 2 * pi, 1, 1 );
is( $v1, "0 1 0", "$v1 setHSV" );

$v1->setHSV( 3 / 6 * 2 * pi, 1, 1 );
is( $v1, "0 1 1", "$v1 setHSV" );

$v1->setHSV( 4 / 6 * 2 * pi, 1, 1 );
is( $v1, "0 0 1", "$v1 setHSV" );

$v1->setHSV( 5 / 6 * 2 * pi, 1, 1 );
is( $v1, "1 0 1", "$v1 setHSV" );

$v1->setHSV( 6 / 6 * 2 * pi, 1, 1 );
is( $v1, "1 0 0", "$v1 setHSV" );

is( $v = new X3DColor( [ 0.1, 0.2, 0.3 ] ), "0.1 0.2 0.3", "$v new X3DColor()" );
is( $v, "0.1 0.2 0.3", "$v new X3DColor()" );

$v1->setHSV( 1 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "1 0.5 0", "$v1 setHSV" );

$v1->setHSV( 3 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "0.5 1 0", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV( 5 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "0 1 0.5", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV( 7 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "0 0.5 1", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV( 9 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "0.5 0 1", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV( 11 / 12 * 2 * pi, 1, 1 ); $v->setHSV( $v1->getHSV );
is( $v1, "1 0 0.5", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

#use X3DRotation;
#my $r = new X3DRotation(2,3,4,5);
#ok( $v = $r * $v1, "$v x ");

$v->setValue( [ 0.1, 0.2, 0.3 ] );
is $v**2, "0.01 0.04 0.09";
is 2**$v,   "1 1 1";
is 0.2**$v, "0.851339922520785 0.724779663677696 0.61703386272001";
ok $v;
is !$v, '';

is $v->elementCount, 3;

is sqrt $v, $v**0.5;
is tan $v, sin($v) / cos($v);
is sin($v) / cos($v), tan $v;

is X3DMath::E**$v, exp $v;
is exp $v, X3DMath::E**$v;
is X3DMath::log $v, log $v;
is log $v, X3DMath::log $v;

is X3DMath::sum(@$v), sum $v;
is sum $v, X3DMath::sum(@$v);

__END__

