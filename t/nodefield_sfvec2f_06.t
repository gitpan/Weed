#!/usr/bin/perl -w
#package nodefield_sfvec2f_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfvec2fId = $testNode->sfvec2f->getId;
is $sfvec2fId, $testNode->sfvec2f->getId;



$testNode->sfvec2f = new SFVec2f(1/2, 1/4);
is $testNode->sfvec2f, "0.5 0.25";

my $sfvec2f = $testNode->sfvec2f;
isa_ok $sfvec2f, 'X3DField';

is $sfvec2fId, $testNode->sfvec2f->getId;
1;
__END__

