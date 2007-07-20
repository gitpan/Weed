#!/usr/bin/perl -w
#package nodefield_sfvec2d_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

#print SFVec2d->X3DPackage::toString;
#print SFVec2f->X3DPackage::toString;
print MFVec2f->X3DPackage::toString;

ok my $testNode  = new SFNode( new TestNode );
ok my $sfvec2dId = $testNode->sfvec2d->getId;
is $sfvec2dId, $testNode->sfvec2d->getId;

is $testNode->sfvec2d, '0 0';
ok !$testNode->sfvec2d;
is $testNode->sfvec2d ? YES : NO, NO;

ok $testNode->sfvec2d = [ 3, 4 ];
is $testNode->sfvec2d->length, sqrt( 3*3 + 4*4 );

is $testNode->sfvec2d, '3 4';
ok $testNode->sfvec2d;
is $testNode->sfvec2d ? YES : NO, YES;

is $testNode->sfvec2d->[0], 3;
is $testNode->sfvec2d->[1], 4;

is $testNode->sfvec2d->x, 3;
is $testNode->sfvec2d->y, 4;


$testNode->sfvec2d = new SFVec2d(1/2, 1/4);
is $testNode->sfvec2d, "0.5 0.25";

my $sfvec2d = $testNode->sfvec2d;
isa_ok $sfvec2d, 'X3DField';

is $sfvec2dId, $testNode->sfvec2d->getId;

1;
__END__

