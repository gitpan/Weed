#!/usr/bin/perl -w
#package 02_mFooBah_desktop
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

ok not eval "system qq=echo 'FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' 'a' 'd' 'i'=";

1;

__END__
