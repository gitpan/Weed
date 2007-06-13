#!/usr/bin/perl -w
#package 03_node
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $node1 = new X3DNode;
ok $node1->isa("UNIVERSAL");
ok $node1->isa("Weed::Universal");
ok $node1->isa("X3DUniversal");
ok $node1->isa("Weed::Seed");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DNode");

printf "isa %s\n", join ", ", @{ $node1->Weed::Package::array("ISA") };
printf "isa %s\n", join ", ", @{ X3DNode->Weed::Package::array("ISA") };
printf "isa %s\n", join ", ", @X3DNode::ISA;
printf "isa %s\n", join ", ", @Weed::Component::Core::Node::ISA;

printf "\n";
printf "%s\n", join ", ", $node1->getHierarchy;

isa_ok $node1, $_ foreach $node1->getHierarchy;

is join( ", ", $node1->getHierarchy ), "X3DNode, X3DObject, X3DUniversal"; # 8
print map { "ISA:  $_\n" } $node1->Weed::Package::superpath;
print map { "Super:  $_\n" } ref $node1;
ok $node1->isa("X3DNode");

is $node1->Weed::Package::supertype, "Weed::Components::Core::Node";

printf "\n";
can_ok $node1, qw'
  getId
  getType
  getTypeName
  getName
  ';

#printf "*** %s\n", join ", ", $_ foreach @{ $node1->getFieldDefinitions };

ok $node1->getId;
is $node1->getType,     'X3DNode';
is $node1->getTypeName, 'X3DNode';
is $node1->getName,     "";

printf "\n";
printf "%s\n", $node1->getId;
printf "%s\n", $node1->getType;
printf "%s\n", $node1->getTypeName;
printf "%s\n", $node1->getName;
printf "%s\n", $node1;

is $node1->getName, "";
ok $node1->getName !~ /Texture$/o;

ok my $node2 = new X3DNode("nodeName");

ok $node2->getId;
is $node2->getType,     'X3DNode';
is $node2->getTypeName, 'X3DNode';
is $node2->getName,     "nodeName";

printf "%s\n", $node2->getId;
printf "%s\n", $node2->getType;
printf "%s\n", $node2->getTypeName;
printf "%s\n", $node2->getName;
printf "%s\n", $node2;

is $node2->getName, "nodeName";

#ok $node2->VERSION;

__END__
