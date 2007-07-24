#!/usr/bin/perl -w
#package nodefield_mfvec4d_08
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

my $vec4 = $testNode->mfvec4d->[0];
$vec4->x = 123;

is $testNode->mfvec4d, '1 2 3 4';



1;
__END__
