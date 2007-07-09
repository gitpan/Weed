#!/usr/bin/perl -w
#package memory_04
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
	}

	set_children($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END1";

{

	ok my $node = new TestNode('TestName2');
	ok my $testNode = new SFNode( $node );

	sub set_children2 {
		my ($this) = @_;

		$this->sfnode = $this;
	}

	set_children2($testNode);

	is $testNode->getValue->getReferenceCount, 4;
}

print ">>>END2";

{
	ok my $testNode = new SFNode( new TestNode('TestName3') );

	sub set_children3 {
		my ($this) = @_;

		$this->sfnode = new TestNode('TestName4');
	}

	set_children3($testNode);

	is $testNode->getValue->getReferenceCount, 2;
}

print ">>>END3";

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
