#!/usr/bin/perl -w
#package nodefield_mfvec4d_06
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

ok my $mfvec4dId = $testNode->mfvec4d->getId;
is $mfvec4dId, $testNode->mfvec4d->getId;

ok !$testNode->mfvec4d;

# $testNode->mfvec4d = new MFVec4d ( [ 1, 2, 3, 4 ] );
# is $testNode->mfvec4d, "1 2 3 4";
# is $testNode->mfvec4d->length, 1;
# $testNode->mfvec4d->clear;
# is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = new MFVec4d [ [ 1, 2, 3, 4 ] ];
is $testNode->mfvec4d, "1 2 3 4";
is $testNode->mfvec4d->length, 1;
$testNode->mfvec4d->clear;
is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = [ [ 1, 2, 3, 4 ] ];
is $testNode->mfvec4d, "1 2 3 4";
is $testNode->mfvec4d->length, 1;
$testNode->mfvec4d->clear;
is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = new MFVec4d( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] );
is $testNode->mfvec4d, "[ 1 2 3 4, 1 2 3 4 ]";
is $testNode->mfvec4d->length, 2;
$testNode->mfvec4d->clear;
is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = new MFVec4d [ [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ];
is $testNode->mfvec4d, "[ 1 2 3 4, 1 2 3 4 ]";
is $testNode->mfvec4d->length, 2;
$testNode->mfvec4d->clear;
is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = [ [ 1, 2, 3, 4 ], [ 2, 3, 4, 5 ] ];
is $testNode->mfvec4d, "[ 1 2 3 4, 2 3 4 5 ]";
is $testNode->mfvec4d->length, 2;
$testNode->mfvec4d->clear;
is $testNode->mfvec4d, "[ ]";

$testNode->mfvec4d = [ [ 1, 2, 3, 4 ], [ 2, 3, 4, 5 ] ];
is $testNode->mfvec4d->length, 2;
isa_ok $testNode->mfvec4d->[0], 'X3DVec4';
isa_ok $testNode->mfvec4d->[1], 'X3DVec4';
is $testNode->mfvec4d->[2],     undef;
is $testNode->mfvec4d->[333],   undef;
$testNode->mfvec4d->[2] = [ 3, 4, 5, 6 ];
isa_ok $testNode->mfvec4d->[2], 'X3DVec4';
is $testNode->mfvec4d->[3],     undef;
is $testNode->mfvec4d->length, 3;

is $testNode->mfvec4d->[0], '1 2 3 4';
is $testNode->mfvec4d->[0]++, '1 2 3 4';
is $testNode->mfvec4d->[0], '2 3 4 5';

is $testNode->mfvec4d->[0]->[0], '2';
is $testNode->mfvec4d->[0]->[0]++, '2';
#is $testNode->mfvec4d->[0]->[0]++, '3';

is $testNode->mfvec4d->length, 3;

my $a = [];
is $a->[1],   undef;
is $a->[12],  undef;
is $a->[123], undef;
is scalar @$a, 0;
my $h = {};
is $h->{1},   undef;
is $h->{12},  undef;
is $h->{123}, undef;
is scalar keys %$h, 0;
is scalar values %$h, 0;

my $mfvec4d = $testNode->mfvec4d;
isa_ok $mfvec4d, 'X3DArray';

isa_ok $mfvec4d, "X3DArray";
is $mfvec4dId,   $testNode->mfvec4d->getId;
1;
__END__
