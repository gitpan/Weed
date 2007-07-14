#!/usr/bin/perl -w
#package benchmark_01
use Test::More no_plan;
#use Test::Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

#no warnings;
#use Benchmark ':hireswallclock';
#use warnings;

#timethis( 10_000_000, sub { new X3DArray } );
#timethis( 100_000, sub { new X3DArray [ 1 .. 100 ] } );#6.62995

#is_faster( 10_000, sub { new X3DArray }, sub { new X3DArray [ 1 .. 100 ] } );

#my $a;
#$a = new X3DArray [ 1 .. 100 ] foreach 10_000_000;
#print $a;

#getType (new X3DArray);

ok my $v1 = new X3DVec3 [1,2,3];
ok my $v2 = new X3DVec3 [2,3,1];
ok my $f1 = new SFVec3d $v1;
ok my $f2 = new SFVec3d $v2;
#timethis( 200_000, sub { $v1 x $v2 } );
#timethis( 200_000, sub { $f1 x $f2 } );

1;
__END__
Sort::Naturally 
