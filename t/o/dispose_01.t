#!/usr/bin/perl -w
#package dispose_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}


__END__

{

	ok my $testNode = new SFNode( new TestNode('TestName1') );

	sub set_children {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->mfnode = $this;
	}

	set_children($testNode);

	#is $testNode->getValue->getReferenceCount, 2;
}

print ">>>END1";

{

	ok my $node = new TestNode('TestName2');
	ok my $testNode = new SFNode( $node );

	sub set_children2 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->mfnode = $this;
	}

	set_children2($testNode);

	#is $testNode->getValue->getReferenceCount, 3;
	#is $testNode->mfnode->[0]->getValue->getReferenceCount, 4;
	is $testNode->mfnode->[0]->getValue->getId, $testNode->getValue->getId;
}

print ">>>END2";

{
	ok my $testNode = new SFNode( new TestNode('TestName3') );

	sub set_children3 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->mfnode = new TestNode('TestName4');
	}

	set_children3($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

{
	ok my $testNode = new SFNode( new TestNode('TestName5') );
	$testNode->sfnode2 = new TestNode('TestName6');

	sub set_children4 {
		my ($this) = @_;

		$this->sfnode2->sfnode = $this;
	}

	set_children4($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

{
	ok my $testNode = new SFNode( new TestNode('TestName7') );
	$testNode->sfnode2 = new TestNode('TestName8');

	sub set_children5 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->sfnode2->mfnode = $this;
	}

	set_children5($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

{
	ok my $testNode = new SFNode( new TestNode('TestName9') );
	$testNode->mfnode = new TestNode('TestName10');
#	ok my $testNode2 = new SFNode( new TestNode('TestName10') );

	sub set_children6 {
		my ($this) = @_;

		$this->mfnode->[0]->mfnode2 = $this;
	}

	set_children6($testNode);

	is $testNode->getValue->getReferenceCount, 2;
	#print $testNode;
}

print ">>>END3";
__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
