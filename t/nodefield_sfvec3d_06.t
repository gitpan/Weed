#!/usr/bin/perl -w
#package nodefield_sfvec3d_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new TestNode;
ok my $sfvec3dId = $testNode->sfvec3d->getId;
is $sfvec3dId, $testNode->sfvec3d->getId;

ok !$testNode->sfvec3d;

$testNode->sfvec3d = new SFVec3d( 1, 2, 3 );
is $testNode->sfvec3d, "1 2 3";

$testNode->sfvec3d = new SFVec3d( 1 / 2, 1 / 4, 1 / 8 );
is $testNode->sfvec3d, "0.5 0.25 0.125";
is $testNode->sfvec3d *= 2, "1 0.5 0.25";
is $testNode->sfvec3d, "1 0.5 0.25";
is int $testNode->sfvec3d,     "1 0 0";
isa_ok int $testNode->sfvec3d, 'X3DVec3';
is $testNode->sfvec3d**2, "1 0.25 0.0625";

my $sfvec3d = $testNode->sfvec3d;
isa_ok $sfvec3d, 'X3DVec3';

ok $testNode->sfvec3d == $sfvec3d;
ok $sfvec3d == $testNode->sfvec3d;
ok $sfvec3d * 2 != $testNode->sfvec3d;
ok $testNode->sfvec3d != $sfvec3d * 3;

ok $testNode->sfvec3d eq $sfvec3d;
ok $sfvec3d           eq $testNode->sfvec3d;
ok $sfvec3d * 2       ne $testNode->sfvec3d;
ok $testNode->sfvec3d ne $sfvec3d * 3;

ok $testNode->sfvec3d = [ 1, 2, 3 ];
is $testNode->sfvec3d, "1 2 3";
is $testNode->sfvec3d += [ 1, 2, 3 ], "2 4 6";

isa_ok $testNode->sfvec3d += [ 1, 2, 3 ], "X3DVec3";
isa_ok $testNode->sfvec3d -= [ 1, 2, 3 ], "X3DVec3";

is $testNode->sfvec3d, "2 4 6";
is ++$testNode->sfvec3d, "3 5 7";
is ++$testNode->sfvec3d, "4 6 8";

my $v = $testNode->sfvec3d++;
is $testNode->sfvec3d++, "5 7 9";
is $v, "4 6 8";
is $testNode->sfvec3d, "6 8 10";
isa_ok $v, 'X3DVec3';
is $v, "4 6 8";
is --$testNode->sfvec3d, "5 7 9";
is $v, "4 6 8";
is --$testNode->sfvec3d, "4 6 8";

is $testNode->sfvec3d, "4 6 8";
is $testNode->sfvec3d++, "4 6 8";
is $testNode->sfvec3d++, "5 7 9";
is $testNode->sfvec3d, "6 8 10";

is $sfvec3d, "1 0.5 0.25";
is $sfvec3d++, "1 0.5 0.25";
is $sfvec3d++, "2 1.5 1.25";
is $sfvec3d, "3 2.5 2.25";
is ++$sfvec3d, "4 3.5 3.25";
is ++$sfvec3d, "5 4.5 4.25";
is $sfvec3d, "5 4.5 4.25";
isa_ok $sfvec3d, "X3DVec3";

ok $testNode->sfvec3d = [ 3, 4, 5 ];
is $testNode->sfvec3d->length, sqrt( 3*3 + 4*4 + 5*5 );

is $testNode->sfvec3d->[0], 3;
is $testNode->sfvec3d->[1], 4;
is $testNode->sfvec3d->[2], 5;

is $testNode->sfvec3d->x, 3;
is $testNode->sfvec3d->y, 4;
is $testNode->sfvec3d->z, 5;

is $testNode->sfvec3d->x++, 3;
is $testNode->sfvec3d->y++, 4;
is $testNode->sfvec3d->z++, 5;

is $testNode->sfvec3d->x, 4;
is $testNode->sfvec3d->y, 5;
is $testNode->sfvec3d->z, 6;

is $testNode->sfvec3d->[0], 4;
is $testNode->sfvec3d->[1], 5;
is $testNode->sfvec3d->[2], 6;

is $testNode->sfvec3d->x = 6, 6;
is $testNode->sfvec3d->y = 7, 7;
is $testNode->sfvec3d->z = 8, 8;

is $testNode->sfvec3d->x, 6;
is $testNode->sfvec3d->y, 7;
is $testNode->sfvec3d->z, 8;

is $testNode->sfvec3d->[0], 6;
is $testNode->sfvec3d->[1], 7;
is $testNode->sfvec3d->[2], 8;
is $testNode->sfvec3d->[0]++, 6;
is $testNode->sfvec3d->[1]++, 7;
is $testNode->sfvec3d->[2]++, 8;
is $testNode->sfvec3d->[0]++, 7;
is $testNode->sfvec3d->[1]++, 8;
is $testNode->sfvec3d->[2]++, 9;
is --$testNode->sfvec3d->[0], 7;
is --$testNode->sfvec3d->[1], 8;
is --$testNode->sfvec3d->[2], 9;
is --$testNode->sfvec3d->x, 6;
is --$testNode->sfvec3d->y, 7;
is --$testNode->sfvec3d->z, 8;

is $sfvec3d += [0, 0.5, 0.75], "5 5 5";
isa_ok $sfvec3d + [0, 0.5, 0.75], "X3DVec3";

isa_ok $sfvec3d, "X3DVec3";
is $sfvec3dId, $testNode->sfvec3d->getId;
1;
__END__

