#!/usr/bin/perl -w
#package weed_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed');
}

#ok eval { new main };
is Weed::Package::stringify('main'), 'main []';
 
__END__

