#!/usr/bin/perl -w
#package 01_vers_um
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok("vers::um");
}

__END__
