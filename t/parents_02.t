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


print "#" x 20;
my $testNode = new SFNode( new TestNode('T1') );

$testNode->sfnode = new SFNode( new TestNode('T11') );

ok $testNode->sfnode2 = new SFNode( new TestNode('T12') );
print "#" x 20;
$testNode->sfnode2->sfnode = new SFNode( new TestNode('T121') );
ok $testNode->sfnode2->sfnode;

print $testNode->sfnode2->getValue->getParents;

print "#" x 20;
print $testNode->getValue->getField('sfnode2')->getValue->getField('sfnode')->getValue->getParents;
print $testNode->sfnode2->sfnode->getValue->getParents;

ok $testNode->sfnode->sfnode  = new SFNode( new TestNode('T111') );

is $testNode->sfnode->getValue->getParents->getSize, 1;
is $testNode->sfnode->getValue->getParents->getSize, 1;
is $testNode->getValue->getParents->getSize, 1;


print "*" x 20;

ok $testNode->getValue->getField('sfnode')->getValue->getParents eq
  $testNode->sfnode->getValue->getParents;

ok !$testNode->getParents;
ok $testNode->sfnode->getName eq 'sfnode';
ok $testNode->sfnode->getParents == 1, '#12';
ok $testNode->sfnode2->getParents == 1;
ok $testNode->sfnode->sfnode->getName eq 'sfnode';
ok $testNode->sfnode->sfnode->getParents == 1;
ok $testNode->sfnode2->sfnode->getParents == 1;
ok $testNode->sfnode->sfnode->getId != $testNode->sfnode->getId;


is $testNode->sfnode->getId, $testNode->sfnode->getId;
is $testNode->sfnode->sfnode->getId, $testNode->sfnode->sfnode->getId;
ok $testNode->sfnode->sfnode->getId == $testNode->sfnode->sfnode->getId;
ok $testNode->sfnode->getParents == 1;

print "#" x 20;
is $testNode->sfnode->getValue->getParents->getSize, 1;

ok $testNode->sfnode->sfnode->getValue->getParents == 1;
ok $testNode->sfnode->sfnode2 = $testNode->sfnode->sfnode;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2->getValue->getParents == 2;

my $clone = $testNode->sfnode->sfnode;
is $clone->getParents->getSize, 2;

print "#" x 20;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2 = $testNode->sfnode->sfnode;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2->getValue->getParents == 2;

print $testNode->sfnode->sfnode2->getValue->getParents;

$clone = undef;
ok $testNode->sfnode->sfnode->getValue->getParents == 2;
ok $testNode->sfnode->sfnode2->getValue->getParents == 2;

print $testNode->sfnode->sfnode2->getValue->getParents;

X3DGenerator->setTidyFields(NO);
X3DGenerator->setTidyFields(YES);
print $testNode;

use Data::Dumper;
#print Dumper $testNode;
__END__
