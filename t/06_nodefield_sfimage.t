#!/usr/bin/perl -w
#package 06_nodefield_sfimage
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfimageId = $testNode->sfimage->getId;
is $sfimageId, $testNode->sfimage->getId;




$testNode->sfimage = new SFImage();
is $testNode->sfimage, "0 0 0";

my $sfimage = $testNode->sfimage;
isa_ok $sfimage, 'X3DField';

is $sfimageId, $testNode->sfimage->getId;
1;
__END__
