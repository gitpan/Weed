#!/usr/bin/perl -w
#package 01_values_notations
use Test::More tests => 7;
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

my $v2 = new Weed::Values::Vec2(1,2);
my $v3 = new Weed::Values::Vec3(1,2,3);
my $v4 = new Weed::Values::Vec4(2,4,3,4);
my $c3 = new Weed::Values::Color($v3/11);
my $c4 = new Weed::Values::ColorRGBA($v4/11);
my $c41 = new Weed::Values::ColorRGBA($c3);

my $r1 = new Weed::Values::Rotation($c4 , $v3);
my $r2 = new Weed::Values::Rotation($v3/11, $v3);

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

my $axis = $r1->getAxis * [1,4,5];
printf "%s\n", $axis;

$r2->setAxis($axis);
$r2->setAngle(2);
printf "%s\n", $r2->getAxis;
printf "%s\n", $r2;

printf "%s\n", $c4->getRGB;
printf "%s\n", $c4->getRGB / 2;
printf "%s\n", $c4->getRGB * [2,3,4];

printf "%s\n", $c4 * $c3;
printf "%s\n", $c3 * $c4;

printf "%s\n", $v4->getReal * 2;

1;
__END__
