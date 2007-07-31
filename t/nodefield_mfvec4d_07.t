#!/usr/bin/perl -w
#package nodefield_mfvec4d_07
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

X3DGenerator->setOutputStyle("COMPACT");
ok my $testNode = new SFNode( new TestNode );

$testNode->mfvec4d->[0] = [ 1, 2, 3, 4 ];
is $testNode->mfvec4d->[0]->x++, '1';
is $testNode->mfvec4d->[0]->x, '1';
#is $testNode->mfvec4d->[0]->x++, '2';
#is $testNode->mfvec4d->[0]->[0]++, '3';
#is $testNode->mfvec4d->[0]->[0]++, '4';

$testNode->mfvec4d->length = 3;
is $testNode->mfvec4d, '[ 1 2 3 4, 0 0 0 0, 0 0 0 0 ]';
$testNode->mfvec4d->[1]->[3] = 3;
$testNode->mfvec4d->[1]->w = 4;
#is $testNode->mfvec4d, '[ 1 2 3 4, 0 0 3 4, 0 0 0 0 ]';

is $testNode->mfvec4d->[6], undef;

$testNode->mfvec4d->[6] = [ 6, 7, 8, 9 ];
is $testNode->mfvec4d->[6], '6 7 8 9';
is $testNode->mfvec4d->length, 7;
is $testNode->mfvec4d->[5], '0 0 0 0';

is $testNode->mfvec4d,  '[ 1 2 3 4, 0 0 0 0, 0 0 0 0, 0 0 0 0, 0 0 0 0, 0 0 0 0, 6 7 8 9 ]';
is $testNode->mfvec4d2, '[ ]';

1;
__END__
