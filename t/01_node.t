#!/usr/bin/perl -w
#package 01_node
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
#ok $node1->isa("X3DUniversal");
ok $node1->isa("Weed::Seed");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DNode");

ok $node1 = new X3DNode('namedernode');
is $node1->getName, 'namedernode';

#printf "*** %s\n", join ", ", $_ foreach @{ $node1->getFieldDefinitions };

__END__
