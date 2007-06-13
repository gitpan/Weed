#!/usr/bin/perl -w
#package 01_benchmark_2
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

ok not eval "system qq=cat '../lib/FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' 'a' 'd' 'i' >/dev/null=";

use Benchmark;
my $v;
timethis( 1, sub {
	system qq=cat '../lib/FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' 'a' 'd' 'i' >/dev/null=;
} );

system qq=cat '../lib/FooBah/ui.' | perl -M'FooBah' -I `pwd`'/../lib' -e 'new FooBah' 'a' 'd' 'i'=;

1;
__END__
