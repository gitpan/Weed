#!/usr/bin/perl -w
#package 01_X3DNode
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $node1 = new X3DNode("node");
ok my $node2 = new X3DNode("node2");
is $node1, 'DEF node X3DNode { }';

is $node1->getField('metadata'), X3DGenerator->NULL;
is $node1->getField('metadata')->getType,         'SFNode';
is $node1->getField('metadata')->getAccessType,   X3DConstants->inputOutput;
is $node1->getField('metadata')->isReadable,      YES;
is $node1->getField('metadata')->isWritable,      YES;
is $node1->getField('metadata')->getName,         'metadata';
is $node1->getField('metadata')->getValue,        undef;
is $node1->getField('metadata')->getInitialValue, undef;

ok !( my $sfnode3 = $node1->getField('metadata')->clone );
ok ref $sfnode3;
is $sfnode3->getType,         'SFNode';
is $sfnode3->getAccessType,   X3DConstants->inputOutput;
is $sfnode3->isReadable,      YES;
is $sfnode3->isWritable,      YES;
is $sfnode3->getName,         '';
is $sfnode3->getValue,        undef;
is $sfnode3->getInitialValue, undef;

print $node1;

X3DGenerator->compact;
X3DGenerator->tidy_fields(NO);
is $node1, 'DEF node X3DNode { metadata NULL }';

X3DGenerator->clean;
X3DGenerator->tidy_fields(NO);
is $node1, 'DEF node X3DNode{metadata NULL}';

X3DGenerator->tidy_fields(YES);
is $node1, 'DEF node X3DNode{}';

print $node1;

__END__