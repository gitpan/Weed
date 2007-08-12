#!/usr/bin/perl -w
#package X3DNode_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

{
	X3DGenerator->setOutputStyle("ALL");

	ok my $node1 = new X3D::MetadataString("node");
	ok not $node1->getTainted;

	$node1->value->[0] = "node0";

	#ok $node1->getValue->getTainted;
	#ok $node1->getTainted;

	ok my $copy = $node1->getCopy;

	is $node1->value->[0], 'node0';
	is $copy->value->[0],  'node0';

	$copy->value->[0] = "copy0";

	is $node1->value->[0], 'node0';
	is $copy->value->[0],  'copy0';

	#ok my $node2 = new X3DNode("node2");
}

1;
__END__
