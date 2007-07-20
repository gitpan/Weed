#!/usr/bin/perl -w
#package node2_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

X3DGenerator->setTidyFields(NO);
ok my $node1 = new X3DBaseNode("node");
print $node1;

print $_ foreach $node1->getFieldDefinitions;

ok my $node2 = new X3DBaseNode("nodeName");

ok $node2->getId;
is $node2->getType,     'X3DBaseNode';
is $node2->getTypeName, 'X3DBaseNode';
ok $node2->getName =~ /^nodeName/;

printf "%s\n", $node2->getId;
printf "%s\n", $node2->getType;
printf "%s\n", $node2->getTypeName;
printf "%s\n", $node2->getName;
printf "%s\n", $node2;

ok $node2->getName =~ /^nodeName/;
__END__



