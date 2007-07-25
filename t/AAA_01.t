#!/usr/bin/perl -w
#package AAA_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

warn "
# WARNING ######################################################################

This Bundle is for test purposes only! DON'T USE IT! It's in development!

################################################################################
";

__END__
