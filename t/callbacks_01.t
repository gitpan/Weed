#!/usr/bin/perl -w
#package callbacks_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

package Weed::TestNode;
use Weed 'TestNode : X3DBaseNode {
  SFString  []       field       "field"
  SFString  [in]     set_in
  SFString  [out]    out_changed
  SFString  [in,out] inout       "inout"
}';

sub prepareEvents {
	my ( $this ) = @_;
	X3DMessage->Debug( @_ );
}

sub set_in {
	my ( $this, $value, $time ) = @_;
	X3DMessage->Debug( $this, $value, $time );
}

sub set_inout {
	my ( $this, $value, $time ) = @_;
	X3DMessage->Debug( $this, $value, $time );
}

package main;

{
	ok my $testNode = new TestNode('TestNodeName');
	ok not $testNode->getTainted;
	$testNode->set_in    = "in";
	$testNode->set_inout = "neu";
	$testNode->inout     = "neu";
	ok $testNode->getTainted;

	$testNode->processEvents($testNode, $testNode, time);
	print $testNode;
}

print "END";
1;
__END__
