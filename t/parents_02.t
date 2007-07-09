#!/usr/bin/perl -w
#package parents_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

ok my $testNode               = new SFNode( new TestNode('T1') );

ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
ok $testNode->sfnode->sfnode  = new SFNode( new TestNode('T111') );
ok $testNode->sfnode2         = new SFNode( new TestNode('T12') );
ok $testNode->sfnode2->sfnode = new SFNode( new TestNode('T121') );

ok !$testNode->getParents;
ok $testNode->sfnode->getName eq 'sfnode';
ok $testNode->sfnode->getParents == 1, '#10';
ok $testNode->sfnode2->getParents == 1;
ok $testNode->sfnode->sfnode->getName eq 'sfnode';
ok $testNode->sfnode->sfnode->getParents == 1;
ok $testNode->sfnode2->sfnode->getParents == 1;
ok $testNode->sfnode->sfnode->getId != $testNode->sfnode->getId;

print $testNode->sfnode->sfnode->getValue->getParents;

print "#" x 20;
ok $testNode->sfnode->sfnode->getValue->getParents == 1;
ok $testNode->sfnode->sfnode2 = $testNode->sfnode->sfnode;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2->getValue->getParents == 2;

my $clone = $testNode->sfnode->sfnode;
ok !$clone->getParents;

print "#" x 20;
ok $testNode->sfnode->sfnode->getValue->getParents == 3;
ok $testNode->sfnode->sfnode2 = $testNode->sfnode->sfnode;
ok $testNode->sfnode->sfnode->getValue->getParents == 3;
ok $testNode->sfnode->sfnode2->getValue->getParents == 3;

print $testNode->sfnode->sfnode2->getValue->getParents;

$clone = undef;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2->getValue->getParents == 2;

print $testNode->sfnode->sfnode2->getValue->getParents;

X3DGenerator->tidy_fields(NO);
X3DGenerator->tidy_fields(YES);
print $testNode;

use Data::Dumper;
#print Dumper $testNode;
__END__
