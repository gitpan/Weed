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

	ok my $testNode = new TestNode('TestName');

	sub set_children {
		my ( $this, $value ) = @_;
		is $value->getReferenceCount, 2;
		is $value->[0]->getReferenceCount, 3;
		#is $value->[0]->getValue->getReferenceCount, 4;

		is $value->[0]->getParents->getSize, 1;
		is $value->[0]->getParents->getSize, 1;

		ok $this->mfnode = $value;
		is $value->[0]->getParents->getSize, 2;

		is $value->[0]->getReferenceCount, 4;
		is $this->mfnode->[0]->getReferenceCount, 4;
		#is $value->[0]->getValue->getReferenceCount, 5;

		ok $this->mfnode->[1] = $value->[0];
		is $this->mfnode->[1]->getParents->getValues->getLength, 2;
		is $value->[0]->getParents->getValues->getLength, 2;

		ok my $node = $value->[0];
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

		is $this->mfnode->[0] = undef, undef;
		is $node->getParents->getValues->getLength, 2;

		is $this->mfnode->[1] = undef, undef;
		is $node->getParents->getValues->getLength, 2;

		is $this->mfnode->[2] = undef, undef;
		is $node->getParents->getValues->getLength, 1;

		$this->mfnode->length = 0;
		is $node->getParents->getValues->getLength, 1;
	}

	my $node = new TestNode('TestName');
	is $node->getParents->getValues->getLength, 0;

	my $mfnode = new MFNode($node);
	is $node->getParents->getValues->getLength, 1;

	is $mfnode->[0]->getParents->getValues->getLength, 1;
	is $mfnode->[0]->getParents->getKeys->getLength,   1;
	#ok $mfnode->[0]->getId != $mfnode->[0]->getId;
	ok $mfnode->[0]->getId == $mfnode->[0]->getId;

	set_children( $testNode, $mfnode ) foreach 1 .. 10;
	is $node->getParents->getValues->getLength, 1;
	$mfnode = undef;

	is $node->getParents->getValues->getLength, 0;
}

print ">>>END";

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
