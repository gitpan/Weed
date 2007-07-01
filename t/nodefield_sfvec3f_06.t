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

ok my $testNode  = new SFNode( new TestNode );
ok my $sfvec3fId = $testNode->sfvec3f->getId;
is $sfvec3fId, $testNode->sfvec3f->getId;



$testNode->sfvec3f = new SFVec3d(1,2,3);
is $testNode->sfvec3f, "1 2 3";

$testNode->sfvec3f = new SFVec3f(1/2, 1/4, 1/8);
is $testNode->sfvec3f, "0.5 0.25 0.125";

my $sfvec3f = $testNode->sfvec3f;
isa_ok $sfvec3f, 'X3DField';

is $sfvec3fId, $testNode->sfvec3f->getId;
1;
__END__

