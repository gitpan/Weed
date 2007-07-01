#!/usr/bin/perl -w
#package values_vector_01
use Test::More tests => 1;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed::Values::Vector');
}

__END__

