#!/usr/bin/perl -w
#package 02_childnode
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;

ok my $node1 = new X3DChildNode;
ok $node1->isa("UNIVERSAL");
ok $node1->isa("Weed::Seed");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DNode");
ok $node1->isa("X3DChildNode");
ok $node1->can("getId");
ok $node1->can("getType");
ok $node1->can("getTypeName");
ok $node1->can("getName");


say $_ foreach 'Weed::Components::Core::ChildNode'->Weed::Package::self_and_superpath;
say;
say $_ foreach $node1->Weed::Package::self_and_superpath;
say;
say $_ foreach $node1->Weed::Package::supertypes;


my @supertypes = $node1->Weed::Package::supertypes;
is shift @supertypes, 'Weed::Components::Core::ChildNode';
is shift @supertypes, 'X3DNode';
is shift @supertypes, undef;

__END__
my @path = $node1->Weed::Package::self_and_superpath;
is shift @path, 'X3DChildNode';
is shift @path, 'Weed::Components::Core::ChildNode';
is shift @path, 'X3DNode';
is shift @path, 'Weed::Components::Core::Node';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Seed';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;

@path = $node1->Weed::Package::superpath;
is shift @path, 'Weed::Components::Core::ChildNode';
is shift @path, 'X3DNode';
is shift @path, 'Weed::Components::Core::Node';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Seed';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;
