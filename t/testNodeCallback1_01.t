#!/usr/bin/perl -w
#package testNodeCallback1_01
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
	ok my $sfnode1 = new TestNode("ONE");

	ok not $sfnode1->set_sfstring1->getTainted;
	ok not $sfnode1->set_sfstring2->getTainted;
	ok not $sfnode1->set_sfstring3->getTainted;
	ok not $sfnode1->set_sfstring4->getTainted;
	ok not $sfnode1->getTainted;

	#$sfnode->set_sfstring1 = "one";
	#print new X3DHash($$sfnode);
	#print new X3DHash(${$sfnode->getValue});

	print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	#$sfnode->set_sfstring1 = "one";
	#$sfnode->processEvent(time);

	print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

	#$sfnode1->set_sfstring1 = "one";
	#$sfnode1->set_sfstring2 = "owt";
	$sfnode1->set_sfstring2 = "two";

	$sfnode1->prepareEvents;
	$sfnode1->processEvents;
	$sfnode1->eventsProcessed;

	#print new X3DHash($$sfnode);
	#ok not $sfnode->getTainted;
	print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

	ok not $sfnode1->set_sfstring1->getTainted;
	ok not $sfnode1->set_sfstring2->getTainted;
	ok not $sfnode1->set_sfstring3->getTainted;
	ok not $sfnode1->set_sfstring4->getTainted;
	ok not $sfnode1->getTainted;
	#ok not $sfnode1->getTainted;

}

1;
__END__

  ONE initialize
  TWO initialize
  ONE prepareEvents
  TWO prepareEvents
  ONE set_sfstring2 two
  ONE set_sfstring1 DIRECT 1185290050.0810003
  ONE set_sfstring3 set 3 von 2 1185290050.0810003
  ONE set_sfstring1 IN3 1185290050.0810003
  TWO set_sfstring2 two
  TWO set_sfstring1 DIRECT 1185290050.0810003
  TWO set_sfstring3 set 3 von 2 1185290050.0810003
  TWO set_sfstring1 IN3 1185290050.0810003
  ONE eventsProcessed
  TWO eventsProcessed
  
prepareEvents
set_sfstring2 DEF ONE_137755912 TestNode { } two 1185790648.50981
set_sfstring1 DEF ONE_137755912 TestNode { } DIRECT 1185790648.50981
set_sfstring1 DEF ONE_137755912 TestNode { } IN3 1185790648.50981
set_sfstring3 DEF ONE_137755912 TestNode { } set 3 von 1 1185790648.50981
eventsProcessed
