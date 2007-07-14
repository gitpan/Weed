#!/usr/bin/perl -w
#package values_vec3_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

my ( $v, $v1, $v2 );

is( $v = join( " ", @{ X3DVec3->getDefaultValue } ), "0 0 0", "$v getDefaultValue" );
is( $v = @{ X3DVec3->getDefaultValue }, 3, "$v getDefaultValue" );

is( $v = new X3DVec3(), "0 0 0", "$v new X3DVec3()" );
ok !$v;

is $v->elementCount, 3;

$v->setValue(); is( $v, "0 0 0", "$v new X3DVec3()" );
$v->setValue( [1] ); is( $v, "1 0 0", "$v new X3DVec3()" );
$v->setValue( [ 1, 1 ] ); is( $v, "1 1 0", "$v new X3DVec3()" );
$v->setValue( [ 1, 1, 1 ] ); is( $v, "1 1 1", "$v new X3DVec3()" );
$v->setValue( [ 1, 1, 1, 1 ] ); is( $v, "1 1 1", "$v new X3DVec3()" );

is( $v = new X3DVec3( [ 1, 2, 3 ] ), "1 2 3", "$v new X3DVec3()" );
is( $v = new X3DVec3( [ 1, 2, 3 ] ), "1 2 3", "$v new X3DVec3()" );
is( $v = $v->getClone, "1 2 3", "$v new X3DVec3()" );
is( "$v", "1 2 3", "$v ''" );

is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getX, "1", "$v getX" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getY, "2", "$v getY" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getZ, "3", "$v getZ" );

is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getX, "1", "$v x" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getY, "2", "$v y" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->getZ, "3", "$v z" );

is( $v = new X3DVec3( [ 1, 2, 3 ] ), "1 2 3", "$v new X3DVec3()" );
$v->setX(2);
$v->setY(3);
$v->setZ(4);

is( $v->[0], "2", "$v [0]" );
is( $v->[1], "3", "$v [1]" );
is( $v->[2], "4", "$v [2]" );

ok( X3DVec3->new( [ 1, 2, 3 ] ) eq "1 2 3", "$v eq" );

is( $v = new X3DVec3( [ 1, 2, 3 ] ), "1 2 3", "$v new X3DVec3()" );

is( $v->getClone, "1 2 3", "$v getClone" );

ok( $v eq new X3DVec3( [ 1, 2, 3 ] ), "$v eq" );
ok( $v == new X3DVec3( [ 1, 2, 3 ] ), "$v ==" );
ok( $v ne new X3DVec3( [ 0, 2, 3 ] ), "$v ne" );
ok( $v != new X3DVec3( [ 0, 2, 3 ] ), "$v !=" );

is( $v1 = new X3DVec3( [ 1, 2, 3 ] ), "1 2 3", "$v1 v1" );
is( $v = $v1 + [ 1, 2, 3 ], "2 4 6", "$v +" );
is( $v = $v1 - [ 1, 2, 3 ], "0 0 0", "$v -" );

is( $v2 = new X3DVec3( [ 2, 3, 4 ] ), "2 3 4", "$v2 v2" );

is( $v = -$v1,      "-1 -2 -3",  "$v -" );
is( $v = $v1 + $v2, "3 5 7",     "$v +" );
is( $v = $v1 - $v2, "-1 -1 -1",  "$v -" );
is( $v = $v1 * 2,   "2 4 6",     "$v *" );
is( $v = $v1 / 2,   "0.5 1 1.5", "$v /" );
is( $v = $v1 . $v2, "20",        "$v ." );
is( $v = $v1 x $v2, "-1 2 -1",   "$v x" );
is( $v = $v1 . [ 2, 3, 4 ], "20",      "$v ." );
is( $v = $v1 x [ 2, 3, 4 ], "-1 2 -1", "$v x" );

is( sprintf( "%0.0f", $v = $v1->length ), "4", "$v length" );

is( $v1 += $v2, "3 5 7", "$v1 +=" );
is( $v1 -= $v2, "1 2 3", "$v1 -=" );
is( $v1 *= 2, "2 4 6", "$v1 *=" );
is( $v1 /= 2, "1 2 3", "$v1 /=" );

is( $v2 = $v1 * $v1, "1 4 9", "$v2 **" );
is( $v2 = $v2 / $v1, "1 2 3", "$v2 **" );

my $r = new X3DRotation( [ 2, 3, 4, 5 ] );
ok( $v = $r * $v1, "$v x " );

is $v->elementCount, 3;

is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(0), "1 2 3", "$v >> 0" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(1), "3 1 2", "$v >> 1" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(2), "2 3 1", "$v >> 2" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(3), "1 2 3", "$v >> 3" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(4), "3 1 2", "$v >> 4" );

is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(0),  "1 2 3", "$v << 0" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(-1), "2 3 1", "$v << 1" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(-2), "3 1 2", "$v << 2" );
is( $v = X3DVec3->new( [ 1, 2, 3 ] )->rotate(-3), "1 2 3", "$v << 3" );

# is( $v = X3DVec3->new( 1, 2, 3 ) >> 0, "1 2 3", "$v >> 0" );
# is( $v = X3DVec3->new( 1, 2, 3 ) >> 1, "3 1 2", "$v >> 1" );
# is( $v = X3DVec3->new( 1, 2, 3 ) >> 2, "2 3 1", "$v >> 2" );
# is( $v = X3DVec3->new( 1, 2, 3 ) >> 3, "1 2 3", "$v >> 3" );
# is( $v = X3DVec3->new( 1, 2, 3 ) >> 4, "3 1 2", "$v >> 4" );
#
# is( $v = X3DVec3->new( 1, 2, 3 ) << 0, "1 2 3", "$v << 0" );
# is( $v = X3DVec3->new( 1, 2, 3 ) << 1, "2 3 1", "$v << 1" );
# is( $v = X3DVec3->new( 1, 2, 3 ) << 2, "3 1 2", "$v << 2" );
# is( $v = X3DVec3->new( 1, 2, 3 ) << 3, "1 2 3", "$v << 3" );
#
# is( ~$v1, "3 2 1", "$v1 ~" );
# is( ~~ $v1, "1 2 3", "$v1 ~" );
#
# is( ~$v1, "3 2 1", "$v1 ~" );
#
# is( ref ~$v1, "X3DVec3", "$v1 ~" );

is( $v = X3DVec3->new( [ 2, 3, 4 ] ), "2 3 4", "$v abs" );

is( $v = abs( X3DVec3->new( [ 2,  3,  4 ] ) ),  "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ 2,  -3, 4 ] ) ),  "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ -2, -3, 4 ] ) ),  "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ -2, 3,  4 ] ) ),  "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ 2,  3,  -4 ] ) ), "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ 2,  -3, -4 ] ) ), "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ -2, -3, -4 ] ) ), "2 3 4", "$v abs" );
is( $v = abs( X3DVec3->new( [ -2, 3,  -4 ] ) ), "2 3 4", "$v abs" );

is( $v, "2 3 4", "$v v" );
is( $v x= $v1, "1 -2 1", "$v v" );
is( $v x= [ 1, 3, 5 ], "-13 -4 5", "$v v" );

#is( $v x= ~$v x [ 1, 2, 3 ] >> 2, "-126 42 -294", "$v v" );

is( $v1,      "1 2 3",   "$v1 **" );
is( $v1**2,   "1 4 9",   "$v1 **" );
is( $v1**3,   "1 8 27",  "$v1 **" );
is( $v1**= 2, "1 4 9",   "$v1 **" );
is( $v1**= 2, "1 16 81", "$v1 **" );

$v1->setValue( [ 2, 4, 1 ] );
$v2->setValue( [ 8, 2, 6 ] );

is( $v1, "2 4 1", "$v1 **" );
is( $v2, "8 2 6", "$v1 **" );
ok( !( $v1 > $v2 ),                 "$v1 >" );
ok( $v1 < $v2,                      "$v1 <" );
ok( !( $v1->length > $v2->length ), "$v1 >" );
ok( $v1->length < $v2->length,      "$v1 <" );
ok( ( $v1 <=> $v2 ) == -1, "$v1 <=>" );
ok( ( $v2 <=> $v1 ) == 1,  "$v1 <=>" );

$v1->setValue( [ 3, 0, 0 ] );
ok $v1 > 1;
ok 4 > $v1;

ok $v1 < 4;
ok 1 < $v1;

$v->setValue( [ 1, 2, 3 ] );
is $v**2, "1 4 9";
is 2**$v, "2 4 8";
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

is $v, '1 2 3';
is $v++, '1 2 3';
is $v++, '2 3 4';
is $v++, '3 4 5';
is $v, '4 5 6';
is ++$v, '5 6 7';
is ++$v, '6 7 8';
is ++$v, '7 8 9';

__END__


replace 'Weed::Values::Rotation' 'X3DRotation' -- `finder Weed::Values::Rotation | perl -e '%h; while (<STDIN>) { s/\:.*//; next if $h{$_};print $_; $h{$_}=1 }'`


