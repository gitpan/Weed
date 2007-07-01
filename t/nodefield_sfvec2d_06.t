#!/usr/bin/perl -w
#package nodefield_sfvec2d_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfvec2dId = $testNode->sfvec2d->getId;
is $sfvec2dId, $testNode->sfvec2d->getId;




$testNode->sfvec2d = new SFVec2d(1/2, 1/4);
is $testNode->sfvec2d, "0.5 0.25";

my $sfvec2d = $testNode->sfvec2d;
isa_ok $sfvec2d, 'X3DField';

is $sfvec2dId, $testNode->sfvec2d->getId;
1;
__END__

