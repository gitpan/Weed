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

ok my $testNode = new TestNode('TestNodeFields');
ok $testNode;
ok $testNode->sfnode = new TestNode('TestNodeFieldsIn');
ok $testNode->sfnode;
is $testNode->sfnode->sfnode,        undef;
is $testNode->sfnode->sfvec3f,       '0 0 0';
is $testNode->sfnode->getName,       'sfnode';
is $testNode->sfnode->getAccessType, X3DConstants->inputOutput;
is $testNode->sfnode->sfnode->getName,       'sfnode';
is $testNode->sfnode->sfnode->getAccessType, X3DConstants->inputOutput;

is $testNode->sfnode, 'DEF ' . $testNode->sfnode->getValue->getName . ' TestNode { }';

ok my $sfnodeId = $testNode->sfnode->getId;
is $sfnodeId, $testNode->sfnode->getId;

ok UNIVERSAL::isa($testNode->sfnode, 'TestNode');
#isa_ok $testNode->sfnode, 'TestNode'; # zauber schlägt zauber
#   Failed test 'The object isa TestNode'
#   at /home/holger/cpan/Weed/t/nodefield_sfnode_06.t line 29.
#     The object isn't a 'TestNode' it's a 'TestNode'

#is $testNode->getId, $testNode->getClone->getId;
ok $testNode->getId != $testNode->getClone->getId;

ok $testNode->getId != $testNode->getCopy->getId;

ok $testNode->getId != $testNode->getCopy->getId;
ok $testNode ne $testNode->getCopy;

ok my $clone = $testNode->getClone;
ok my $copy  = $testNode->getCopy;

ok $clone->sfnode->getId != $testNode->sfnode->getId;
ok $clone->sfnode->getValue->getId == $testNode->sfnode->getValue->getId;

ok $copy->sfnode->getId != $testNode->sfnode->getId;
ok $copy->sfnode->getValue->getId == $testNode->sfnode->getValue->getId;

ok $clone->getField( $_->getName )->getId != $testNode->getField( $_->getName )->getId
  foreach @{ $testNode->getFieldDefinitions };
ok $clone->getField( $_->getName ) eq $testNode->getField( $_->getName )
  foreach @{ $testNode->getFieldDefinitions };

ok $copy->getField( $_->getName )->getId != $testNode->getField( $_->getName )->getId
  foreach @{ $testNode->getFieldDefinitions };
is X3DMath::sum( map {
		$copy->getField( $_->getName ) eq $testNode->getField( $_->getName )
	  } @{ $testNode->getFieldDefinitions } ),
  scalar @{ $testNode->getFieldDefinitions };

print $testNode;
print $clone;
print $copy;

my $sfnode = $testNode->sfnode;
#isa_ok $sfnode, 'X3DBaseNode';
ok UNIVERSAL::isa($sfnode, 'X3DBaseNode');

ok $testNode != $clone;
ok $testNode != $copy;
ok $testNode ne $clone;
ok $testNode ne $copy;

is $sfnodeId, $testNode->sfnode->getId;

1;
__END__

