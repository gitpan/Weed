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

ok my $v2 = new X3DVec2([1,2]);
ok my $v3 = new X3DVec3([1,2,3]);
ok my $v4 = new X3DVec4([2,4,3,4]);
ok my $c3 = new X3DColor([@{$v3/11}]);
ok my $c4 = new X3DColorRGBA([@{$v4/11}]);
ok my $c41 = new X3DColorRGBA([@{$c3}]);

ok my $r1 = new X3DRotation($c4 , $v3);
ok !( my $r2 = new X3DRotation($v3/11, $v3));

$v4->[1] = -2;

printf "%d, %f, %s\n", int($v4), $v4, $v4;

printf "%s\n", $v4/11;
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
print "xx\n"x2;
$r2->setAngle(2);



printf "%s\n", $r2->getAxis;
printf "%s\n", $r2;

printf "rgb %s\n", $c4->getRGB;
printf "rgb %s\n", $c4->getRGB / 2;
printf "rgb %s\n", $c4->getRGB * [2,3,4];

printf "%s\n", $c4 * $c3;
printf "%s\n", $c3 * $c4;

printf "%s\n", $v4->getReal * 2;

1;
__END__

