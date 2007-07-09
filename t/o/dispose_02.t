#!/usr/bin/perl -w
#package dispose_02
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
	my $sfnode1 = new SFNode( new TestNode('OUT') );
	#my $sfnode2 = new SFNode();

	{
		ok my $testNode = new SFNode( new TestNode('ONE') );
		$testNode->sfnode = new TestNode('TWO');

		$sfnode1->sfnode = $testNode;
		#$sfnode2->setValue($testNode);

		sub set_children {
			my ($this) = @_;

			$this->sfnode->sfnode  = $this;
			$this->sfnode->sfnode2 = $this;
			$this->sfnode2         = $this;
		}

		set_children($testNode);

		#is $testNode->getValue->getReferenceCount, 4;
		#print $testNode;
		print "+++SUB END";
	}

	print "###BLOCK END";
	#print "$sfnode";
}

print "+++END";

1;
__END__
