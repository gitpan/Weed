#!/usr/bin/perl -w
#package memory_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

{

	ok my $testNode = new SFNode( new TestNode('TestName') );

	sub set_children {
		my ( $this, $value ) = @_;
		is $value->getReferenceCount, 2;
		is $value->[0]->getReferenceCount, 1;
		is $value->[0]->getValue->getReferenceCount, 4;
		
		is $value->[0]->getValue->getParents->getSize, 2;
		is $value->[0]->getValue->getParents->getSize, 2;

		ok $this->mfnode = $value;
		is $value->[0]->getValue->getParents->getSize, 3;

		is $value->[0]->getReferenceCount, 1;
		is $this->mfnode->[0]->getReferenceCount, 1;
		is $value->[0]->getValue->getReferenceCount, 5;
		

		ok $this->mfnode->[1] = $value->[0];
		is $this->mfnode->[1]->getValue->getParents->getValues->getLength, 3;
		is $value->[0]->getValue->getParents->getValues->getLength, 3;

		ok my $node = $value->[0]->getValue;
		is $node->getParents->getValues->getLength, 2;

		$#{ $this->mfnode } = -1;
		is $node->getParents->getValues->getLength, 1;

		is $node->getParents->getValues->[0]->getType, 'MFNode';
		is $node->getParents->getValues->getLength, 1;

		ok $this->mfnode->[0] = $value->[0];
		is $node->getParents->getValues->getLength, 2;

		ok $this->mfnode->[1] = $value->[0];
		is $node->getParents->getValues->getLength, 2;

		ok $this->mfnode->[2] = $value->[0];
		is $node->getParents->getValues->getLength, 2;

		is $this->mfnode->[0] = undef, 'NULL';
		is $node->getParents->getValues->getLength, 2;

		is $this->mfnode->[1] = undef, 'NULL';
		is $node->getParents->getValues->getLength, 2;

		is $this->mfnode->[2] = undef, 'NULL';
		is $node->getParents->getValues->getLength, 1;

		$this->mfnode->length = 0;
		is $node->getParents->getValues->getLength, 1;
	}

	my $node = new TestNode('TestName');
	is $node->getParents->getValues->getLength, 0;

	my $mfnode = new MFNode($node);
	is $node->getParents->getValues->getLength, 1;

	is $mfnode->[0]->getValue->getParents->getValues->getLength, 2;
	is $mfnode->[0]->getValue->getParents->getKeys->getLength, 2;
	ok $mfnode->[0]->getId != $mfnode->[0]->getId;
	ok $mfnode->[0]->getValue->getId == $mfnode->[0]->getValue->getId;

	set_children( $testNode, $mfnode ) foreach 1 .. 10;
	is $node->getParents->getValues->getLength, 1;
	$mfnode = undef;

	is $node->getParents->getValues->getLength, 0;
}

print ">>>END";

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
