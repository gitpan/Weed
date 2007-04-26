#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $node1 = new X3DChildNode;
ok $node1->isa("UNIVERSAL");
ok $node1->isa("Weed::Seed");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DNode");
ok $node1->can("getId");
ok $node1->can("getType");
ok $node1->can("getTypeName");
ok $node1->can("getName");

printf "%s\n", join ", ", $node1->getHierarchy;

printf "%s\n", $node1->getId;
printf "%s\n", $node1->getType;
printf "%s\n", $node1->getTypeName;
printf "%s\n", $node1->getName;
printf "%s\n", $node1;

is $node1->getName, "";
ok $node1->getName !~ /Texture$/o;

ok my $node2 = new X3DChildNode("nodeName");

printf "%s\n", $node2->getId;
printf "%s\n", $node2->getType;
printf "%s\n", $node2->getTypeName;
printf "%s\n", $node2->getName;
printf "%s\n", $node2;

is $node2->getName, "nodeName";

__END__
