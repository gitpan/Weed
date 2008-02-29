#!/usr/bin/perl -w
#package node3_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed = new WeedTest;
isa_ok $weed, $_ foreach @{ $weed->X3DPackage::getPath };
ok $weed ;
isa_ok $weed, $_ foreach @{  $weed->getHierarchy };
ok $weed ;
printf "%s\n", $weed;
is $weed, "DEF " . $weed->getName . " WeedTest { }";

X3DGenerator->setTidyFields(YES);
printf "%s\n", $weed;
X3DGenerator->setTidyFields(NO);
printf "%s\n", $weed;
print $_ foreach $weed->getFieldDefinitions;

1;
__END__
