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

use Weed::Perl;

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

say $_ foreach $node1->Weed::Package::self_and_superpath;
say;

my @path = $node1->Weed::Package::self_and_superpath;
is shift @path, 'X3DNode';
is shift @path, 'Weed::Components::Core::Node';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Seed';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;

@path = $node1->Weed::Package::superpath;
is shift @path, 'Weed::Components::Core::Node';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Seed';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;

say $_ foreach $node1->Weed::Package::supertypes;
say;

my @supertypes = $node1->Weed::Package::supertypes;
is shift @supertypes, 'Weed::Components::Core::Node';
is shift @supertypes, 'X3DObject';
is shift @supertypes, undef;

__END__
