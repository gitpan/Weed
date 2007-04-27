#!/usr/bin/perl -w
#package 02_weed
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed');
}

eval { new main };
ok ($@);
 
__END__
