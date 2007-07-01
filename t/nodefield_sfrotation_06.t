#!/usr/bin/perl -w
#package nodefield_sfrotation_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfrotationId = $testNode->sfrotation->getId;
is $sfrotationId, $testNode->sfrotation->getId;


#$testNode->sfrotation = new SFRotation(new SFVec3f(1,0,0), new SFVec3f(0,1,0));
#is $testNode->sfrotation, "0 0 1 0";

$testNode->sfrotation = new SFRotation();
is $testNode->sfrotation, "0 0 1 0";

my $sfrotation = $testNode->sfrotation;
isa_ok $sfrotation, 'X3DField';

is $sfrotationId, $testNode->sfrotation->getId;

1;
__END__

