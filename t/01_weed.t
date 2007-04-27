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

use_ok 'Weed' for 1 .. 10;

do { use Weed } for 1 .. 10;


ok my $universum = new X3DUniversum __PACKAGE__;
printf "%s\n", $universum;

use constant X3D => new X3DUniversum __PACKAGE__;
printf "%s\n", X3D;

__END__
