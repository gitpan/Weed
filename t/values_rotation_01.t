#!/usr/bin/perl -w
#package values_rotation_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values::Rotation');
}

my ( $r, $r1, $r2 );
my ( $x, $y, $z, $v );

ok( !Weed::Values::Rotation->new );
ok( !Weed::Values::Rotation->new( 0, 0, 1, 0 ) );
ok( !Weed::Values::Rotation->new( 0, 1, 1, 0 ) );
ok( !Weed::Values::Rotation->new( 1, 2, 1, 0 ) );
ok( !Weed::Values::Rotation->new( 0, 0, 1, 2 * CORE::atan2( 0, -1 ) ) );
ok( !Weed::Values::Rotation->new( [ 0, 0, 1 ], [ 0, 0, 1 ] ) );

ok( !Weed::Values::Rotation->new( 2, 3, 5, 0 ) );
ok( !Weed::Values::Rotation->new( 2, 7, 8, 0 ) );
ok( !Weed::Values::Rotation->new( 5, 6, 1, 0 ) );

ok( !Weed::Values::Rotation->new( 2, 3, 5, 0 ) );
ok( !Weed::Values::Rotation->new( 2, 7, 8, 0 ) );
ok( !Weed::Values::Rotation->new( 5, 6, 1, 4 * CORE::atan2( 0, -1 ) ) );

ok( Weed::Values::Rotation->new( 2, 3, 5, 1 ) );
ok( Weed::Values::Rotation->new( 2, 7, 8, 2 ) );
ok( Weed::Values::Rotation->new( 5, 6, 1, -1 ) );

ok( !Weed::Values::Rotation->new( 0, 0, 0, -1 ) );

ok( !new Weed::Values::Rotation() );
ok( !new Weed::Values::Rotation( 0, 0, 1, 0 ) );
ok( !new Weed::Values::Rotation( 0, 1, 1, 0 ) );
ok( !new Weed::Values::Rotation( 1, 2, 1, 0 ) );
ok( !new Weed::Values::Rotation( 0, 0, 1, 2 * CORE::atan2( 0, -1 ) ) );
ok( !new Weed::Values::Rotation( [ 0, 0, 1 ], [ 0, 0, 1 ] ) );

is( $r = new Weed::Values::Rotation, "0 0 1 0", "$r new Weed::Values::Rotation()" );
ok( ( $r = Weed::Values::Rotation->new->toString ) eq "0 0 1 0", "$r Weed::Values::Rotation->new->toString" );
is( $r = new Weed::Values::Rotation( [ 0, 0, 1 ], 0 ), "0 0 1 0", "$r new Weed::Values::Rotation([0, 0, 1],0)" );
is( $r = new Weed::Values::Rotation( 0, 0, 1, 0 ), "0 0 1 0", "$r new Weed::Values::Rotation( 0, 0, 1, 0 )" );
is( $r = new Weed::Values::Rotation( [ 0, 0, 1 ], [ 0, 0, 1 ] ), "0 0 1 0", "$r new Weed::Values::Rotation([0, 0, 1], [0, 0, 1])" );

ok( $r = new Weed::Values::Rotation( [ 1, 0, 1 ], [ 0, 0, 1 ] ), "$r new Weed::Values::Rotation([1, 0, 1], [0, 0, 1])" );
ok( $r = new Weed::Values::Rotation( [ 1, 1, 1 ], [ 0, 0, 1 ] ), "$r new Weed::Values::Rotation([1, 1, 1], [0, 0, 1])" );
ok( $r1 = new Weed::Values::Rotation( 1, 2, 3, 4 ), "$r1 new Weed::Values::Rotation( 1, 2, 3, 4 )" );
ok( $r2 = new Weed::Values::Rotation( 1, 2, 4, 8 ), "$r2 new Weed::Values::Rotation( 1, 2, 4, 8 )" );
ok( $r = $r1->inverse, "$r inverse" );
ok( $r = $r1->multiply($r2), "$r multiply" );
ok( ( $x, $y, $z ) = $r1->multVec( 1, 1, 1 ), "$x, $y, $z multVec" );
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

$r2->setAxis( [2, 3, 4] );
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
ok( $r = $r2,                "$r2 setValue" );
ok( $r = $r1->multiply($r2), "$r multiply" );
ok( $r = ~( $r1 * $r2 ),     "$r multiply" );

ok( $r = ~$r1, "$r -" );
ok( $r = $r1 * $r2, "$r +" );
ok( $v = $r2 * [ 1, 2, 3 ], "@$v *" );
ok( $v = $r2 * [ 1, 2, 3 ], "@$v *" );
ok( $v = $r2->multVec( [ 1, 2, 3 ] ), "@$v *" );
ok( $v = [ $r2->multVec( 1, 2, 3 ) ], "@$v *" );
ok( $v = [ $r2->multVec( 1, 2, 3, 4 ) ], "@$v *" );
ok( $r = $r2->multVec($r1), "$r *" );
#ok( $v = $r2->multVec( [ 1, 2, 3, 4 ] ), "@$v *" );
#ok( $v = $r2 * [ 1, 2, 3, 4 ], "@$v *" );
ok( $r = $r2 * $r1, "$r *" );
ok( $r = $r2 * $r1, "$r *" );
ok( ~$r1 == ~$r1, "$r1 ==" );
ok( ~$r1 eq ~$r1, "$r1 eq" );

ok( ~$r1 ne $r1, "$r1 ne" );
ok( ~$r1 != $r1, "$r1 ne" );

print $r1;
print $r1->getClone;
ok( $r1 eq $r1->getClone, "$r1 getClone" );

ok( $r1 *= $r1, "$r1 *=" );

$r2->setValue( 0, 0, 0, 8 );
is $r2, "0 0 1 0";
$r2->setValue( 0, 0, 0, 0 );
is $r2, "0 0 1 0";

$r2 = new Weed::Values::Rotation(1,2,3,4);
is $r2, "0.267261241912424 0.534522483824849 0.801783725737273 4";

__END__
foreach my $c ( 1 .. 3 )
{
	is( $c, $c, "$c accuracy = 12" );
}


