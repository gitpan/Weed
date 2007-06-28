#!/usr/bin/perl -w
#package 06_nodefield_sfvec3d
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNode';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfvec3dId = $testNode->sfvec3d->getId;
is $sfvec3dId, $testNode->sfvec3d->getId;



$testNode->sfvec3d = new SFVec3f(3, 2, 1);
is $testNode->sfvec3d, "3 2 1";

$testNode->sfvec3d = new SFVec3d(1/2, 1/4, 1/8);
is $testNode->sfvec3d, "0.5 0.25 0.125";

$testNode->sfvec3d = new SFColor(1/4, 1/2, 1);
is $testNode->sfvec3d, "0.25 0.5 1";

$testNode->sfvec3d = new SFVec3d(new SFFloat(1/4), new SFFloat(1/2), new SFFloat(1));
is $testNode->sfvec3d, "0.25 0.5 1";
is ref $testNode->sfvec3d->getValue->[0], '';

my $x = new SFFloat(1/4);
my $y = new SFVec2f(3,4);

$testNode->sfvec3d = new SFVec3d($x, $y, 0);
is $testNode->sfvec3d, "0.25 3 4";

my $sfvec3d = $testNode->sfvec3d;
isa_ok $sfvec3d, 'X3DField';

$testNode->sfvec3d = [new SFFloat(1/4), new SFFloat(1/2), new SFFloat(1)];
is $testNode->sfvec3d, "0.25 0.5 1";

is $sfvec3dId, $testNode->sfvec3d->getId;
1;
__END__
