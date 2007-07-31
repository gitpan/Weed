#!/usr/bin/perl -w
#package X3DNode_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

{
	ok my $node1 = new X3DNode("node");
	#ok my $node2 = new X3DNode("node2");
}

__END__
