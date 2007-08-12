#!/usr/bin/perl -w
#package testNodeCallback1_04
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
	ok my $sfnode1 = new TestNode("ONE");
	ok my $sfnode2 = new TestNode("TWO");

	$sfnode1->set_mfstring = [ "one", "two" ];

	$sfnode1->prepareEvents;
	$sfnode1->processEvents;
	$sfnode1->eventsProcessed;

	$sfnode1->set_mfstring->[0] = "tree";

	$sfnode1->prepareEvents;
	$sfnode1->processEvents;
	$sfnode1->eventsProcessed;
}

1;
__END__
