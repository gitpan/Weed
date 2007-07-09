#!/usr/bin/perl -w
#package parents_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok ! new SFNode;

ok my $baseNode = new X3DBaseNode;
ok !$baseNode->getParents;
is $baseNode->getParents->getSize, 0;

is my $sfnode = new SFNode, X3DConstants->NULL;
ok !$sfnode->getParents;
is $sfnode->getParents->getSize, 0;

ok my $sfnode1 = new SFNode($baseNode);
ok $baseNode->getParents;
is $baseNode->getParents->getSize, 1;

print $baseNode->getParents;

print X3DParentHash->X3DPackage::toString;

__END__
use Data::Dumper;
print Dumper $baseNode->getParents;

