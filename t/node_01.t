#!/usr/bin/perl -w
#package node_01
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
ok $node1->isa("Weed::Universal");
#ok $node1->isa("X3DUniversal");
ok $node1->isa("Weed::Object");
ok $node1->isa("X3DUniversal");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DBaseNode");

ok $node1 = new X3DBaseNode('namedernode');
ok $node1->getName =~ /^namedernode/;

#printf "*** %s\n", join ", ", $_ foreach @{ $node1->getFieldDefinitions };

print $_ foreach $node1->X3DPackage::getSelfAndSuperpath;
print '';

my @path = $node1->X3DPackage::getSelfAndSuperpath;
is shift @path, 'X3DBaseNode';
is shift @path, 'Weed::BaseNode';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Object';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;

@path = $node1->X3DPackage::getSuperpath;
is shift @path, 'Weed::BaseNode';
is shift @path, 'X3DObject';
is shift @path, 'Weed::Object';
is shift @path, 'X3DUniversal';
is shift @path, 'Weed::Universal';
is shift @path, undef;

print $_ foreach $node1->X3DPackage::getSupertypes;
print '';

my @supertypes = $node1->X3DPackage::getSupertypes;
is shift @supertypes, 'Weed::BaseNode';
is shift @supertypes, 'X3DObject';
is shift @supertypes, undef;

__END__

