#!/usr/bin/perl -w
#package benchmark_02
use Test::More no_plan;
#use Test::Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

no warnings;
use Benchmark ':hireswallclock';
use warnings;

my $var =  new SFInt32(32.2);
print $var;
print $var + 0.8;

#timethis( -6, sub { $var->toString1 } );
#timethis( -6, sub { $var->toString } );
#timethis( -3, sub { $int32->setValue1("xxx") } );

1;
__END__
Sort::Naturally 
