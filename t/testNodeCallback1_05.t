#!/usr/bin/perl -w
#package testNodeCallback1_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeCallback1';
}

{
	#print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	ok my $node = new TestNode("ONE");
	
	print $node;
}

1;
__END__
