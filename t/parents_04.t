#!/usr/bin/perl -w
#package parents_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

{
	ok my $testNode = new SFNode( new TestNode('T1') );
	is $testNode->getValue->getReferenceCount, 2;
	is $testNode->getReferenceCount, 1;

	$testNode->setValue( new TestNode('T1') );
	ok $testNode;

	print "#" x 23;
}

print ">" x 23;

__END__
