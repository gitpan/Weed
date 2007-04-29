#!/usr/bin/perl -w
#package 02_mFooBah_eval
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

ok not eval qq * system qq = echo 'FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' = * ;

print "\n";

ok not eval qq * system qq = echo 'FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' 'a' 'c' 'd' = * ;

1;

__END__
