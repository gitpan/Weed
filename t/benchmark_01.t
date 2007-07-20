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
	use_ok 'TestNodeFields';
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

ok my $v1 = new X3DVec3 [ 1, 2, 3 ];
ok my $v2 = new X3DVec3 [ 2, 3, 1 ];
ok my $f1 = new SFVec3d $v1;
ok my $f2 = new SFVec3d $v2;

#timethis( 200_000, sub { $v1 x $v2 } );
#timethis( 200_000, sub { $f1 x $f2 } );

ok my $v4 = new X3DVec4 [ 2, 3, 1, 4 ];
#timethis( 4_000_000, sub { $v4->length } ); #236266.98

ok my $r1 = new X3DRotation [ 2, 3, 1 ], [ 5, 4, 8 ];

#timethis( 5_000_000, sub { $r1->[0] } ); #[176180.41, 172950.54]171174.26
#timethis( 1_000_000, sub { $r1->x } );      #
#timethis( 1_000_000, sub { $r1->xx } );     #
#timethis( 1_000_000, sub { $r1->xxx } );    #

#timethis( 1_00_000, sub { $r1->x   = 4 } );    #
#timethis( 1_000_000, sub { $r1->xx  = 4 } );    #
#timethis( 1_000_000, sub { $r1->xxx = 4 } );    #

ok my $sfnode = new SFNode( new TestNode );

my $doubles = $sfnode->doubles;
$doubles->[0] = 1234567;
is $sfnode->doubles->[0], 1.2;
is $doubles->[0], 1234567;

#timethis( 1_00_000, sub { $sfnode->sfbool = YES } ); #29044.44/s
#timethis( 1_00_000, sub { $sfnode->sfbool = YES } ); #29044.44/s5913.66/s

1;
__END__
Sort::Naturally 
