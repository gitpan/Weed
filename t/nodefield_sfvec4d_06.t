#!/usr/bin/perl -w
#package nodefield_sfvec4d_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode = new TestNode;

ok my $sfvec4dId = $testNode->sfvec4d->getId;
is $sfvec4dId, $testNode->sfvec4d->getId;

ok !$testNode->sfvec4d;

ok exists $testNode->sfvec4d->[0];
ok exists $testNode->sfvec4d->[1];
ok exists $testNode->sfvec4d->[2];
ok exists $testNode->sfvec4d->[3];
ok !exists $testNode->sfvec4d->[4];

is $testNode->sfvec4d, '0 0 0 0';
is $testNode->sfvec4d->[-1] = 12, 12;
is $testNode->sfvec4d, '0 0 0 12';
is $testNode->sfvec4d->[-2] = 14, 14;
is $testNode->sfvec4d, '0 0 14 12';

$testNode->sfvec4d = new SFVec4d( 1, 2, 3, 4 );
is $testNode->sfvec4d, "1 2 3 4";

$testNode->sfvec4d = new SFVec4d( 1 / 2, 1 / 4, 1 / 8, 1 / 2 );
is $testNode->sfvec4d, "0.5 0.25 0.125 0.5";
is $testNode->sfvec4d *= 2, "1 0.5 0.25 1";
is $testNode->sfvec4d, "1 0.5 0.25 1";
is int $testNode->sfvec4d,     "1 0 0 1";
isa_ok int $testNode->sfvec4d, 'X3DVec4';
is $testNode->sfvec4d**2, "1 0.25 0.0625 1";

my $sfvec4d = $testNode->sfvec4d;
isa_ok $sfvec4d, 'X3DVec4';

ok $testNode->sfvec4d == $sfvec4d;
ok $sfvec4d == $testNode->sfvec4d;
ok $sfvec4d * 2 != $testNode->sfvec4d;
ok $testNode->sfvec4d != $sfvec4d * 3;

ok $testNode->sfvec4d eq $sfvec4d;
ok $sfvec4d           eq $testNode->sfvec4d;
ok $sfvec4d * 2       ne $testNode->sfvec4d;
ok $testNode->sfvec4d ne $sfvec4d * 3;

ok $testNode->sfvec4d = [ 1, 2, 3, 1 ];
is $testNode->sfvec4d, "1 2 3 1";
is $testNode->sfvec4d += [ 1, 2, 3, 1 ], "2 4 6 2";

isa_ok $testNode->sfvec4d += [ 1, 2, 3, 1 ], "X3DVec4";
isa_ok $testNode->sfvec4d -= [ 1, 2, 3, 1 ], "X3DVec4";

is $testNode->sfvec4d, "2 4 6 2";
is ++$testNode->sfvec4d, "3 5 7 3";
is ++$testNode->sfvec4d, "4 6 8 4";

my $v = $testNode->sfvec4d++;
is $testNode->sfvec4d++, "5 7 9 5";
is $v, "4 6 8 4";
is $testNode->sfvec4d, "6 8 10 6";
isa_ok $v, 'X3DVec4';
is $v,     "4 6 8 4";
is --$testNode->sfvec4d, "5 7 9 5";
is $v, "4 6 8 4";
is --$testNode->sfvec4d, "4 6 8 4";

is $testNode->sfvec4d, "4 6 8 4";
is $testNode->sfvec4d++, "4 6 8 4";
is $testNode->sfvec4d++, "5 7 9 5";
is $testNode->sfvec4d, "6 8 10 6";

is $sfvec4d, "1 0.5 0.25 1";
is $sfvec4d++, "1 0.5 0.25 1";
is $sfvec4d++, "2 1.5 1.25 2";
is $sfvec4d, "3 2.5 2.25 3";
is ++$sfvec4d, "4 3.5 3.25 4";
is ++$sfvec4d, "5 4.5 4.25 5";
is $sfvec4d,     "5 4.5 4.25 5";
isa_ok $sfvec4d, "X3DVec4";

is $sfvec4d += [ 0, 0.5, 0.75, 0 ], "5 5 5 5";
isa_ok $sfvec4d + [ 0, 0.5, 0.75, 0 ], "X3DVec4";

is $testNode->sfvec4d, "6 8 10 6";
ok $testNode->sfvec4d = [ 1, 2, 3 ];
is $testNode->sfvec4d, "1 2 3 6";
ok $testNode->sfvec4d = [ 2, 4 ];
is $testNode->sfvec4d, "2 4 3 6";
ok $testNode->sfvec4d = 5;
is $testNode->sfvec4d, "5 4 3 6";

ok $testNode->sfvec4d = [ 3, 4, 5, 6 ];
is $testNode->sfvec4d->length, sqrt( 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 );

is $testNode->sfvec4d->[0], 3;
is $testNode->sfvec4d->[1], 4;
is $testNode->sfvec4d->[2], 5;
is $testNode->sfvec4d->[3], 6;

is $testNode->sfvec4d->x, 3;
is $testNode->sfvec4d->y, 4;
is $testNode->sfvec4d->z, 5;
is $testNode->sfvec4d->w, 6;

#ok $testNode->sfvec4d( 1, 2, 3, 4 );
#is $testNode->sfvec4d, "1 2 3 4";
#ok $testNode->sfvec4d( 1, 2, 3, 4 ) = [ 2, 3, 4, 5 ];
#is $testNode->sfvec4d, "2 3 4 5";

is $testNode->sfvec4d, "3 4 5 6";
is $testNode->sfvec4d2, "0 0 0 0";

isa_ok $sfvec4d, "X3DVec4";
is $sfvec4dId,   $testNode->sfvec4d->getId;
isa_ok $testNode->sfvec4d, "X3DVec4";
1;
__END__
