#!/usr/bin/perl -w
#package length_01
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
	is my $length = $testNode->mfnode->length, 0;
	is $testNode->mfnode->length, 0;
	
	ok tied $testNode->mfnode->length;
	is scalar $testNode->mfnode, '[ ]';

	ok $testNode->mfnode->length = 1;
	is $length = $testNode->mfnode->length, 1;
	is $testNode->mfnode->length, 1;

	ok $testNode->mfnode->length = 10;
	is $testNode->mfnode->length, 10;

	is $testNode->mfnode->length++, 10;
	is $testNode->mfnode->length++, 11;
	is $testNode->mfnode->length++, 12;
	is $testNode->mfnode->length++, 13;
	is $testNode->mfnode->length, 14;
	is ++$testNode->mfnode->length, 15;
	is ++$testNode->mfnode->length, 16;
	is ++$testNode->mfnode->length, 17;
	is ++$testNode->mfnode->length, 18;
	is $testNode->mfnode->length, 18;
	is $testNode->mfnode->length--, 18;
	is $testNode->mfnode->length--, 17;
	is $testNode->mfnode->length--, 16;
	is $testNode->mfnode->length--, 15;
	is $testNode->mfnode->length, 14;
	is --$testNode->mfnode->length, 13;
	is --$testNode->mfnode->length, 12;
	is --$testNode->mfnode->length, 11;
	is --$testNode->mfnode->length, 10;
	is $testNode->mfnode->length, 10;
	is $testNode->mfnode->length += 5, 15;
	is $testNode->mfnode->length -= 5, 10;

	ok $testNode->mfnode->length = 4;
	is $testNode->mfnode->length, 4;

	is $testNode->mfnode->length = -81, 0;
	is $testNode->mfnode->length, 0;

	sub set_children {
		my ( $this, $value, $i ) = @_;
		$this->mfnode = $value;
		$this->mfnode->[$i] = $value->[0];
		my $node = $value->[0]->getValue;
	}

	set_children( $testNode, new MFNode( new TestNode('TestName') ), $_ ) foreach 1 .. 1;

	sub set_children2 {
		my ( $this, $value, $i ) = @_;
		$this->mfnode->[$i] = $value->[0];
	}

	my $n = 10;
	set_children2( $testNode, new MFNode( new TestNode('TestName') ), $_ ) foreach 0 .. $n;
	is $testNode->mfnode->length, $n + 1;
}

print ">>>END";

__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
