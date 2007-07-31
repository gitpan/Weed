#!/usr/bin/perl -w
#package testNodeCallback1_03
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
	ok my $sfnode1 = new SFNode( new TestNode("ONE") );
	ok my $sfnode2 = new SFNode( new TestNode("TWO") );
}

1;
__END__
