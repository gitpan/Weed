#!/usr/bin/perl -w
#package parents_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

foreach ( 1 .. 1 ) {
	my $testNode = new SFNode( new TestNode('T1') );
	my $node     = $testNode->getValue;
	$testNode->setValue( $testNode->getValue );
	$testNode->setValue( new TestNode('T1') );
}

print ">" x 23;

foreach ( 1 .. 1 ) {
	my $testNode = new MFNode( new TestNode('T1') );
	my $node     = $testNode->[0];
	$testNode->setValue( $testNode->getValue );
	$testNode->setValue( new TestNode('T1') );
}

print ">" x 23;

{
	my $testNode = new SFNode();
	foreach ( 1 .. 1 ) {
		$testNode->setValue( new X3DBaseNode('T1') );

	}
}

print ">" x 23;

{
	my $testNode = new SFNode();
	foreach ( 1 .. 1 ) {
		$testNode->setValue( new TestNode('T1') );

	}
}

print ">" x 23;

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
