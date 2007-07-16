#!/usr/bin/perl -w
#package get_orientation_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok 1;

my $yAxis = [ 0, 1, 0 ];
my $zAxis = [ 0, 0, -1 ];

sub get_orientation0 {
	my ( $fromVec, $toVec ) = @_;
	my $distance    = $toVec - $fromVec;
	my $rA          = new X3DRotation( $zAxis, $distance );
	my $cameraUp    = $rA * $yAxis;
	my $N2          = $distance x $yAxis;
	my $N1          = $distance x $cameraUp;
	my $rB          = new X3DRotation( $N1, $N2 );
	my $orientation = $rA * $rB;
	return $orientation;
}

sub get_orientation {
	my ( $fromVec, $toVec ) = @_;
	my $distance    = $toVec - $fromVec;
	my $rA          = new SFRotation( $zAxis, $distance );
	my $cameraUp    = $rA * $yAxis;
	my $N2          = $distance x $yAxis;
	my $N1          = $distance x $cameraUp;
	my $rB          = new SFRotation( $N1, $N2 );
	my $orientation = $rA * $rB;
	return $orientation;
}

is
  get_orientation0( new X3DVec3( [ 7.31813, -0.478837, 2.46632 ] ), new X3DVec3( [ 9.31788, -4.61587, -3.85317 ] ) )->round(3),
  X3DRotation->new( [ -0.872195, -0.470245, -0.134706, 0.634677 ] )->round(3);

is
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3),
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

__END__
no warnings;
use Benchmark ':hireswallclock';
use warnings;

timethis( 1_000, sub {
		my $b = get_orientation0( new X3DVec3( [ 7.31813, -0.478837, 2.46632 ] ), new X3DVec3( [ 9.31788, -4.61587, -3.85317 ] ) )->round(3)
		  eq
		  X3DRotation->new( [ -0.872195, -0.470245, -0.134706 ], 0.634677 )->round(3);

		$b = get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3)
		  eq
		  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);
} );    #

