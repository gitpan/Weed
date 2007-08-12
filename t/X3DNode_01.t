#!/usr/bin/perl -w
#package X3DNode_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

{
	ok my $node1 = new SFNode( new X3DNode("node") );
	ok my $node2 = new SFNode( new X3DNode("node2") );
	is $node1, 'DEF ' . $node1->getValue->getName . ' X3DNode { }';

	is $node1->getValue->getField('metadata'), X3DGenerator->NULL;
	is $node1->getValue->getField('metadata')->getType,       'SFNode';
	is $node1->getValue->getField('metadata')->getAccessType, X3DConstants->inputOutput;
	#is $node1->getValue->getField('metadata')->isReadable,      YES;
	#is $node1->getValue->getField('metadata')->isWritable,      YES;
	is $node1->getValue->getField('metadata')->getName,         'metadata';
	is $node1->getValue->getField('metadata')->getValue,        undef;
	is $node1->getValue->getField('metadata')->getInitialValue, undef;

	ok !( my $sfnode3 = $node1->getValue->getField('metadata')->getClone );
	ok ref $sfnode3;
	is $sfnode3->getType,       'SFNode';
	is $sfnode3->getAccessType, X3DConstants->inputOutput;
	#is $sfnode3->isReadable,      YES;
	#is $sfnode3->isWritable,      YES;
	is $sfnode3->getName,         '';
	is $sfnode3->getValue,        undef;
	is $sfnode3->getInitialValue, undef;

	print $node1;

	X3DGenerator->setOutputStyle("COMPACT");
	X3DGenerator->setTidyFields(NO);
	is $node1, 'DEF ' . $node1->getValue->getName . ' X3DNode {
  metadata NULL
}';

	X3DGenerator->setOutputStyle("CLEAN");
	X3DGenerator->setTidyFields(NO);
	is $node1, 'DEF ' . $node1->getValue->getName . ' X3DNode{metadata NULL}';

	X3DGenerator->setTidyFields(YES);
	is $node1, 'DEF ' . $node1->getValue->getName . ' X3DNode{}';

	print $node1;
	X3DGenerator->setOutputStyle("ALL");
}

__END__
