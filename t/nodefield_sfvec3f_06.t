#!/usr/bin/perl -w
#package nodefield_sfvec3f_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new TestNode;
ok my $sfvec3fId = $testNode->sfvec3f->getId;
is $sfvec3fId, $testNode->sfvec3f->getId;

ok !$testNode->sfvec3f;

$testNode->sfvec3f = new SFVec3f( 1, 2, 3 );
is $testNode->sfvec3f, "1 2 3";

$testNode->sfvec3f = new SFVec3f( 1 / 2, 1 / 4, 1 / 8 );
is $testNode->sfvec3f, "0.5 0.25 0.125";
isa_ok $testNode->sfvec3f, 'X3DVec3';

is $testNode->sfvec3f *= 2, "1 0.5 0.25";
is $testNode->sfvec3f, "1 0.5 0.25";
is int $testNode->sfvec3f,     "1 0 0";
isa_ok int $testNode->sfvec3f, 'X3DVec3';
is $testNode->sfvec3f**2, "1 0.25 0.0625";

my $sfvec3f = $testNode->sfvec3f;
isa_ok $sfvec3f, 'X3DVec3';

ok $testNode->sfvec3f == $sfvec3f;
ok $sfvec3f == $testNode->sfvec3f;
ok $sfvec3f * 2 != $testNode->sfvec3f;
ok $testNode->sfvec3f != $sfvec3f * 3;

ok $testNode->sfvec3f eq $sfvec3f;
ok $sfvec3f           eq $testNode->sfvec3f;
ok $sfvec3f * 2       ne $testNode->sfvec3f;
ok $testNode->sfvec3f ne $sfvec3f * 3;

ok $testNode->sfvec3f = [ 1, 2, 3 ];
is $testNode->sfvec3f, "1 2 3";
is $testNode->sfvec3f += [ 1, 2, 3 ], "2 4 6";

isa_ok $testNode->sfvec3f += [ 1, 2, 3 ], "X3DVec3";
isa_ok $testNode->sfvec3f -= [ 1, 2, 3 ], "X3DVec3";
isa_ok $testNode->sfvec3f, "X3DVec3";

is $testNode->sfvec3f, "2 4 6";
is ++$testNode->sfvec3f, "3 5 7";
is ++$testNode->sfvec3f, "4 6 8";

my $v = $testNode->sfvec3f++;
is $testNode->sfvec3f++, "5 7 9";
isa_ok $testNode->sfvec3f, "X3DVec3";
is $v, "4 6 8";
is $testNode->sfvec3f, "6 8 10";
isa_ok $v, 'X3DVec3';
is $v, "4 6 8";
is --$testNode->sfvec3f, "5 7 9";
is $v, "4 6 8";
is --$testNode->sfvec3f, "4 6 8";

is $testNode->sfvec3f, "4 6 8";
is $testNode->sfvec3f++, "4 6 8";
is $testNode->sfvec3f++, "5 7 9";
is $testNode->sfvec3f, "6 8 10";

is $sfvec3f, "1 0.5 0.25";
is $sfvec3f++, "1 0.5 0.25";
is $sfvec3f++, "2 1.5 1.25";
is $sfvec3f, "3 2.5 2.25";
is ++$sfvec3f, "4 3.5 3.25";
is ++$sfvec3f, "5 4.5 4.25";
is $sfvec3f, "5 4.5 4.25";
isa_ok $sfvec3f, "X3DVec3";

ok $testNode->sfvec3f = [ 3, 4, 5 ];
is $testNode->sfvec3f->length, sqrt( 3*3 + 4*4 + 5*5 );


is $sfvec3f += [0, 0.5, 0.75], "5 5 5";
isa_ok $sfvec3f + [0, 0.5, 0.75], "X3DVec3";

isa_ok $sfvec3f, "X3DVec3";
is $sfvec3fId, $testNode->sfvec3f->getId;
1;
__END__

