#!/usr/bin/perl -w
#package nodefield_sfvec4f_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

X3DGenerator->setOutputStyle("COMPACT");
ok my $testNode = new TestNode;
is $testNode->sfvec4f, "0 0 0 0";
is $testNode->doubles, "[ 1.2, 3.4, 5.6 ]";

ok my $sfvec4fId = $testNode->sfvec4f->getId;
is $sfvec4fId, $testNode->sfvec4f->getId;

ok !$testNode->sfvec4f;

$testNode->sfvec4f = new SFVec4d( 1, 2, 3, 4 );
is $testNode->sfvec4f, "1 2 3 4";

$testNode->sfvec4f = new SFVec4f( 1 / 2, 1 / 4, 1 / 8, 1 / 2 );
is $testNode->sfvec4f, "0.5 0.25 0.125 0.5";
is $testNode->sfvec4f *= 2, "1 0.5 0.25 1";
is $testNode->sfvec4f, "1 0.5 0.25 1";
is int $testNode->sfvec4f,     "1 0 0 1";
isa_ok int $testNode->sfvec4f, 'X3DVec4';
is $testNode->sfvec4f**2, "1 0.25 0.0625 1";

my $sfvec4f = $testNode->sfvec4f;
isa_ok $sfvec4f, 'X3DVec4';

ok $testNode->sfvec4f == $sfvec4f;
ok $sfvec4f == $testNode->sfvec4f;
ok $sfvec4f * 2 != $testNode->sfvec4f;
ok $testNode->sfvec4f != $sfvec4f * 3;

ok $testNode->sfvec4f eq $sfvec4f;
ok $sfvec4f           eq $testNode->sfvec4f;
ok $sfvec4f * 2       ne $testNode->sfvec4f;
ok $testNode->sfvec4f ne $sfvec4f * 3;

ok $testNode->sfvec4f = [ 1, 2, 3, 1 ];
is $testNode->sfvec4f, "1 2 3 1";
is $testNode->sfvec4f += [ 1, 2, 3, 1 ], "2 4 6 2";

isa_ok $testNode->sfvec4f += [ 1, 2, 3, 1 ], "X3DVec4";
isa_ok $testNode->sfvec4f -= [ 1, 2, 3, 1 ], "X3DVec4";

is $testNode->sfvec4f, "2 4 6 2";
is ++$testNode->sfvec4f, "3 5 7 3";
is ++$testNode->sfvec4f, "4 6 8 4";

my $v = $testNode->sfvec4f++;
is $testNode->sfvec4f++, "5 7 9 5";
is $v, "4 6 8 4";
is $testNode->sfvec4f, "6 8 10 6";
isa_ok $v, 'X3DVec4';
is $v,     "4 6 8 4";
is --$testNode->sfvec4f, "5 7 9 5";
is $v, "4 6 8 4";
is --$testNode->sfvec4f, "4 6 8 4";

is $testNode->sfvec4f, "4 6 8 4";
is $testNode->sfvec4f++, "4 6 8 4";
is $testNode->sfvec4f++, "5 7 9 5";
is $testNode->sfvec4f, "6 8 10 6";

is $sfvec4f, "1 0.5 0.25 1";
is $sfvec4f++, "1 0.5 0.25 1";
is $sfvec4f++, "2 1.5 1.25 2";
is $sfvec4f, "3 2.5 2.25 3";
is ++$sfvec4f, "4 3.5 3.25 4";
is ++$sfvec4f, "5 4.5 4.25 5";
is $sfvec4f,     "5 4.5 4.25 5";
isa_ok $sfvec4f, "X3DVec4";

ok $testNode->sfvec4f = [ 3, 4, 5, 6 ];
is $testNode->sfvec4f, "3 4 5 6";
is $testNode->sfvec4f->length, sqrt( 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 );

is $testNode->sfvec4f->[0], 3;
is $testNode->sfvec4f->[1], 4;
is $testNode->sfvec4f->[2], 5;
is $testNode->sfvec4f->[3], 6;
is join( ' ', @{ $testNode->sfvec4f } ), "3 4 5 6";

is $testNode->sfvec4f->[0] = 1, 1;
is $testNode->sfvec4f->[1] = 2, 2;
is $testNode->sfvec4f->[2] = 3, 3;
is $testNode->sfvec4f->[3] = 4, 4;

is $testNode->sfvec4f->[0], 1;
is $testNode->sfvec4f->[1], 2;
is $testNode->sfvec4f->[2], 3;
is $testNode->sfvec4f->[3], 4;

is $testNode->sfvec4f, "1 2 3 4";

is $sfvec4f += [ 0, 0.5, 0.75, 0 ], "5 5 5 5";
isa_ok $sfvec4f + [ 0, 0.5, 0.75, 0 ], "X3DVec4";

isa_ok $sfvec4f, "X3DVec4";
is $sfvec4fId,   $testNode->sfvec4f->getId;

1;
__END__
