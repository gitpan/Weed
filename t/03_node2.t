#!/usr/bin/perl -w
#package 03_node2
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $node1 = new X3DBaseNode;
printf "%s\n", $node1;

__END__
