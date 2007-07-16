#!/usr/bin/perl -w
#package values_notations_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values');
}

ok my $v2 = new X3DVec2( [ 1, 2 ] );
ok my $v3 = new X3DVec3( [ 1, 2, 3 ] );
ok my $v4  = new X3DVec4(      [ 2, 4, 3, 4 ] );
ok my $c3  = new X3DColor(     [ @{ $v3 / 11 } ] );
ok my $c4  = new X3DColorRGBA( [ @{ $v4 / 11 } ] );
ok my $c41 = new X3DColorRGBA( [ @{$c3}, 0 ] );

ok my $r1 = new X3DRotation( $c4, $v3 );
ok !( my $r2 = new X3DRotation( $v3 / 11, $v3 ) );

$v4->[1] = -2;
ok $v4->[1] == $v4->y;

is $r1, '0.894427190999916 -0.447213595499958 0 0.339401263970053';
is $r1->x,     '0.894427190999916';
is $r1->y,     '-0.447213595499958';
is $r1->z,     '0';
is $r1->angle, '0.339401263970053';

ok $r1->x == $r1->[0];
ok $r1->y == $r1->[1];
ok $r1->z == $r1->[2];
ok $r1->angle == $r1->[3];
ok $r1->elementCount == 4;
is $r1->elementCount, 4;

printf "%d, %f, %s\n", int($v4), $v4, $v4;

printf "%s\n", $v4 / 11;
printf "%s\n", $v2;
printf "%s\n", $v3;
printf "%s\n", $v3;

printf "%s\n", $c3;
printf "%s\n", $c4;
printf "%s\n", $c41;

printf "%s\n", $r1;
printf "%s\n", $r2;

ok my $axis = $r1->getAxis;
printf "%s\n", $axis;

$r2->setAxis($axis);
print "xx\n" x 2;
$r2->setAngle(2);

printf "%s\n", $r2->getAxis;
printf "%s\n", $r2;

printf "rgb %s\n", $c4->getRGB;
printf "rgb %s\n", $c4->getRGB / 2;
printf "rgb %s\n", $c4->getRGB * [ 2, 3, 4 ];

printf "%s\n", $c4 * $c3;
printf "%s\n", $c3 * $c4;

printf "%s\n", $v4->getReal * 2;

#new X3DRotation foreach 1..100000;

1;
__END__

