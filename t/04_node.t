#!/usr/bin/perl -w
#package 04_node
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $node1 = new X3DNode;

__END__
