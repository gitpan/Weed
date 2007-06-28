#!/usr/bin/perl -w
#package 04_node3
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed = new Weed;
isa_ok $weed, $_ foreach $weed->Weed::Package::superpath;
ok $weed ;
isa_ok $weed, $_ foreach $weed->getHierarchy;
ok $weed ;
printf "%s\n", $weed;
is $weed, "Weed { }";

X3DGenerator->tidy_fields(1);
printf "%s\n", $weed;
X3DGenerator->tidy_fields(0);
printf "%s\n", $weed;
print $_ foreach $weed->getFieldDefinitions;

1;
__END__
