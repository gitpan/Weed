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

#print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
ok my $sfnode1 = new SFNode( new TestNode("ONE") );
ok my $sfnode2 = new SFNode( new TestNode("TWO") );
#$sfnode1->set_sfstring2->getCallbacks->add( $sfnode2, $sfnode2->getValue->can("set_sfstring2") );
#new X3DRoute($sfnode1, "set_sfstring2", $sfnode2, "set_sfstring2");

ok not $sfnode1->set_sfstring1->getTainted;
ok not $sfnode1->set_sfstring2->getTainted;
ok not $sfnode1->set_sfstring3->getTainted;
ok not $sfnode1->set_sfstring4->getTainted;
ok not $sfnode1->getValue->getTainted;
ok not $sfnode1->getTainted;

ok not $sfnode2->set_sfstring1->getTainted;
ok not $sfnode2->set_sfstring2->getTainted;
ok not $sfnode2->set_sfstring3->getTainted;
ok not $sfnode2->set_sfstring4->getTainted;
ok not $sfnode2->getValue->getTainted;
ok not $sfnode2->getTainted;

#$sfnode->set_sfstring1 = "one";
#print new X3DHash($$sfnode);
#print new X3DHash(${$sfnode->getValue});

print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
#$sfnode->set_sfstring1 = "one";
#$sfnode->processEvent(time);

print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

$sfnode1->set_sfstring1 = "one";
$sfnode1->set_sfstring2 = "owt";
$sfnode1->set_sfstring2 = "two";

$sfnode1->getValue->prepareEvents;
$sfnode2->getValue->prepareEvents;
$sfnode1->getValue->processEvents;
$sfnode2->getValue->processEvents;
$sfnode1->getValue->eventsProcessed;
$sfnode2->getValue->eventsProcessed;

#print new X3DHash($$sfnode);
#ok not $sfnode->getTainted;
print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

ok not $sfnode1->set_sfstring1->getTainted;
ok not $sfnode1->set_sfstring2->getTainted;
ok not $sfnode1->set_sfstring3->getTainted;
ok not $sfnode1->set_sfstring4->getTainted;
ok not $sfnode1->getValue->getTainted;
#ok not $sfnode1->getTainted;

ok not $sfnode2->set_sfstring1->getTainted;
ok not $sfnode2->set_sfstring2->getTainted;
ok not $sfnode2->set_sfstring3->getTainted;
ok not $sfnode2->set_sfstring4->getTainted;
ok not $sfnode2->getValue->getTainted;
#ok not $sfnode2->getTainted;

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
