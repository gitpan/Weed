#!/usr/bin/perl -w
#package values_rotation_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

my ( $r, $r1, $r2 );
my ( $x, $y, $z, $v );

ok( !X3DRotation->new );
ok( !X3DRotation->new( 0, 0, 1, 0 ) );
ok( !X3DRotation->new( 0, 1, 1, 0 ) );
ok( !X3DRotation->new( 1, 2, 1, 0 ) );
ok( !X3DRotation->new( 0, 0, 1, 2 * CORE::atan2( 0, -1 ) ) );
ok( !X3DRotation->new( [ 0, 0, 1 ], [ 0, 0, 1 ] ) );

ok( !X3DRotation->new( 2, 3, 5, 0 ) );
ok( !X3DRotation->new( 2, 7, 8, 0 ) );
ok( !X3DRotation->new( 5, 6, 1, 0 ) );

ok( !X3DRotation->new( 2, 3, 5, 0 ) );
ok( !X3DRotation->new( 2, 7, 8, 0 ) );
ok( !X3DRotation->new( 5, 6, 1, 4 * CORE::atan2( 0, -1 ) ) );

ok( X3DRotation->new( 2, 3, 5, 1 ) );
ok( X3DRotation->new( 2, 7, 8, 2 ) );
ok( X3DRotation->new( 5, 6, 1, -1 ) );

ok( !X3DRotation->new( 0, 0, 0, -1 ) );

ok( !new X3DRotation() );
ok( !new X3DRotation( 0, 0, 1, 0 ) );
ok( !new X3DRotation( 0, 1, 1, 0 ) );
ok( !new X3DRotation( 1, 2, 1, 0 ) );
ok( !new X3DRotation( 0, 0, 1, 2 * CORE::atan2( 0, -1 ) ) );
ok( !new X3DRotation( [ 0, 0, 1 ], [ 0, 0, 1 ] ) );

is( $r = new X3DRotation, "0 0 1 0", "$r new X3DRotation()" );
ok( ( $r = X3DRotation->new->toString ) eq "0 0 1 0", "$r X3DRotation->new->toString" );
is( $r = new X3DRotation( [ 0, 0, 1 ], 0 ), "0 0 1 0", "$r new X3DRotation([0, 0, 1],0)" );
is( $r = new X3DRotation( 0, 0, 1, 0 ), "0 0 1 0", "$r new X3DRotation( 0, 0, 1, 0 )" );
is( $r = new X3DRotation( [ 0, 0, 1 ], [ 0, 0, 1 ] ), "0 0 1 0", "$r new X3DRotation([0, 0, 1], [0, 0, 1])" );

ok( $r = new X3DRotation( [ 1, 0, 1 ], [ 0, 0, 1 ] ), "$r new X3DRotation([1, 0, 1], [0, 0, 1])" );
ok( $r = new X3DRotation( [ 1, 1, 1 ], [ 0, 0, 1 ] ), "$r new X3DRotation([1, 1, 1], [0, 0, 1])" );
ok( $r1 = new X3DRotation( 1, 2, 3, 4 ), "$r1 new X3DRotation( 1, 2, 3, 4 )" );
ok( $r2 = new X3DRotation( 1, 2, 4, 8 ), "$r2 new X3DRotation( 1, 2, 4, 8 )" );
ok( $r = $r1->inverse, "$r inverse" );
ok( $r = $r1->multiply($r2), "$r multiply" );
isa_ok( $r1->multVec( [ 1, 1, 1 ] ), "X3DVec3" );
ok( $r = $r1->slerp( $r2, 1 / 3 ), "$r slerp" );

$r2->setX(2);
ok( $r = $r2, "$r2 setX" );
ok( $r = $r1->multiply($r2), "$r multiply" );

$r2->setY(2);
ok( $r = $r2, "$r2 setY" );
ok( $r = $r1->multiply($r2), "$r multiply" );

$r2->setZ(2);
ok( $r = $r2, "$r2 setZ" );
ok( $r = $r1->multiply($r2), "$r multiply" );

$r2->setAxis( [ 2, 3, 4 ] );
ok( $r = $r2, "$r2 setAxis" );
ok( $r = $r1->multiply($r2), "$r multiply" );

$r2->setAngle(8);
ok( $r = $r2, "$r2 setAngle" );
ok( $r = $r1->multiply($r2), "$r multiply" );

$r2->setValue( 5, 6, 7, 8 );
ok( $r = $r2,                "$r2 setValue" );
ok( $r = $r1->multiply($r2), "$r multiply" );
ok( $r = $r1 * $r2,          "$r multiply" );

$r2->getValue;
$r2->setValue( 5, 6, 7, 8 );
$r2->setValue( 5, 6, 7, 8 );

is ~~ $r2 eq $r2, !1;
ok ~~ $r2 == $r2;
ok ~$r2 ne $r2;
ok ~$r2 != $r2;
is $r2 eq ~~ $r2, !1;
ok $r2 == ~~ $r2;
ok $r2 ne ~$r2;
ok $r2 != ~$r2;

ok( $r = $r2,                "$r2 setValue" );
ok( $r = $r1->multiply($r2), "$r multiply" );
ok( $r = ~( $r1 * $r2 ),     "$r multiply" );

ok( $r = ~$r1, "$r -" );
ok( $r = $r1 * $r2, "$r +" );
ok( $v = $r2 * [ 1, 2, 3 ], "@$v *" );
ok( $v = $r2 * [ 1, 2, 3 ], "@$v *" );
ok( $v = $r2->multVec( [ 1, 2, 3 ] ), "@$v *" );
ok( $v = [ $r2->multVec( new X3DVec3( [ 1, 2, 3 ] ) ) ], "@$v *" );
ok( $v = $r2->multVec( [ 1, 2, 3 ] ), "@$v *" );
ok( $r = $r2->multiply($r1), "$r *" );
ok( $v = $r2->multVec( [ 1, 2, 3, 4 ] ), "@$v *" );
ok( $v = $r2 * [ 1, 2, 3, 4 ], "@$v *" );
ok( $r = $r2 * $r1, "$r *" );
ok( $r = $r2 * $r1, "$r *" );
ok( ~$r1 == ~$r1, "$r1 ==" );
ok( ~$r1 eq ~$r1, "$r1 eq" );

ok( ~$r1 ne $r1, "$r1 ne" );
ok( ~$r1 != $r1, "$r1 ne" );

print $r1;
print $r1->getClone;
is $r1, $r1->getClone;

ok( $r1 *= $r1, "$r1 *=" );

$r2->setValue( 0, 0, 0, 8 );
is $r2, "0 0 1 0";
$r2->setValue( 0, 0, 0, 0 );
is $r2, "0 0 1 0";

$r2 = new X3DRotation( 1, 2, 3, 4 );
is $r2, "1 2 3 4";
is $r2->normalize->round(3), "0.267 0.535 0.802 4";
is $r2->normalize->getAxis->length, 1;

ok $r2->normalize == $r2;
ok $r2 == $r2->normalize;
ok $r2->normalize ne $r2;
ok $r2 ne $r2->normalize;

__END__
foreach my $c ( 1 .. 3 )
{
	is( $c, $c, "$c accuracy = 12" );
}


