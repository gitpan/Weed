#!/usr/bin/perl -w
#package parents_03
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
	ok my $node     = $testNode->getValue;

	is $node->getReferenceCount, 2;
	is $testNode->getValue->getReferenceCount, 3;
	is $node->getReferenceCount,     2;
	is $testNode->getReferenceCount, 1;

	$testNode->setValue( $testNode->getValue );

	is $node->getReferenceCount, 2;
	is $testNode->getValue->getReferenceCount, 3;
	is $node->getReferenceCount,     2;
	is $testNode->getReferenceCount, 1;

	$testNode->setValue( new TestNode('T1') );

	is $node->getReferenceCount, 1;
	is $testNode->getValue->getReferenceCount, 2;
	is $node->getReferenceCount,     1;
	is $testNode->getReferenceCount, 1;

	print "#" x 23;
	$node = undef;
	print "#" x 23;

}

print ">" x 23;

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
