#!/usr/bin/perl -w
#package nodefield_sfnode_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode = new SFNode( new TestNode('TestNodeFields') );
ok $testNode;
ok $testNode->sfnode = new SFNode( new TestNode('TestNodeFieldsIn') );
ok $testNode->sfnode;
is $testNode->sfnode, 'DEF ' . $testNode->sfnode->getValue->getName . ' TestNode { }';

ok my $sfnodeId = $testNode->sfnode->getId;
is $sfnodeId, $testNode->sfnode->getId;

is $testNode->getValue->getId, $testNode->getClone->getValue->getId;
ok $testNode->getId != $testNode->getClone->getId;

ok $testNode->getId != $testNode->getCopy->getId;

ok $testNode->getId != $testNode->getCopy->getId;
ok $testNode ne $testNode->getCopy;

ok my $clone = $testNode->getClone;
ok my $copy  = $testNode->getCopy;

ok $clone->sfnode->getId == $testNode->sfnode->getId;
ok $clone->sfnode->getValue->getId == $testNode->sfnode->getValue->getId;

ok $copy->sfnode->getId != $testNode->sfnode->getId;
ok $copy->sfnode->getValue->getId == $testNode->sfnode->getValue->getId;

ok $clone->getValue->getField( $_->getName )->getId == $testNode->getValue->getField( $_->getName )->getId
  foreach @{ $testNode->getValue->getFieldDefinitions };
ok $clone->getValue->getField( $_->getName ) eq $testNode->getValue->getField( $_->getName )
  foreach @{ $testNode->getValue->getFieldDefinitions };

ok $copy->getValue->getField( $_->getName )->getId != $testNode->getValue->getField( $_->getName )->getId
  foreach @{ $testNode->getValue->getFieldDefinitions };
is X3DMath::sum( map {
		$copy->getValue->getField( $_->getName ) eq $testNode->getValue->getField( $_->getName )
	  } @{ $testNode->getValue->getFieldDefinitions } ),
  scalar @{ $testNode->getValue->getFieldDefinitions };

print $testNode;
print $clone;
print $copy;

my $sfnode = $testNode->sfnode;
isa_ok $sfnode, 'X3DField';

ok $testNode == $clone;
ok $testNode != $copy;
ok $testNode eq $clone;
ok $testNode ne $copy;

is $sfnodeId, $testNode->sfnode->getId;

1;
__END__

