#!/usr/bin/perl -w
#package node_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;

ok my $node1 = new X3DBaseNode;
ok $node1->isa("UNIVERSAL");
ok $node1->isa("Weed::Object");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DBaseNode");
ok $node1->can("getId");
ok $node1->can("getType");
ok $node1->can("getTypeName");
ok $node1->can("getName");

print $_ foreach @{ 'Weed::BaseNode'->X3DPackage::getPath };
print '';
print $_ foreach @{ $node1->X3DPackage::getPath };
print '';
print $_ foreach @{ $node1->X3DPackage::getSupertypes };

my $supertypes = $node1->X3DPackage::getSupertypes;
is $supertypes->[0], 'Weed::BaseNode';
is $supertypes->[1], 'X3DObject';
is $supertypes->[2], undef;

__END__
