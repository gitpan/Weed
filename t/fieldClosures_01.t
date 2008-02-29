#!/usr/bin/perl -w
#package fieldClosures_01
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
  SFString  []       field   "field"
  SFString  [in]     in
  SFString  [out]    out
  SFString  [in,out] inout   "inout"
}';

package main;

ok my $testNode = new TestNode('TestNodeName');

is $testNode->field, 'field';
is $testNode->in,    '';
is $testNode->out,   '';

is $testNode->inout,         'inout';
is $testNode->set_inout,     'inout';
is $testNode->inout_changed, 'inout';
is $testNode->can("inout_changed")->($testNode), 'inout';

1;
__END__
