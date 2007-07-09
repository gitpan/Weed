#!/usr/bin/perl -w
#package dispose_03
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
	ok my $testNode = new SFNode( new TestNode('ONE') );
	$testNode->mfnode = new TestNode('TWO');

	sub set_children {
		my ($this) = @_;

		#$this->sfnode->sfnode  = $this;
		$this->mfnode->[0]->mfnode2 = $this;
	}

	set_children($testNode);

	is $testNode->getValue->getReferenceCount, 2;
	#print $testNode;
	print "+++SUB END";
}
print "***END";

1;
__END__
