#!/usr/bin/perl -w
#package values_vec2_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values::Vec2');
}

my ( $v, $v1, $v2 );

is( $v = join( " ", @{ Weed::Values::Vec2->getDefaultValue } ), "0 0", "$v getDefaultValue" );
is( $v = @{ Weed::Values::Vec2->getDefaultValue }, 2, "$v getDefaultValue" );

is( $v = new Weed::Values::Vec2(), "0 0", "$v new Weed::Values::Vec2()" );
ok !$v;
is $v->size, 2;

$v->setValue();  is( $v, "0 0", "$v new Weed::Values::Vec2()" );
$v->setValue(1); is( $v, "1 0", "$v new Weed::Values::Vec2()" );
$v->setValue( 1, 1 ); is( $v, "1 1", "$v new Weed::Values::Vec2()" );
$v->setValue( 1, 1, 1 ); is( $v, "1 1", "$v new Weed::Values::Vec2()" );

is( $v = new Weed::Values::Vec2(), "0 0", "$v new Weed::Values::Vec2()" );
is( $v = new Weed::Values::Vec2( 1, 2 ), "1 2", "$v new Weed::Values::Vec2()" );
is( $v = new Weed::Values::Vec2( [ 1, 2 ] ), "1 2", "$v new Weed::Values::Vec2()" );
is( $v = $v->copy, "1 2", "$v new Weed::Values::Vec2()" );
is( "$v", "1 2", "$v ''" );

is( $v = Weed::Values::Vec2->new( 1, 2 )->getX, "1", "$v getX" );
is( $v = Weed::Values::Vec2->new( 1, 2 )->getY, "2", "$v getY" );

is( $v = Weed::Values::Vec2->new( 1, 2 )->getX, "1", "$v x" );
is( $v = Weed::Values::Vec2->new( 1, 2 )->getY, "2", "$v y" );

is( $v = new Weed::Values::Vec2( 1, 2 ), "1 2", "$v new Weed::Values::Vec2()" );
$v->setX(2);
$v->setY(3);

is( $v->[0], "2", "$v [0]" );
is( $v->[1], "3", "$v [1]" );

ok( Weed::Values::Vec2->new( 1, 2 ) eq "1 2", "$v eq" );

is( $v = new Weed::Values::Vec2( 1, 2 ), "1 2", "$v new Weed::Values::Vec2()" );

is( $v->copy, "1 2", "$v copy" );

ok( $v eq new Weed::Values::Vec2( 1, 2 ), "$v eq" );
ok( $v == new Weed::Values::Vec2( 1, 2 ), "$v ==" );
ok( $v ne new Weed::Values::Vec2( 0, 2 ), "$v ne" );
ok( $v != new Weed::Values::Vec2( 0, 2 ), "$v !=" );

is( $v1 = new Weed::Values::Vec2( 1, 2 ), "1 2", "$v1 v1" );
is( $v2 = new Weed::Values::Vec2( 2, 3 ), "2 3", "$v2 v2" );

is( $v = $v1 + [ 1, 2 ], "2 4", "$v +" );
is( $v = $v1 - [ 1, 2 ], "0 0", "$v -" );

is( $v = -$v1,      "-1 -2", "$v -" );
is( $v = $v1 + $v2, "3 5",   "$v +" );
is( $v = $v1 - $v2, "-1 -1", "$v -" );
is( $v = $v1 * 2,   "2 4",   "$v *" );
is( $v = $v1 / 2,   "0.5 1", "$v /" );
is( $v = $v1 . $v2, "8",     "$v ." );
is( $v = $v1 . [ 2, 3 ], "8", "$v ." );

is( sprintf( "%0.0f", $v = $v1->length ), "2", "$v length" );

is( $v1 += $v2, "3 5", "$v1 +=" );
is( $v1 -= $v2, "1 2", "$v1 -=" );
is( $v1 *= 2, "2 4", "$v1 *=" );
is( $v1 /= 2, "1 2", "$v1 /=" );

is( $v1, "1 2", "$v1 ------------" );
# is( $v1 >> 1,  "2 1", "$v1 >> 1" );
# is( $v1 >> 2,  "1 2", "$v1 >> 1" );
# is( $v1 >> 4,  "1 2", "$v1 >> 1" );
# is( $v1 >> 5,  "2 1", "$v1 >> 1" );
# is( $v1 >> -1, "2 1", "$v1 >> 1" );
# is( $v1 << 1,  "2 1", "$v1 >> 1" );
# is( $v1 << 2,  "1 2", "$v1 >> 1" );

#is( ~$v1, "2 1", "$v1 ~" );
##is( ~~ $v1, "1 2", "$v1 ~" );

is( $v = Weed::Values::Vec2->new( 2, 3 ), "2 3", "$v abs" );

is( $v = abs( Weed::Values::Vec2->new( 2,  3 ) ),  "2 3", "$v abs" );
is( $v = abs( Weed::Values::Vec2->new( 2,  -3 ) ), "2 3", "$v abs" );
is( $v = abs( Weed::Values::Vec2->new( -2, -3 ) ), "2 3", "$v abs" );
is( $v = abs( Weed::Values::Vec2->new( -2, 3 ) ),  "2 3", "$v abs" );

is( $v1,      "1 2",  "$v1 **" );
is( $v1**2,   "1 4",  "$v1 **" );
is( $v1**3,   "1 8",  "$v1 **" );
is( $v1**= 2, "1 4",  "$v1 **" );
is( $v1**= 2, "1 16", "$v1 **" );

$v1->setValue( 2, 4 );
$v2->setValue( 8, 2 );

is( $v1, "2 4", "$v1 **" );
is( $v2, "8 2", "$v1 **" );
ok( !( $v1 > $v2 ),                 "$v1 >" );
ok( $v1 < $v2,                      "$v1 <" );
ok( !( $v1->length > $v2->length ), "$v1 >" );
ok( $v1->length < $v2->length,      "$v1 <" );
ok( ( $v1 <=> $v2 ) == -1, "$v1 <=>" );
ok( ( $v2 <=> $v1 ) == 1,  "$v1 <=>" );

$v1->setValue( 1, 0 );
$v2->setValue( 2, 4 );

is $v->size, 2;

ok( !( $v1 gt $v2 ), "$v1 >" );
ok( $v1 lt $v2, "$v1 <" );
ok( ( $v1 cmp $v2 ) == -1, "$v1 <=>" );
ok( ( $v2 cmp $v1 ) == 1,  "$v1 <=>" );

is( $v2 / $v2, "1 1", "$v2 /" );

$v1->setValue( -2, -2 );
is( $v1->sig, "-1 -1", "$v1 sig" );

$v1->setValue( 2, -2 );
is( $v1->sig, "1 -1", "$v1 sig" );

$v1->setValue( -2, 2 );
is( $v1->sig, "-1 1", "$v1 sig" );

$v1->setValue( 2, 2 );
is( $v1->sig, "1 1", "$v1 sig" );

$v1->setValue( 2, 0 );
is( $v1->sig, "1 0", "$v1 sig" );

$v1->setValue( 0, 0 );
is( $v1->sig, "0 0", "$v1 sig" );

$v1 += [ 1, 3 ];
is( $v1->sum, "4", "$v1 sum" );

$v1 += [ 1, 3 ];
is( $v1->sum, "8", "$v1 sum" );

is( $v1, "2 6", "$v1 v" );
is( [ 0, 0 ] -$v1, "-2 -6", "$v1 v" );

# $v1->setValue( 1, 3 );
# $v1 <<= 1;
# is( $v1, "3 1", "$v1 v" );
# $v1 <<= 2;
# is( $v1, "3 1", "$v1 v" );
# $v1 <<= 1;
# is( $v1, "1 3", "$v1 v" );
#
# $v1->setValue( 1, 3 );
# $v1 >>= 1;
# is( $v1, "3 1", "$v1 v" );
# $v1 >>= 2;
# is( $v1, "3 1", "$v1 v" );
# $v1 >>= 1;
# is( $v1, "1 3", "$v1 v" );

$v1->setValue( 54, 5454 );
is( $v1 % $v2, "0 2", "$v1 v" );

#use Math::Rotation;
#my $r = new Math::Rotation(2,3,4,5);
#ok( $v = $r * $v1, "$v x ");

$v->setValue( 1, 2 );
is $v**2, "1 4";
is 2**$v, "2 4";
ok $v;
is !$v, '';

is $v->size, 2;

is sqrt $v, $v**0.5;
is tan $v, sin($v) / cos($v);
is sin($v) / cos($v), tan $v;

is Math::E**$v, exp $v;
is exp $v, Math::E**$v;
is Math::log $v, log $v;
is log $v, Math::log $v;

is Math::sum(@$v), sum $v;

__END__



