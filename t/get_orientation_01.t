#!/usr/bin/perl -w
#package get_orientation_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $yAxis = [ 0, 1, 0 ];
my $zAxis = [ 0, 0, -1 ];

sub get_orientation0 {
	my ( $fromVec, $toVec ) = @_;
	my $distance    = $toVec - $fromVec;
	my $rA          = new Weed::Values::Rotation( $zAxis, $distance );
	my $cameraUp    = $rA * $yAxis;
	my $N2          = $distance x $yAxis;
	my $N1          = $distance x $cameraUp;
	my $rB          = new Weed::Values::Rotation( $N1, $N2 );
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
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3),
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

is
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3),
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3),
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

is
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3),
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317, ) )->round(3),
  Weed::Values::Rotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

is
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( 9.31788, -4.61587, -3.85317, ) )->round(3),
  SFRotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3),
  Weed::Values::Rotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

is
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3),
  SFRotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3),
  Weed::Values::Rotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

is
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3),
  SFRotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3),
  Weed::Values::Rotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

is
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3),
  SFRotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3),
  Weed::Values::Rotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

is
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3),
  SFRotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3),
  Weed::Values::Rotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

is
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3),
  SFRotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3),
  Weed::Values::Rotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

is
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3),
  SFRotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3),
  Weed::Values::Rotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

is
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3),
  SFRotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3),
  Weed::Values::Rotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

is
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3),
  SFRotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3),
  Weed::Values::Rotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

is
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3),
  SFRotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3),
  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

is
  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3),
  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#is
#  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3),
#  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#is
#  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3),
#  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3),
  Weed::Values::Rotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

is
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3),
  SFRotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3),
  Weed::Values::Rotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

is
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3),
  SFRotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3),
  Weed::Values::Rotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

is
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3),
  SFRotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3),
  Weed::Values::Rotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

is
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3),
  SFRotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3),
  Weed::Values::Rotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

is
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3),
  SFRotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3),
  Weed::Values::Rotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

is
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3),
  SFRotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3),
  Weed::Values::Rotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

is
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3),
  SFRotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3),
  Weed::Values::Rotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

is
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3),
  SFRotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3),
  Weed::Values::Rotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

is
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3),
  SFRotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( 0.697487, -7.95348, -0.809771, ) )->round(3),
  Weed::Values::Rotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

is
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( 0.697487, -7.95348, -0.809771, ) )->round(3),
  SFRotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3),
  Weed::Values::Rotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

is
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3),
  SFRotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3),
  Weed::Values::Rotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

is
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3),
  SFRotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3),
  Weed::Values::Rotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

is
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3),
  SFRotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3),
  Weed::Values::Rotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

is
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3),
  SFRotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3),
  Weed::Values::Rotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

is
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3),
  SFRotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3),
  Weed::Values::Rotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

is
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3),
  SFRotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3),
  Weed::Values::Rotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

is
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3),
  SFRotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3),
  Weed::Values::Rotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

is
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3),
  SFRotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3),
  Weed::Values::Rotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

is
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3),
  SFRotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3),
  Weed::Values::Rotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

is
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3),
  SFRotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3),
  Weed::Values::Rotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

is
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3),
  SFRotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3),
  Weed::Values::Rotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

is
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3),
  SFRotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3),
  Weed::Values::Rotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

is
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3),
  SFRotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3),
  Weed::Values::Rotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

is
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3),
  SFRotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3),
  Weed::Values::Rotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

is
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3),
  SFRotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3),
  Weed::Values::Rotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

is
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3),
  SFRotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3),
  Weed::Values::Rotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

is
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3),
  SFRotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3),
  Weed::Values::Rotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

is
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3),
  SFRotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3),
  Weed::Values::Rotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

is
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3),
  SFRotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3),
  Weed::Values::Rotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

is
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3),
  SFRotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3),
  Weed::Values::Rotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

is
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3),
  SFRotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3),
  Weed::Values::Rotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

is
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3),
  SFRotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3),
  Weed::Values::Rotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

is
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3),
  SFRotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3),
  Weed::Values::Rotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

is
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3),
  SFRotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3),
  Weed::Values::Rotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

is
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3),
  SFRotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3),
  Weed::Values::Rotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

is
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3),
  SFRotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3),
  Weed::Values::Rotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

is
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3),
  SFRotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3),
  Weed::Values::Rotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

is
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3),
  SFRotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3),
  Weed::Values::Rotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

is
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3),
  SFRotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3),
  Weed::Values::Rotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

is
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3),
  SFRotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3),
  Weed::Values::Rotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

is
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3),
  SFRotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3),
  Weed::Values::Rotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

is
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3),
  SFRotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3),
  Weed::Values::Rotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

is
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3),
  SFRotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3),
  Weed::Values::Rotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

is
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3),
  SFRotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3),
  Weed::Values::Rotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

is
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3),
  SFRotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3),
  Weed::Values::Rotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

is
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3),
  SFRotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3),
  Weed::Values::Rotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

is
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3),
  SFRotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3),
  Weed::Values::Rotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

is
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3),
  SFRotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3),
  Weed::Values::Rotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

is
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3),
  SFRotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3),
  Weed::Values::Rotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

is
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3),
  SFRotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3),
  Weed::Values::Rotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

is
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3),
  SFRotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3),
  Weed::Values::Rotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

is
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3),
  SFRotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3),
  Weed::Values::Rotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

is
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3),
  SFRotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3),
  Weed::Values::Rotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

is
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3),
  SFRotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3),
  Weed::Values::Rotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

is
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3),
  SFRotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3),
  Weed::Values::Rotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

is
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3),
  SFRotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 7.92756, -9.77795, 5.61056, ) )->round(3),
  Weed::Values::Rotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

is
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 7.92756, -9.77795, 5.61056, ) )->round(3),
  SFRotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3),
  Weed::Values::Rotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

is
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3),
  SFRotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3),
  Weed::Values::Rotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

is
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3),
  SFRotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3),
  Weed::Values::Rotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

is
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3),
  SFRotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3),
  Weed::Values::Rotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

is
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3),
  SFRotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3),
  Weed::Values::Rotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

is
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3),
  SFRotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3),
  Weed::Values::Rotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

is
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3),
  SFRotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3),
  Weed::Values::Rotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

is
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3),
  SFRotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3),
  Weed::Values::Rotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

is
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3),
  SFRotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3),
  Weed::Values::Rotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

is
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3),
  SFRotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3),
  Weed::Values::Rotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

is
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3),
  SFRotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3),
  Weed::Values::Rotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

is
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3),
  SFRotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3),
  Weed::Values::Rotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

is
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3),
  SFRotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3),
  Weed::Values::Rotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

is
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3),
  SFRotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3),
  Weed::Values::Rotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

is
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3),
  SFRotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3),
  Weed::Values::Rotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

is
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3),
  SFRotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3),
  Weed::Values::Rotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

is
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3),
  SFRotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3),
  Weed::Values::Rotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

is
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3),
  SFRotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3),
  Weed::Values::Rotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

is
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3),
  SFRotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3),
  Weed::Values::Rotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

is
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3),
  SFRotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3),
  Weed::Values::Rotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

is
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3),
  SFRotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3),
  Weed::Values::Rotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

is
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3),
  SFRotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3),
  Weed::Values::Rotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

is
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3),
  SFRotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3),
  Weed::Values::Rotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

is
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3),
  SFRotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3),
  Weed::Values::Rotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

is
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3),
  SFRotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3),
  Weed::Values::Rotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

is
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3),
  SFRotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3),
  Weed::Values::Rotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

is
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3),
  SFRotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3),
  Weed::Values::Rotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

is
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3),
  SFRotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3),
  Weed::Values::Rotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

is
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3),
  SFRotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3),
  Weed::Values::Rotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

is
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3),
  SFRotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3),
  Weed::Values::Rotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

is
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3),
  SFRotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3),
  Weed::Values::Rotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

is
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3),
  SFRotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3),
  Weed::Values::Rotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

is
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3),
  SFRotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3),
  Weed::Values::Rotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

is
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3),
  SFRotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3),
  Weed::Values::Rotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

is
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3),
  SFRotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3),
  Weed::Values::Rotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

is
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3),
  SFRotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3),
  Weed::Values::Rotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

is
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3),
  SFRotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -9.34724, -0.350697, -2.18444, ) )->round(3),
  Weed::Values::Rotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

is
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -9.34724, -0.350697, -2.18444, ) )->round(3),
  SFRotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.39163, 8.07128, -5.01027, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3),
  Weed::Values::Rotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

is
  get_orientation( new SFVec3f( -1.39163, 8.07128, -5.01027, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3),
  SFRotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3),
  Weed::Values::Rotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

is
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3),
  SFRotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3),
  Weed::Values::Rotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

is
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3),
  SFRotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3),
  Weed::Values::Rotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

is
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3),
  SFRotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3),
  Weed::Values::Rotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

is
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3),
  SFRotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3),
  Weed::Values::Rotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

is
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3),
  SFRotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3),
  Weed::Values::Rotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

is
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3),
  SFRotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3),
  Weed::Values::Rotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

is
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3),
  SFRotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3),
  Weed::Values::Rotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

is
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3),
  SFRotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3),
  Weed::Values::Rotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

is
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3),
  SFRotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3),
  Weed::Values::Rotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

is
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3),
  SFRotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3),
  Weed::Values::Rotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

is
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3),
  SFRotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3),
  Weed::Values::Rotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

is
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3),
  SFRotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3),
  Weed::Values::Rotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

is
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3),
  SFRotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3),
  Weed::Values::Rotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

is
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3),
  SFRotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3),
  Weed::Values::Rotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

is
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3),
  SFRotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3),
  Weed::Values::Rotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

is
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3),
  SFRotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3),
  Weed::Values::Rotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

is
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3),
  SFRotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3),
  Weed::Values::Rotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

is
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3),
  SFRotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3),
  Weed::Values::Rotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

is
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3),
  SFRotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3),
  Weed::Values::Rotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

is
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3),
  SFRotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3),
  Weed::Values::Rotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

is
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3),
  SFRotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3),
  Weed::Values::Rotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

is
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3),
  SFRotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3),
  Weed::Values::Rotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

is
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3),
  SFRotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3),
  Weed::Values::Rotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

is
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3),
  SFRotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3),
  Weed::Values::Rotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

is
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3),
  SFRotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3),
  Weed::Values::Rotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

is
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3),
  SFRotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3),
  Weed::Values::Rotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

is
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3),
  SFRotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3),
  Weed::Values::Rotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

is
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3),
  SFRotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3),
  Weed::Values::Rotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

is
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3),
  SFRotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3),
  Weed::Values::Rotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

is
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3),
  SFRotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3),
  Weed::Values::Rotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

is
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3),
  SFRotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3),
  Weed::Values::Rotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

is
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3),
  SFRotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3),
  Weed::Values::Rotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

is
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3),
  SFRotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3),
  Weed::Values::Rotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

is
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3),
  SFRotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3),
  Weed::Values::Rotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

is
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3),
  SFRotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3),
  Weed::Values::Rotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

is
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3),
  SFRotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3),
  Weed::Values::Rotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

is
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3),
  SFRotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3),
  Weed::Values::Rotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

is
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3),
  SFRotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3),
  Weed::Values::Rotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

is
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3),
  SFRotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3),
  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

is
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3),
  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#is
#  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3),
#  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#is
#  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3),
#  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3),
  Weed::Values::Rotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

is
  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3),
  SFRotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3),
  Weed::Values::Rotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

is
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3),
  SFRotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3),
  Weed::Values::Rotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

is
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3),
  SFRotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3),
  Weed::Values::Rotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

is
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3),
  SFRotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3),
  Weed::Values::Rotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

is
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3),
  SFRotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3),
  Weed::Values::Rotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

is
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3),
  SFRotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3),
  Weed::Values::Rotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

is
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3),
  SFRotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3),
  Weed::Values::Rotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

is
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3),
  SFRotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3),
  Weed::Values::Rotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

is
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3),
  SFRotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3),
  Weed::Values::Rotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

is
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3),
  SFRotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3),
  Weed::Values::Rotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

is
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3),
  SFRotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3),
  Weed::Values::Rotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

is
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3),
  SFRotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3),
  Weed::Values::Rotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

is
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3),
  SFRotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3),
  Weed::Values::Rotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

is
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3),
  SFRotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3),
  Weed::Values::Rotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

is
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3),
  SFRotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3),
  Weed::Values::Rotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

is
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3),
  SFRotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( -8.04357, 8.12213, -3.6502, ) )->round(3),
  Weed::Values::Rotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

is
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( -8.04357, 8.12213, -3.6502, ) )->round(3),
  SFRotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 8.08879, -4.36993, 6.15265, ) )->round(3),
  Weed::Values::Rotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

is
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 8.08879, -4.36993, 6.15265, ) )->round(3),
  SFRotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3),
  Weed::Values::Rotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

is
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3),
  SFRotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3),
  Weed::Values::Rotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

is
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3),
  SFRotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3),
  Weed::Values::Rotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

is
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3),
  SFRotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3),
  Weed::Values::Rotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

is
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3),
  SFRotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3),
  Weed::Values::Rotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

is
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3),
  SFRotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3),
  Weed::Values::Rotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

is
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3),
  SFRotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3),
  Weed::Values::Rotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

is
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3),
  SFRotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3),
  Weed::Values::Rotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

is
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3),
  SFRotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3),
  Weed::Values::Rotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

is
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3),
  SFRotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3),
  Weed::Values::Rotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

is
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3),
  SFRotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3),
  Weed::Values::Rotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

is
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3),
  SFRotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3),
  Weed::Values::Rotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

is
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3),
  SFRotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3),
  Weed::Values::Rotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

is
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3),
  SFRotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3),
  Weed::Values::Rotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

is
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3),
  SFRotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3),
  Weed::Values::Rotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

is
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3),
  SFRotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3),
  Weed::Values::Rotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

is
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3),
  SFRotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3),
  Weed::Values::Rotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

is
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3),
  SFRotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3),
  Weed::Values::Rotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

is
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3),
  SFRotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3),
  Weed::Values::Rotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

is
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3),
  SFRotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3),
  Weed::Values::Rotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

is
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3),
  SFRotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3),
  Weed::Values::Rotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

is
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3),
  SFRotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3),
  Weed::Values::Rotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

is
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3),
  SFRotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3),
  Weed::Values::Rotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

is
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3),
  SFRotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3),
  Weed::Values::Rotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

is
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3),
  SFRotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3),
  Weed::Values::Rotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

is
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3),
  SFRotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3),
  Weed::Values::Rotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

is
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3),
  SFRotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3),
  Weed::Values::Rotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

is
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3),
  SFRotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3),
  Weed::Values::Rotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

is
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3),
  SFRotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3),
  Weed::Values::Rotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

is
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3),
  SFRotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3),
  Weed::Values::Rotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

is
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3),
  SFRotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3),
  Weed::Values::Rotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

is
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3),
  SFRotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3),
  Weed::Values::Rotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

is
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3),
  SFRotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3),
  Weed::Values::Rotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

is
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3),
  SFRotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3),
  Weed::Values::Rotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

is
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3),
  SFRotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3),
  Weed::Values::Rotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

is
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3),
  SFRotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3),
  Weed::Values::Rotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

is
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3),
  SFRotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3),
  Weed::Values::Rotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

is
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3),
  SFRotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3),
  Weed::Values::Rotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

is
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3),
  SFRotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3),
  Weed::Values::Rotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

is
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3),
  SFRotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3),
  Weed::Values::Rotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

is
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3),
  SFRotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3),
  Weed::Values::Rotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

is
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3),
  SFRotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -8.37878, -5.98755, -6.42387, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3),
  Weed::Values::Rotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

is
  get_orientation( new SFVec3f( -8.37878, -5.98755, -6.42387, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3),
  SFRotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 3.49423, -3.79675, -6.40206, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3),
  Weed::Values::Rotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

is
  get_orientation( new SFVec3f( 3.49423, -3.79675, -6.40206, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3),
  SFRotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3),
  Weed::Values::Rotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

is
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3),
  SFRotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3),
  Weed::Values::Rotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

is
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3),
  SFRotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3),
  Weed::Values::Rotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

is
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3),
  SFRotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3),
  Weed::Values::Rotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

is
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3),
  SFRotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3),
  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

is
  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3),
  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#is
#  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3),
#  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#is
#  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3),
#  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3),
  Weed::Values::Rotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

is
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3),
  SFRotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3),
  Weed::Values::Rotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

is
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3),
  SFRotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3),
  Weed::Values::Rotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

is
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3),
  SFRotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3),
  Weed::Values::Rotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

is
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3),
  SFRotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3),
  Weed::Values::Rotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

is
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3),
  SFRotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3),
  Weed::Values::Rotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

is
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3),
  SFRotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3),
  Weed::Values::Rotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

is
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3),
  SFRotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3),
  Weed::Values::Rotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

is
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3),
  SFRotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3),
  Weed::Values::Rotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

is
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3),
  SFRotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3),
  Weed::Values::Rotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

is
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3),
  SFRotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3),
  Weed::Values::Rotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

is
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3),
  SFRotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3),
  Weed::Values::Rotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

is
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3),
  SFRotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3),
  Weed::Values::Rotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

is
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3),
  SFRotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3),
  Weed::Values::Rotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

is
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3),
  SFRotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3),
  Weed::Values::Rotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

is
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3),
  SFRotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3),
  Weed::Values::Rotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

is
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3),
  SFRotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3),
  Weed::Values::Rotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

is
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3),
  SFRotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3),
  Weed::Values::Rotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

is
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3),
  SFRotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3),
  Weed::Values::Rotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

is
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3),
  SFRotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3),
  Weed::Values::Rotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

is
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3),
  SFRotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3),
  Weed::Values::Rotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

is
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3),
  SFRotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3),
  Weed::Values::Rotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

is
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3),
  SFRotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3),
  Weed::Values::Rotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

is
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3),
  SFRotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(3),
  Weed::Values::Rotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

is
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(3),
  SFRotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(3),
  Weed::Values::Rotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(3);

is
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(3),
  SFRotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3),
  Weed::Values::Rotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

is
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3),
  SFRotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3),
  Weed::Values::Rotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

is
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3),
  SFRotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3),
  Weed::Values::Rotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

is
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3),
  SFRotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3),
  Weed::Values::Rotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

is
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3),
  SFRotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3),
  Weed::Values::Rotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

is
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3),
  SFRotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

is
  get_orientation0( new Weed::Values::Vec3( 5.63912, 8.74404, 2.87949, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3),
  Weed::Values::Rotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

is
  get_orientation( new SFVec3f( 5.63912, 8.74404, 2.87949, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3),
  SFRotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3) eq
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3) eq
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3) eq
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3) eq
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

ok
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( 9.31788, -4.61587, -3.85317, ) )->round(3) eq
  SFRotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

ok
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3) eq
  SFRotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

ok
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3) eq
  SFRotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

ok
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3) eq
  SFRotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

ok
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3) eq
  SFRotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

ok
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3) eq
  SFRotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

ok
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3) eq
  SFRotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

ok
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3) eq
  SFRotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

ok
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3) eq
  SFRotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

ok
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3) eq
  SFRotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

ok
  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3) eq
  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3) eq
#  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#ok
#  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3) eq
#  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

ok
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3) eq
  SFRotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

ok
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3) eq
  SFRotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

ok
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3) eq
  SFRotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

ok
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3) eq
  SFRotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

ok
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3) eq
  SFRotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

ok
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3) eq
  SFRotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

ok
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3) eq
  SFRotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

ok
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3) eq
  SFRotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

ok
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3) eq
  SFRotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( 0.697487, -7.95348, -0.809771, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

ok
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( 0.697487, -7.95348, -0.809771, ) )->round(3) eq
  SFRotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

ok
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3) eq
  SFRotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

ok
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3) eq
  SFRotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

ok
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3) eq
  SFRotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

ok
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3) eq
  SFRotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

ok
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3) eq
  SFRotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

ok
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3) eq
  SFRotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

ok
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3) eq
  SFRotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

ok
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3) eq
  SFRotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

ok
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3) eq
  SFRotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

ok
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3) eq
  SFRotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

ok
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3) eq
  SFRotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

ok
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3) eq
  SFRotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

ok
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3) eq
  SFRotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

ok
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3) eq
  SFRotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

ok
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3) eq
  SFRotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

ok
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3) eq
  SFRotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

ok
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3) eq
  SFRotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

ok
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3) eq
  SFRotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

ok
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3) eq
  SFRotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

ok
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3) eq
  SFRotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

ok
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3) eq
  SFRotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

ok
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3) eq
  SFRotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

ok
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3) eq
  SFRotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

ok
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3) eq
  SFRotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

ok
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3) eq
  SFRotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

ok
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3) eq
  SFRotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

ok
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3) eq
  SFRotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

ok
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3) eq
  SFRotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

ok
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3) eq
  SFRotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

ok
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3) eq
  SFRotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

ok
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3) eq
  SFRotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

ok
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3) eq
  SFRotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

ok
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3) eq
  SFRotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

ok
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3) eq
  SFRotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

ok
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3) eq
  SFRotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

ok
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3) eq
  SFRotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

ok
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3) eq
  SFRotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

ok
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3) eq
  SFRotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

ok
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3) eq
  SFRotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

ok
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3) eq
  SFRotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

ok
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3) eq
  SFRotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

ok
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3) eq
  SFRotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

ok
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3) eq
  SFRotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

ok
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3) eq
  SFRotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

ok
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3) eq
  SFRotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

ok
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3) eq
  SFRotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 7.92756, -9.77795, 5.61056, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

ok
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 7.92756, -9.77795, 5.61056, ) )->round(3) eq
  SFRotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

ok
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3) eq
  SFRotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

ok
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3) eq
  SFRotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

ok
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3) eq
  SFRotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

ok
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3) eq
  SFRotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

ok
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3) eq
  SFRotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

ok
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3) eq
  SFRotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

ok
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3) eq
  SFRotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3) eq
  SFRotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3) eq
  SFRotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

ok
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3) eq
  SFRotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

ok
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3) eq
  SFRotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

ok
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3) eq
  SFRotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

ok
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3) eq
  SFRotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

ok
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3) eq
  SFRotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

ok
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3) eq
  SFRotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

ok
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3) eq
  SFRotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

ok
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3) eq
  SFRotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

ok
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3) eq
  SFRotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

ok
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3) eq
  SFRotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

ok
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3) eq
  SFRotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

ok
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3) eq
  SFRotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

ok
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3) eq
  SFRotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

ok
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3) eq
  SFRotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

ok
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3) eq
  SFRotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

ok
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3) eq
  SFRotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

ok
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3) eq
  SFRotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

ok
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3) eq
  SFRotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

ok
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3) eq
  SFRotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

ok
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3) eq
  SFRotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3) eq
  SFRotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3) eq
  SFRotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

ok
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3) eq
  SFRotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

ok
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3) eq
  SFRotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

ok
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3) eq
  SFRotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

ok
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3) eq
  SFRotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3) eq
  SFRotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -9.34724, -0.350697, -2.18444, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -9.34724, -0.350697, -2.18444, ) )->round(3) eq
  SFRotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.39163, 8.07128, -5.01027, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

ok
  get_orientation( new SFVec3f( -1.39163, 8.07128, -5.01027, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3) eq
  SFRotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

ok
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3) eq
  SFRotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

ok
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3) eq
  SFRotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

ok
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3) eq
  SFRotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

ok
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3) eq
  SFRotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

ok
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3) eq
  SFRotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

ok
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3) eq
  SFRotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

ok
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3) eq
  SFRotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

ok
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3) eq
  SFRotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

ok
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3) eq
  SFRotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

ok
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3) eq
  SFRotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

ok
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3) eq
  SFRotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

ok
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3) eq
  SFRotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

ok
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3) eq
  SFRotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

ok
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3) eq
  SFRotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

ok
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3) eq
  SFRotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

ok
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3) eq
  SFRotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

ok
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3) eq
  SFRotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

ok
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3) eq
  SFRotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

ok
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3) eq
  SFRotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

ok
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3) eq
  SFRotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

ok
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3) eq
  SFRotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

ok
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3) eq
  SFRotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

ok
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3) eq
  SFRotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

ok
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3) eq
  SFRotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

ok
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3) eq
  SFRotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

ok
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3) eq
  SFRotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

ok
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3) eq
  SFRotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

ok
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3) eq
  SFRotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

ok
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3) eq
  SFRotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

ok
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3) eq
  SFRotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

ok
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3) eq
  SFRotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

ok
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3) eq
  SFRotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3) eq
  SFRotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3) eq
  SFRotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

ok
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3) eq
  SFRotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

ok
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3) eq
  SFRotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

ok
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3) eq
  SFRotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

ok
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3) eq
  SFRotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

ok
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3) eq
  SFRotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

ok
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3) eq
  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3) eq
#  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#ok
#  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3) eq
#  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

ok
  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3) eq
  SFRotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

ok
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3) eq
  SFRotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

ok
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3) eq
  SFRotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

ok
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3) eq
  SFRotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

ok
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3) eq
  SFRotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

ok
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3) eq
  SFRotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

ok
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3) eq
  SFRotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

ok
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3) eq
  SFRotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

ok
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3) eq
  SFRotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

ok
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3) eq
  SFRotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

ok
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3) eq
  SFRotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

ok
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3) eq
  SFRotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

ok
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3) eq
  SFRotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

ok
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3) eq
  SFRotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

ok
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3) eq
  SFRotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

ok
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3) eq
  SFRotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( -8.04357, 8.12213, -3.6502, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

ok
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( -8.04357, 8.12213, -3.6502, ) )->round(3) eq
  SFRotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 8.08879, -4.36993, 6.15265, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

ok
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 8.08879, -4.36993, 6.15265, ) )->round(3) eq
  SFRotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

ok
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3) eq
  SFRotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

ok
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3) eq
  SFRotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

ok
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3) eq
  SFRotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

ok
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3) eq
  SFRotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

ok
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3) eq
  SFRotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

ok
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3) eq
  SFRotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

ok
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3) eq
  SFRotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

ok
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3) eq
  SFRotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

ok
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3) eq
  SFRotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

ok
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3) eq
  SFRotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

ok
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3) eq
  SFRotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

ok
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3) eq
  SFRotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

ok
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3) eq
  SFRotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

ok
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3) eq
  SFRotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

ok
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3) eq
  SFRotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

ok
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3) eq
  SFRotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

ok
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3) eq
  SFRotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

ok
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3) eq
  SFRotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

ok
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3) eq
  SFRotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

ok
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3) eq
  SFRotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

ok
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3) eq
  SFRotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

ok
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3) eq
  SFRotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

ok
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3) eq
  SFRotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

ok
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3) eq
  SFRotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

ok
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3) eq
  SFRotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

ok
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3) eq
  SFRotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

ok
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3) eq
  SFRotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

ok
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3) eq
  SFRotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

ok
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3) eq
  SFRotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

ok
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3) eq
  SFRotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

ok
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3) eq
  SFRotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

ok
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3) eq
  SFRotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

ok
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3) eq
  SFRotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

ok
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3) eq
  SFRotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

ok
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3) eq
  SFRotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

ok
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3) eq
  SFRotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

ok
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3) eq
  SFRotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

ok
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3) eq
  SFRotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

ok
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3) eq
  SFRotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

ok
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3) eq
  SFRotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

ok
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3) eq
  SFRotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.37878, -5.98755, -6.42387, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

ok
  get_orientation( new SFVec3f( -8.37878, -5.98755, -6.42387, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3) eq
  SFRotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.49423, -3.79675, -6.40206, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

ok
  get_orientation( new SFVec3f( 3.49423, -3.79675, -6.40206, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3) eq
  SFRotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3) eq
  SFRotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3) eq
  SFRotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

ok
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3) eq
  SFRotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

ok
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3) eq
  SFRotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

ok
  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3) eq
  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3) eq
#  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#ok
#  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3) eq
#  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

ok
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3) eq
  SFRotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

ok
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3) eq
  SFRotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

ok
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3) eq
  SFRotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

ok
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3) eq
  SFRotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

ok
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3) eq
  SFRotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

ok
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3) eq
  SFRotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

ok
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3) eq
  SFRotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

ok
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3) eq
  SFRotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

ok
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3) eq
  SFRotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

ok
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3) eq
  SFRotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

ok
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3) eq
  SFRotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

ok
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3) eq
  SFRotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

ok
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3) eq
  SFRotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

ok
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3) eq
  SFRotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

ok
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3) eq
  SFRotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

ok
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3) eq
  SFRotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

ok
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3) eq
  SFRotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

ok
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3) eq
  SFRotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

ok
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3) eq
  SFRotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

ok
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3) eq
  SFRotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

ok
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3) eq
  SFRotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

ok
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3) eq
  SFRotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

ok
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3) eq
  SFRotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

ok
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(3) eq
  SFRotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(2) eq
  Weed::Values::Rotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(2);

ok
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(2) eq
  SFRotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(2);

ok
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

ok
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3) eq
  SFRotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3) eq
  Weed::Values::Rotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

ok
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3) eq
  SFRotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

ok
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3) eq
  SFRotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

ok
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3) eq
  SFRotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

ok
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3) eq
  SFRotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.63912, 8.74404, 2.87949, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3) eq
  Weed::Values::Rotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

ok
  get_orientation( new SFVec3f( 5.63912, 8.74404, 2.87949, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3) eq
  SFRotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3) ==
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3) ==
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31813, -0.478837, 2.46632 ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317 ) )->round(3) ==
  Weed::Values::Rotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31813, -0.478837, 2.46632 ), new SFVec3f( 9.31788, -4.61587, -3.85317 ) )->round(3) ==
  SFRotation->new( -0.872195, -0.470245, -0.134706, 0.634677 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( 9.31788, -4.61587, -3.85317, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

ok
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( 9.31788, -4.61587, -3.85317, ) )->round(3) ==
  SFRotation->new( -0.696833, -0.698452, -0.163059, 0.646552 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.94955, 2.4719, 9.00915, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

ok
  get_orientation( new SFVec3f( 2.94955, 2.4719, 9.00915, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3) ==
  SFRotation->new( 0.51892, 0.83507, -0.182704, 0.798013 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( -3.13041, 6.93189, 1.44525, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

ok
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( -3.13041, 6.93189, 1.44525, ) )->round(3) ==
  SFRotation->new( 0.544336, 0.815156, -0.198039, 0.839573 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.33839, 4.14441, 5.58147, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

ok
  get_orientation( new SFVec3f( 0.33839, 4.14441, 5.58147, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3) ==
  SFRotation->new( -0.830646, -0.527734, -0.17755, 0.769671 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.16321, -2.95437, -2.95676, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

ok
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.16321, -2.95437, -2.95676, ) )->round(3) ==
  SFRotation->new( 0.0296013, 0.99418, -0.103581, 2.58795 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.80924, -4.00926, -7.20814, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

ok
  get_orientation( new SFVec3f( 6.80924, -4.00926, -7.20814, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3) ==
  SFRotation->new( 0.0287583, 0.945848, -0.323334, 2.97373 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( 4.51257, 6.06488, 5.60059, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

ok
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( 4.51257, 6.06488, 5.60059, ) )->round(3) ==
  SFRotation->new( 0.0403821, -0.996481, 0.073449, 2.1392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.85031, 3.89465, -2.24411, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

ok
  get_orientation( new SFVec3f( -7.85031, 3.89465, -2.24411, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3) ==
  SFRotation->new( -0.219684, -0.843601, -0.489975, 2.41839 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -2.71583, -8.16052, 2.33074, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

ok
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -2.71583, -8.16052, 2.33074, ) )->round(3) ==
  SFRotation->new( -0.0470098, 0.985051, 0.165725, 2.59665 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.61917, -3.98263, -7.93726, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

ok
  get_orientation( new SFVec3f( 3.61917, -3.98263, -7.93726, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3) ==
  SFRotation->new( -0.0886649, 0.981589, 0.16918, 2.19133 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( -9.61102, -9.69839, 1.21796, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

ok
  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( -9.61102, -9.69839, 1.21796, ) )->round(3) ==
  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( -5.38695, 9.95555, -0.394324, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3) ==
#  Weed::Values::Rotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

#ok
#  get_orientation( new SFVec3f( -5.38695, 9.95555, -0.394324, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3) ==
#  SFRotation->new( -0.394192, 0.719016, 0.572389, 2.22204 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 3.99776, 9.96246, -5.89588, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

ok
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 3.99776, 9.96246, -5.89588, ) )->round(3) ==
  SFRotation->new( 0.332521, -0.819801, 0.466215, 2.08339 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.65632, -0.0903497, -7.84323, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

ok
  get_orientation( new SFVec3f( -1.65632, -0.0903497, -7.84323, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3) ==
  SFRotation->new( -0.286634, -0.916071, -0.280456, 1.63662 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( 5.31232, -4.79967, -7.9951, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

ok
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( 5.31232, -4.79967, -7.9951, ) )->round(3) ==
  SFRotation->new( -0.36752, -0.917939, -0.149388, 0.833723 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.84366, 1.50491, 5.51407, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

ok
  get_orientation( new SFVec3f( -7.84366, 1.50491, 5.51407, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3) ==
  SFRotation->new( 0.604176, -0.796039, 0.0360117, 0.149486 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( -6.03655, 2.88416, -9.59016, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

ok
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( -6.03655, 2.88416, -9.59016, ) )->round(3) ==
  SFRotation->new( -0.303638, 0.947627, 0.0990323, 0.662953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.2075, 6.1974, 3.07384, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

ok
  get_orientation( new SFVec3f( 3.2075, 6.1974, 3.07384, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3) ==
  SFRotation->new( -0.460732, -0.870156, -0.1748, 0.822318 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.87283, 2.62164, -3.3177, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

ok
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.87283, 2.62164, -3.3177, ) )->round(3) ==
  SFRotation->new( 0.264192, -0.932431, 0.246525, 1.57154 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.84796, -3.48794, -2.57509, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

ok
  get_orientation( new SFVec3f( -1.84796, -3.48794, -2.57509, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3) ==
  SFRotation->new( 0.0584363, -0.993069, 0.101981, 2.10691 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( 8.50957, -0.995928, 3.49531, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

ok
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( 8.50957, -0.995928, 3.49531, ) )->round(3) ==
  SFRotation->new( 0.0905955, -0.973638, 0.209337, 2.34402 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( 0.697487, -7.95348, -0.809771, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

ok
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( 0.697487, -7.95348, -0.809771, ) )->round(3) ==
  SFRotation->new( -0.245744, 0.819374, 0.517916, 2.4 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.24733, 7.13099, -5.34138, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

ok
  get_orientation( new SFVec3f( 6.24733, 7.13099, -5.34138, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3) ==
  SFRotation->new( -0.317248, 0.915809, 0.246269, 1.40623 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -5.97558, -0.183573, -8.47015, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

ok
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -5.97558, -0.183573, -8.47015, ) )->round(3) ==
  SFRotation->new( -0.234363, 0.967918, 0.0905989, 0.759946 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.17254, 3.50808, 5.99472, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

ok
  get_orientation( new SFVec3f( 7.17254, 3.50808, 5.99472, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3) ==
  SFRotation->new( -0.282825, 0.951098, 0.124187, 0.865025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -7.69629, -1.85737, -7.67234, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

ok
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -7.69629, -1.85737, -7.67234, ) )->round(3) ==
  SFRotation->new( -0.00610433, 0.999964, 0.00582952, 1.52671 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.2443, -1.70618, -7.10102, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

ok
  get_orientation( new SFVec3f( 5.2443, -1.70618, -7.10102, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3) ==
  SFRotation->new( 0.145346, 0.914447, -0.377704, 2.46487 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( -0.162146, 6.32655, -1.11652, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

ok
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( -0.162146, 6.32655, -1.11652, ) )->round(3) ==
  SFRotation->new( 0.742073, -0.54998, 0.383209, 1.50784 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.41698, -7.80697, 1.90455, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

ok
  get_orientation( new SFVec3f( -4.41698, -7.80697, 1.90455, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3) ==
  SFRotation->new( 0.167559, -0.956512, 0.238767, 1.95925 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 7.29307, -1.17722, 6.13892, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

ok
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 7.29307, -1.17722, 6.13892, ) )->round(3) ==
  SFRotation->new( -0.0398544, -0.994795, -0.093782, 2.34166 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.88702, 2.04133, -5.6036, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

ok
  get_orientation( new SFVec3f( -4.88702, 2.04133, -5.6036, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3) ==
  SFRotation->new( 0.0515179, -0.994936, 0.0863046, 2.06973 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 9.39831, 4.87825, 2.09827, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

ok
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 9.39831, 4.87825, 2.09827, ) )->round(3) ==
  SFRotation->new( 0.139088, -0.949884, 0.279954, 2.25972 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.47201, -4.73674, -6.89923, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

ok
  get_orientation( new SFVec3f( -2.47201, -4.73674, -6.89923, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3) ==
  SFRotation->new( -0.0155436, -0.998191, -0.058077, 2.61948 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 2.77995, -5.96441, 2.20967, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

ok
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 2.77995, -5.96441, 2.20967, ) )->round(3) ==
  SFRotation->new( 0.0341222, 0.99581, -0.0848418, 2.37971 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.01929, -7.26326, -3.25029, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

ok
  get_orientation( new SFVec3f( 8.01929, -7.26326, -3.25029, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3) ==
  SFRotation->new( 0.25006, 0.827854, -0.502124, 2.3595 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( 1.73462, 7.84896, 1.49464, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

ok
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( 1.73462, 7.84896, 1.49464, ) )->round(3) ==
  SFRotation->new( 0.264937, 0.85046, -0.454451, 2.22102 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.77775, -5.97673, -3.05911, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

ok
  get_orientation( new SFVec3f( 9.77775, -5.97673, -3.05911, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3) ==
  SFRotation->new( 0.138748, 0.960742, -0.240258, 2.12851 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( -8.56271, 5.32048, 7.52436, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

ok
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( -8.56271, 5.32048, 7.52436, ) )->round(3) ==
  SFRotation->new( 0.338028, 0.867627, -0.364636, 1.78686 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.703422, -4.16595, 6.8216, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

ok
  get_orientation( new SFVec3f( 0.703422, -4.16595, 6.8216, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3) ==
  SFRotation->new( 0.353309, -0.835242, 0.421359, 1.91967 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( 5.17037, 1.97356, 7.6125, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

ok
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( 5.17037, 1.97356, 7.6125, ) )->round(3) ==
  SFRotation->new( 0.0132377, -0.854038, 0.520043, 3.09812 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.9155, -7.72245, 2.60945, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

ok
  get_orientation( new SFVec3f( 4.9155, -7.72245, 2.60945, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3) ==
  SFRotation->new( 0.577112, 0.684854, -0.444878, 1.68883 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( -1.43165, 7.02938, 0.938979, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

ok
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( -1.43165, 7.02938, 0.938979, ) )->round(3) ==
  SFRotation->new( 0.313482, -0.828555, 0.463923, 2.12081 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.92437, -4.38596, -1.67169, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

ok
  get_orientation( new SFVec3f( -7.92437, -4.38596, -1.67169, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3) ==
  SFRotation->new( 0.043766, -0.995476, 0.0843299, 2.18785 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( 1.9645, -2.32225, 5.28928, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

ok
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( 1.9645, -2.32225, 5.28928, ) )->round(3) ==
  SFRotation->new( 0.0867568, -0.985367, 0.146714, 2.08642 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.32591, -5.89861, -0.369278, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

ok
  get_orientation( new SFVec3f( -8.32591, -5.89861, -0.369278, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3) ==
  SFRotation->new( 0.358345, -0.784864, 0.505546, 2.12621 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( -2.4973, 7.70166, 1.67642, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

ok
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( -2.4973, 7.70166, 1.67642, ) )->round(3) ==
  SFRotation->new( 0.89589, 0.334091, -0.292857, 1.549 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.32417, -7.33202, 3.27907, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

ok
  get_orientation( new SFVec3f( -1.32417, -7.33202, 3.27907, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3) ==
  SFRotation->new( 0.375306, -0.797777, 0.471908, 2.01083 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 4.97572, 4.43467, 4.73465, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

ok
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 4.97572, 4.43467, 4.73465, ) )->round(3) ==
  SFRotation->new( 0.227041, -0.961168, 0.156871, 1.24653 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.38613, -0.355952, 9.78792, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

ok
  get_orientation( new SFVec3f( -8.38613, -0.355952, 9.78792, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3) ==
  SFRotation->new( 0.151901, -0.979895, 0.129355, 1.4309 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 7.04855, 3.845, 7.29743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

ok
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 7.04855, 3.845, 7.29743, ) )->round(3) ==
  SFRotation->new( -0.010834, -0.999777, -0.0181183, 2.06397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.620919, 4.10955, 3.84441, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

ok
  get_orientation( new SFVec3f( 0.620919, 4.10955, 3.84441, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3) ==
  SFRotation->new( -0.34169, -0.901367, -0.266055, 1.42496 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 6.73339, 0.032373, 2.29907, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

ok
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 6.73339, 0.032373, 2.29907, ) )->round(3) ==
  SFRotation->new( 0.541303, 0.649349, -0.534169, 1.9776 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.21314, -7.49874, 2.3187, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

ok
  get_orientation( new SFVec3f( 8.21314, -7.49874, 2.3187, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3) ==
  SFRotation->new( -0.925582, 0.376582, 0.0385253, 0.220092 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( 7.2535, -9.88645, -9.19285, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

ok
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( 7.2535, -9.88645, -9.19285, ) )->round(3) ==
  SFRotation->new( -0.839689, -0.446938, -0.308493, 1.37604 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.02688, 7.32724, -4.21703, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

ok
  get_orientation( new SFVec3f( 3.02688, 7.32724, -4.21703, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3) ==
  SFRotation->new( -0.0127691, 0.999605, 0.0250209, 2.19821 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( -5.24534, 6.81548, 1.77761, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

ok
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( -5.24534, 6.81548, 1.77761, ) )->round(3) ==
  SFRotation->new( 0.139705, -0.883006, 0.448087, 2.6043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.75714, -4.03627, -4.75459, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

ok
  get_orientation( new SFVec3f( -9.75714, -4.03627, -4.75459, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3) ==
  SFRotation->new( 0.0983077, -0.981153, 0.166354, 2.0907 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( 9.11975, 3.48735, 5.63929, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

ok
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( 9.11975, 3.48735, 5.63929, ) )->round(3) ==
  SFRotation->new( 0.227877, -0.875708, 0.425685, 2.26487 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.13132, -7.20331, 0.982446, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

ok
  get_orientation( new SFVec3f( 2.13132, -7.20331, 0.982446, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3) ==
  SFRotation->new( 0.162953, 0.965061, -0.205194, 1.83377 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( -2.72046, -4.98476, 2.11068, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

ok
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( -2.72046, -4.98476, 2.11068, ) )->round(3) ==
  SFRotation->new( -0.267978, 0.747175, 0.608209, 2.50553 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.02643, 6.09252, 0.561458, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

ok
  get_orientation( new SFVec3f( -1.02643, 6.09252, 0.561458, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3) ==
  SFRotation->new( -0.052507, -0.969174, -0.240717, 2.72492 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( 0.190017, 4.54611, 3.21716, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

ok
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( 0.190017, 4.54611, 3.21716, ) )->round(3) ==
  SFRotation->new( 0.0346113, 0.890389, -0.453884, 3.00601 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.45502, -6.94559, -5.02907, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

ok
  get_orientation( new SFVec3f( 1.45502, -6.94559, -5.02907, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3) ==
  SFRotation->new( 0.218169, 0.921125, -0.322383, 2.02675 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( -9.19738, 2.20775, -0.763121, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

ok
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( -9.19738, 2.20775, -0.763121, ) )->round(3) ==
  SFRotation->new( -0.223733, 0.935652, 0.272945, 1.83307 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.68716, 7.09199, -2.26613, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

ok
  get_orientation( new SFVec3f( -1.68716, 7.09199, -2.26613, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3) ==
  SFRotation->new( -0.222911, -0.79988, -0.557227, 2.52222 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 1.06429, -3.70713, 0.622523, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

ok
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 1.06429, -3.70713, 0.622523, ) )->round(3) ==
  SFRotation->new( 0.205075, -0.970415, 0.127434, 1.13912 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.67033, -6.60872, 5.43075, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

ok
  get_orientation( new SFVec3f( -8.67033, -6.60872, 5.43075, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3) ==
  SFRotation->new( 0.530489, -0.782089, 0.326983, 1.33491 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 4.86255, 8.74121, -1.37624, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

ok
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 4.86255, 8.74121, -1.37624, ) )->round(3) ==
  SFRotation->new( 0.428199, -0.794761, 0.430116, 1.80286 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.6023, -1.15461, -1.40512, ), new Weed::Values::Vec3( 7.92756, -9.77795, 5.61056, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

ok
  get_orientation( new SFVec3f( -1.6023, -1.15461, -1.40512, ), new SFVec3f( 7.92756, -9.77795, 5.61056, ) )->round(3) ==
  SFRotation->new( -0.154688, -0.939393, -0.305962, 2.2548 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.110874, -6.19007, -4.39067, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

ok
  get_orientation( new SFVec3f( 0.110874, -6.19007, -4.39067, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3) ==
  SFRotation->new( -0.13499, 0.978641, 0.155049, 1.73025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -5.86781, -8.15197, -3.55974, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

ok
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -5.86781, -8.15197, -3.55974, ) )->round(3) ==
  SFRotation->new( -0.57536, 0.687966, 0.442338, 1.68166 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.64823, 1.41973, -2.4375, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

ok
  get_orientation( new SFVec3f( -1.64823, 1.41973, -2.4375, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3) ==
  SFRotation->new( -0.188669, 0.905533, 0.380018, 2.2966 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( -9.99113, -9.24974, 3.89367, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

ok
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( -9.99113, -9.24974, 3.89367, ) )->round(3) ==
  SFRotation->new( -0.16105, 0.978782, 0.126687, 1.35397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.58354, -4.21794, 8.3944, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

ok
  get_orientation( new SFVec3f( 8.58354, -4.21794, 8.3944, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3) ==
  SFRotation->new( 0.79907, 0.516795, -0.307263, 1.27937 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 4.36583, 7.36078, 3.721, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

ok
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 4.36583, 7.36078, 3.721, ) )->round(3) ==
  SFRotation->new( 0.457629, -0.835738, 0.303509, 1.34162 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.75462, -1.83074, 7.99473, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

ok
  get_orientation( new SFVec3f( -5.75462, -1.83074, 7.99473, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3) ==
  SFRotation->new( 0.368209, -0.904286, 0.216077, 1.15127 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( 1.97686, 2.65777, 3.67583, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( 1.97686, 2.65777, 3.67583, ) )->round(3) ==
  SFRotation->new( -0.0473494, 0.972059, 0.229912, 2.74643 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.31186, 9.42314, -8.72724, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

ok
  get_orientation( new SFVec3f( 7.31186, 9.42314, -8.72724, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3) ==
  SFRotation->new( -0.0161772, 0.999196, 0.0366729, 2.31129 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -5.63547, 8.13454, 3.09246, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

ok
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -5.63547, 8.13454, 3.09246, ) )->round(3) ==
  SFRotation->new( 0.191769, 0.890868, -0.411799, 2.35508 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.4865, 3.29745, 0.444676, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

ok
  get_orientation( new SFVec3f( -2.4865, 3.29745, 0.444676, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3) ==
  SFRotation->new( -0.224909, 0.907275, 0.355341, 2.09905 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -9.53877, -3.92211, 3.7839, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

ok
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -9.53877, -3.92211, 3.7839, ) )->round(3) ==
  SFRotation->new( -0.779738, 0.583532, 0.226932, 0.925295 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.98881, 2.14012, 9.36612, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

ok
  get_orientation( new SFVec3f( -5.98881, 2.14012, 9.36612, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3) ==
  SFRotation->new( 0.282308, 0.958154, -0.0473598, 0.34673 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -8.3613, 2.86058, 2.49556, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

ok
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -8.3613, 2.86058, 2.49556, ) )->round(3) ==
  SFRotation->new( 0.230255, 0.958008, -0.170892, 1.31827 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.91817, -3.02189, 7.11902, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

ok
  get_orientation( new SFVec3f( 6.91817, -3.02189, 7.11902, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3) ==
  SFRotation->new( 0.436075, 0.873724, -0.215512, 1.02953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -3.93985, 4.15776, -1.18318, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

ok
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -3.93985, 4.15776, -1.18318, ) )->round(3) ==
  SFRotation->new( -0.0135731, 0.986273, 0.164563, 2.97926 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.9707, 6.18818, -7.01829, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

ok
  get_orientation( new SFVec3f( -2.9707, 6.18818, -7.01829, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3) ==
  SFRotation->new( -0.0402763, 0.962181, 0.269418, 2.85587 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -7.42379, -3.06449, 7.54277, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

ok
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -7.42379, -3.06449, 7.54277, ) )->round(3) ==
  SFRotation->new( -0.246538, 0.867739, 0.431565, 2.22117 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.02693, 9.90064, 2.56008, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

ok
  get_orientation( new SFVec3f( 1.02693, 9.90064, 2.56008, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3) ==
  SFRotation->new( -0.491883, 0.814244, 0.308315, 1.31211 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( -8.44841, 0.593256, -2.02877, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

ok
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( -8.44841, 0.593256, -2.02877, ) )->round(3) ==
  SFRotation->new( -0.957409, 0.249285, 0.145686, 1.09608 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.44537, 6.57916, 1.19077, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

ok
  get_orientation( new SFVec3f( -7.44537, 6.57916, 1.19077, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3) ==
  SFRotation->new( -0.33936, -0.922849, -0.182166, 1.05367 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( 5.18643, 0.352977, -7.18482, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

ok
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( 5.18643, 0.352977, -7.18482, ) )->round(3) ==
  SFRotation->new( 0.973425, -0.201389, 0.109029, 1.01513 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.09156, -7.22729, -2.35861, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

ok
  get_orientation( new SFVec3f( 4.09156, -7.22729, -2.35861, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3) ==
  SFRotation->new( 0.254666, 0.87961, -0.401785, 2.12438 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( -7.36426, 7.39615, 3.0477, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

ok
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( -7.36426, 7.39615, 3.0477, ) )->round(3) ==
  SFRotation->new( 0.0182534, 0.911345, -0.411238, 3.06073 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.33336, -5.78984, -8.54224, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

ok
  get_orientation( new SFVec3f( -6.33336, -5.78984, -8.54224, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3) ==
  SFRotation->new( -0.150362, -0.975113, -0.162931, 1.67608 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 3.52005, -9.18814, -7.75034, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

ok
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 3.52005, -9.18814, -7.75034, ) )->round(3) ==
  SFRotation->new( -0.78017, 0.617161, 0.102208, 0.418374 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.20328, -2.99648, 9.81518, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

ok
  get_orientation( new SFVec3f( 8.20328, -2.99648, 9.81518, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3) ==
  SFRotation->new( 0.988624, -0.145563, 0.0378726, 0.514593 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 8.68666, 0.529965, 3.51429, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

ok
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 8.68666, 0.529965, 3.51429, ) )->round(3) ==
  SFRotation->new( -0.00638977, -0.999793, -0.0192978, 2.5022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.70368, 0.981816, -5.8741, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

ok
  get_orientation( new SFVec3f( 1.70368, 0.981816, -5.8741, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3) ==
  SFRotation->new( -0.0729495, -0.96609, -0.247686, 2.58717 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 9.18668, -6.5951, 5.72745, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 9.18668, -6.5951, 5.72745, ) )->round(3) ==
  SFRotation->new( -0.601929, -0.692912, -0.396931, 1.52129 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52243, 5.76872, 8.58316, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52243, 5.76872, 8.58316, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3) ==
  SFRotation->new( -0.731305, -0.607109, -0.310825, 1.22157 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 6.6792, -2.24291, 4.57654, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

ok
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 6.6792, -2.24291, 4.57654, ) )->round(3) ==
  SFRotation->new( 0.00254715, -0.978812, 0.204748, 3.11724 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.53707, -4.74241, -1.13478, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

ok
  get_orientation( new SFVec3f( 6.53707, -4.74241, -1.13478, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3) ==
  SFRotation->new( 0.330489, 0.774731, -0.539044, 2.25471 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( 2.59875, 7.17775, 0.869727, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

ok
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( 2.59875, 7.17775, 0.869727, ) )->round(3) ==
  SFRotation->new( 0.519098, 0.725909, -0.451214, 1.75001 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.93077, -7.82244, 1.90068, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

ok
  get_orientation( new SFVec3f( 9.93077, -7.82244, 1.90068, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3) ==
  SFRotation->new( -0.0748323, 0.995692, 0.0547562, 1.26757 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -5.39847, -9.59677, -2.96489, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -5.39847, -9.59677, -2.96489, ) )->round(3) ==
  SFRotation->new( -0.0686786, -0.969684, -0.234514, 2.58821 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67144, -5.52742, -9.63457, ), new Weed::Values::Vec3( -9.34724, -0.350697, -2.18444, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67144, -5.52742, -9.63457, ), new SFVec3f( -9.34724, -0.350697, -2.18444, ) )->round(3) ==
  SFRotation->new( 0.00649776, -0.954303, 0.298769, 3.10009 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.39163, 8.07128, -5.01027, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

ok
  get_orientation( new SFVec3f( -1.39163, 8.07128, -5.01027, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3) ==
  SFRotation->new( -0.0223872, 0.978833, 0.203433, 2.92698 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( -3.90062, 3.05901, 6.25126, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

ok
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( -3.90062, 3.05901, 6.25126, ) )->round(3) ==
  SFRotation->new( -0.00414635, -0.999929, -0.0111527, 2.42989 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -7.81961, 3.19287, 1.70791, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

ok
  get_orientation( new SFVec3f( -7.81961, 3.19287, 1.70791, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3) ==
  SFRotation->new( 0.0562431, -0.99682, 0.0564446, 1.57757 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( 4.43862, 4.58559, 1.75188, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

ok
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( 4.43862, 4.58559, 1.75188, ) )->round(3) ==
  SFRotation->new( 0.494151, -0.777925, 0.388134, 1.58043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.05489, -8.39714, 4.06682, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

ok
  get_orientation( new SFVec3f( -5.05489, -8.39714, 4.06682, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3) ==
  SFRotation->new( 0.988366, -0.149169, 0.0296887, 0.397545 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( -4.71204, -6.02964, -1.63302, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

ok
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( -4.71204, -6.02964, -1.63302, ) )->round(3) ==
  SFRotation->new( -0.584972, 0.720261, 0.372871, 1.44891 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.4898, 9.88849, 3.11805, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

ok
  get_orientation( new SFVec3f( 5.4898, 9.88849, 3.11805, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3) ==
  SFRotation->new( -0.64996, -0.604658, -0.46037, 1.72835 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.62048, -5.97539, 1.66505, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

ok
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.62048, -5.97539, 1.66505, ) )->round(3) ==
  SFRotation->new( -0.210259, -0.963553, -0.165398, 1.36931 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.34824, -0.891259, 5.04972, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

ok
  get_orientation( new SFVec3f( -4.34824, -0.891259, 5.04972, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3) ==
  SFRotation->new( -0.200302, -0.966667, -0.159478, 1.37799 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 9.7536, -5.79919, 1.80776, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

ok
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 9.7536, -5.79919, 1.80776, ) )->round(3) ==
  SFRotation->new( -0.206565, -0.954065, -0.217005, 1.66697 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.7138, 0.188988, 1.19284, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

ok
  get_orientation( new SFVec3f( -2.7138, 0.188988, 1.19284, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3) ==
  SFRotation->new( 0.519708, -0.823, 0.229292, 0.984189 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 5.24689, 6.69991, -6.07278, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

ok
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 5.24689, 6.69991, -6.07278, ) )->round(3) ==
  SFRotation->new( -0.10181, -0.992192, -0.0720367, 1.23896 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.56796, 8.06444, -2.96225, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

ok
  get_orientation( new SFVec3f( -3.56796, 8.06444, -2.96225, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3) ==
  SFRotation->new( -0.391588, -0.890746, -0.230718, 1.16877 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 7.07041, 1.31102, -8.85627, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

ok
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 7.07041, 1.31102, -8.85627, ) )->round(3) ==
  SFRotation->new( 0.23851, -0.964081, 0.116879, 0.940524 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.56306, -3.86835, 4.03981, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

ok
  get_orientation( new SFVec3f( -9.56306, -3.86835, 4.03981, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3) ==
  SFRotation->new( 0.161342, -0.984107, 0.0741783, 0.874128 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 6.3409, -0.691718, -9.5995, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

ok
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 6.3409, -0.691718, -9.5995, ) )->round(3) ==
  SFRotation->new( -0.0647566, -0.997321, -0.0340348, 0.970171 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.61223, 0.0510931, -3.43697, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

ok
  get_orientation( new SFVec3f( -2.61223, 0.0510931, -3.43697, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3) ==
  SFRotation->new( 0.0400079, -0.993039, 0.11078, 2.4529 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 8.20602, 3.87624, 9.58713, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

ok
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 8.20602, 3.87624, 9.58713, ) )->round(3) ==
  SFRotation->new( 0.146577, -0.956737, 0.251335, 2.12372 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.25581, -6.79768, 0.273836, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

ok
  get_orientation( new SFVec3f( -8.25581, -6.79768, 0.273836, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3) ==
  SFRotation->new( 0.141465, -0.976613, 0.161912, 1.7288 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( 7.88208, -1.24525, 2.45913, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

ok
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( 7.88208, -1.24525, 2.45913, ) )->round(3) ==
  SFRotation->new( -0.0113417, -0.944898, -0.327169, 3.0761 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.12698, 7.33439, -8.41881, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

ok
  get_orientation( new SFVec3f( 7.12698, 7.33439, -8.41881, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3) ==
  SFRotation->new( -0.227797, 0.908738, 0.34972, 2.07267 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( -7.74951, -7.36041, -1.8445, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

ok
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( -7.74951, -7.36041, -1.8445, ) )->round(3) ==
  SFRotation->new( -0.0162493, -0.809824, -0.586448, 3.09672 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.05284, 9.32176, -7.31392, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

ok
  get_orientation( new SFVec3f( -8.05284, 9.32176, -7.31392, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3) ==
  SFRotation->new( -0.0761149, -0.953175, -0.292683, 2.65562 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( 0.561315, -2.66757, 8.1279, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

ok
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( 0.561315, -2.66757, 8.1279, ) )->round(3) ==
  SFRotation->new( -0.137958, 0.934183, 0.329044, 2.39498 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.58841, 7.51208, -0.744978, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

ok
  get_orientation( new SFVec3f( 9.58841, 7.51208, -0.744978, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3) ==
  SFRotation->new( -0.177264, 0.949293, 0.259656, 1.99156 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -3.61281, -0.869268, 4.4174, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

ok
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -3.61281, -0.869268, 4.4174, ) )->round(3) ==
  SFRotation->new( 0.0213281, 0.981468, -0.190433, 2.92263 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.77459, -6.04274, -8.09451, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

ok
  get_orientation( new SFVec3f( -0.77459, -6.04274, -8.09451, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3) ==
  SFRotation->new( 0.108435, 0.962928, -0.247004, 2.3417 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( -9.33963, 0.346831, -0.219429, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

ok
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( -9.33963, 0.346831, -0.219429, ) )->round(3) ==
  SFRotation->new( 0.0378908, 0.953164, -0.300073, 2.90203 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.43698, -2.19104, -3.73667, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

ok
  get_orientation( new SFVec3f( -8.43698, -2.19104, -3.73667, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3) ==
  SFRotation->new( 0.121138, -0.94984, 0.28832, 2.38217 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( 3.99328, 9.44703, 8.4446, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

ok
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( 3.99328, 9.44703, 8.4446, ) )->round(3) ==
  SFRotation->new( 0.00717912, 0.968161, -0.250227, 3.08605 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.74038, 2.22924, -4.5645, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

ok
  get_orientation( new SFVec3f( 4.74038, 2.22924, -4.5645, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3) ==
  SFRotation->new( -0.0685219, 0.995964, 0.057962, 1.40822 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -6.95266, 0.844436, -6.53043, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

ok
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -6.95266, 0.844436, -6.53043, ) )->round(3) ==
  SFRotation->new( -0.727908, 0.671833, 0.13708, 0.546596 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.27528, 5.14927, 2.88677, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

ok
  get_orientation( new SFVec3f( -3.27528, 5.14927, 2.88677, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3) ==
  SFRotation->new( 0.842401, -0.522685, 0.130999, 0.578356 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -1.06686, 9.03894, -4.04218, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -1.06686, 9.03894, -4.04218, ) )->round(3) ==
  SFRotation->new( 0.131526, 0.901501, -0.412307, 2.58155 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.52153, 1.87138, -9.09428, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

ok
  get_orientation( new SFVec3f( 2.52153, 1.87138, -9.09428, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3) ==
  SFRotation->new( -0.0161247, 0.980516, 0.195779, 2.98043 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -0.107691, -4.81225, 6.75872, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

ok
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -0.107691, -4.81225, 6.75872, ) )->round(3) ==
  SFRotation->new( 0.0142759, -0.99861, 0.0507458, 2.59386 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.31026, -5.43816, 1.51711, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

ok
  get_orientation( new SFVec3f( -3.31026, -5.43816, 1.51711, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3) ==
  SFRotation->new( 0.845516, 0.472968, -0.2478, 1.10949 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -8.84112, 9.36081, -7.10831, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

ok
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -8.84112, 9.36081, -7.10831, ) )->round(3) ==
  SFRotation->new( 0.475854, 0.729151, -0.491835, 1.91283 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.35181, -4.23433, -7.28966, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

ok
  get_orientation( new SFVec3f( -3.35181, -4.23433, -7.28966, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3) ==
  SFRotation->new( 0.117509, 0.859608, -0.497258, 2.74077 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( -6.8041, 9.17583, -0.393141, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

ok
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( -6.8041, 9.17583, -0.393141, ) )->round(3) ==
  SFRotation->new( 0.0832207, -0.955261, 0.283814, 2.59538 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.79379, 6.77448, -3.49424, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

ok
  get_orientation( new SFVec3f( -8.79379, 6.77448, -3.49424, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3) ==
  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 7.6579, 9.14278, -8.28262, ) )->round(3) ==
#  Weed::Values::Rotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

#ok
#  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 7.6579, 9.14278, -8.28262, ) )->round(3) ==
#  SFRotation->new( 0.0910605, -0.993498, 0.0683362, 1.29383 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.19769, 9.51228, 8.41192, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

ok
  get_orientation( new SFVec3f( 6.19769, 9.51228, 8.41192, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3) ==
  SFRotation->new( -0.998138, -0.0517742, -0.0322596, 1.11613 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( 6.58667, -2.75846, 2.40087, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

ok
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( 6.58667, -2.75846, 2.40087, ) )->round(3) ==
  SFRotation->new( -0.0439485, 0.902014, 0.429463, 2.9575 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.03219, 6.02952, -4.58797, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

ok
  get_orientation( new SFVec3f( 8.03219, 6.02952, -4.58797, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3) ==
  SFRotation->new( -0.142967, 0.939336, 0.311782, 2.32816 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -6.41193, -8.19082, 7.85022, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

ok
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -6.41193, -8.19082, 7.85022, ) )->round(3) ==
  SFRotation->new( -0.00316849, 0.999949, 0.0096006, 2.50441 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 2.82492, -7.89265, -4.62834, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

ok
  get_orientation( new SFVec3f( 2.82492, -7.89265, -4.62834, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3) ==
  SFRotation->new( 0.152053, 0.921598, -0.357122, 2.39373 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( -8.91853, 6.96352, 6.66232, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

ok
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( -8.91853, 6.96352, 6.66232, ) )->round(3) ==
  SFRotation->new( 0.134902, 0.946081, -0.294502, 2.32372 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 8.39294, -8.79632, -8.269, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

ok
  get_orientation( new SFVec3f( 8.39294, -8.79632, -8.269, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3) ==
  SFRotation->new( 0.0441751, 0.985328, -0.164857, 2.62532 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 1.11719, -3.78697, 4.33241, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

ok
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 1.11719, -3.78697, 4.33241, ) )->round(3) ==
  SFRotation->new( -0.704298, 0.621533, 0.343018, 1.32933 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.10785, 8.29012, 9.0237, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

ok
  get_orientation( new SFVec3f( 7.10785, 8.29012, 9.0237, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3) ==
  SFRotation->new( -0.0558926, 0.997524, 0.0426884, 1.30688 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( 0.616444, 7.71318, 7.2529, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

ok
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( 0.616444, 7.71318, 7.2529, ) )->round(3) ==
  SFRotation->new( 0.0677103, -0.93454, 0.349356, 2.78322 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.88529, -2.75939, -3.92437, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

ok
  get_orientation( new SFVec3f( -3.88529, -2.75939, -3.92437, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3) ==
  SFRotation->new( 0.653753, -0.676758, 0.338533, 1.30627 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( -1.96621, 0.376156, -5.28049, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

ok
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( -1.96621, 0.376156, -5.28049, ) )->round(3) ==
  SFRotation->new( -0.237448, 0.963993, 0.119732, 0.963886 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.93838, 3.48409, 2.04347, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

ok
  get_orientation( new SFVec3f( 7.93838, 3.48409, 2.04347, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3) ==
  SFRotation->new( 0.66101, 0.705189, -0.256465, 1.00598 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 6.1442, 5.71399, 0.0793682, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

ok
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 6.1442, 5.71399, 0.0793682, ) )->round(3) ==
  SFRotation->new( -0.134377, -0.970356, -0.200878, 1.99009 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.38525, 9.7058, -3.44305, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

ok
  get_orientation( new SFVec3f( -2.38525, 9.7058, -3.44305, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3) ==
  SFRotation->new( -0.135704, -0.977758, -0.159915, 1.75638 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( 4.62251, 7.31871, -2.28743, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

ok
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( 4.62251, 7.31871, -2.28743, ) )->round(3) ==
  SFRotation->new( 0.606093, -0.756336, 0.246185, 0.985681 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.74298, -3.50489, 8.36699, ), new Weed::Values::Vec3( -8.04357, 8.12213, -3.6502, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

ok
  get_orientation( new SFVec3f( -5.74298, -3.50489, 8.36699, ), new SFVec3f( -8.04357, 8.12213, -3.6502, ) )->round(3) ==
  SFRotation->new( 0.968813, 0.230123, -0.0919021, 0.781984 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 8.08879, -4.36993, 6.15265, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

ok
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 8.08879, -4.36993, 6.15265, ) )->round(3) ==
  SFRotation->new( -0.019659, -0.99089, -0.133234, 2.85123 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.12762, -0.613771, -6.978, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

ok
  get_orientation( new SFVec3f( 4.12762, -0.613771, -6.978, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3) ==
  SFRotation->new( 0.0445495, -0.937592, 0.344873, 2.90054 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( 5.69153, 4.62215, -1.02564, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

ok
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( 5.69153, 4.62215, -1.02564, ) )->round(3) ==
  SFRotation->new( -0.11882, -0.991522, -0.0525926, 0.839731 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.75485, 6.12348, 8.46288, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

ok
  get_orientation( new SFVec3f( -4.75485, 6.12348, 8.46288, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3) ==
  SFRotation->new( -0.999911, -0.0114188, -0.00690872, 1.08953 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( -4.64723, -8.75559, 0.691969, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

ok
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( -4.64723, -8.75559, 0.691969, ) )->round(3) ==
  SFRotation->new( -0.495755, 0.813796, 0.303255, 1.28913 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.16072, 1.75111, 6.22066, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

ok
  get_orientation( new SFVec3f( 6.16072, 1.75111, 6.22066, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3) ==
  SFRotation->new( 0.969728, -0.202494, 0.13647, 1.2147 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( 6.88618, 8.24249, 3.69422, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

ok
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( 6.88618, 8.24249, 3.69422, ) )->round(3) ==
  SFRotation->new( 0.356927, -0.902925, 0.239437, 1.27795 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.64028, 4.3916, 6.25459, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

ok
  get_orientation( new SFVec3f( 0.64028, 4.3916, 6.25459, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3) ==
  SFRotation->new( -0.395384, 0.795396, 0.459365, 1.94095 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( -7.16479, -9.28806, 7.42967, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

ok
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( -7.16479, -9.28806, 7.42967, ) )->round(3) ==
  SFRotation->new( 0.000312417, 0.999999, -0.00145681, 2.72826 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.034547, -9.33983, -8.82731, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

ok
  get_orientation( new SFVec3f( -0.034547, -9.33983, -8.82731, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3) ==
  SFRotation->new( 0.0788374, -0.712112, 0.697626, 2.98099 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 0.0497737, 9.04296, -8.459, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

ok
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 0.0497737, 9.04296, -8.459, ) )->round(3) ==
  SFRotation->new( 0.824808, 0.525873, -0.207726, 0.893276 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.8572, 1.5183, -1.3795, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

ok
  get_orientation( new SFVec3f( 3.8572, 1.5183, -1.3795, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3) ==
  SFRotation->new( -0.129862, -0.990911, -0.03508, 0.532247 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 7.23407, 1.04287, -7.1743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

ok
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 7.23407, 1.04287, -7.1743, ) )->round(3) ==
  SFRotation->new( -0.332967, -0.920724, -0.203472, 1.1719 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -4.5953, 7.21995, -1.10976, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

ok
  get_orientation( new SFVec3f( -4.5953, 7.21995, -1.10976, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3) ==
  SFRotation->new( -0.506259, -0.815228, -0.281257, 1.19637 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( 5.08139, -1.70654, -7.13072, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

ok
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( 5.08139, -1.70654, -7.13072, ) )->round(3) ==
  SFRotation->new( -0.641271, -0.742977, -0.191722, 0.765142 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.2265, 8.67695, 8.5673, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

ok
  get_orientation( new SFVec3f( -5.2265, 8.67695, 8.5673, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3) ==
  SFRotation->new( -0.220439, -0.931559, -0.289144, 1.9065 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -2.01102, 6.38627, 9.4504, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

ok
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -2.01102, 6.38627, 9.4504, ) )->round(3) ==
  SFRotation->new( 0.297836, 0.768499, -0.566307, 2.3734 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.85668, -8.75277, 6.79042, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

ok
  get_orientation( new SFVec3f( 1.85668, -8.75277, 6.79042, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3) ==
  SFRotation->new( 0.142874, 0.988403, -0.0514506, 0.698901 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.59926, -7.53191, -2.21714, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

ok
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.59926, -7.53191, -2.21714, ) )->round(3) ==
  SFRotation->new( -0.601138, 0.774299, 0.197724, 0.803392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 1.17958, -1.29285, 6.97281, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

ok
  get_orientation( new SFVec3f( 1.17958, -1.29285, 6.97281, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3) ==
  SFRotation->new( -0.396524, 0.873153, 0.283501, 1.37224 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( -5.92202, -6.74077, 4.54512, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

ok
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( -5.92202, -6.74077, 4.54512, ) )->round(3) ==
  SFRotation->new( -0.082612, 0.947534, 0.308794, 2.64506 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.636787, 2.83796, -6.83556, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

ok
  get_orientation( new SFVec3f( 0.636787, 2.83796, -6.83556, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3) ==
  SFRotation->new( -0.00263001, -0.99987, -0.0159055, 2.81392 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 3.50376, 2.55451, 1.59743, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

ok
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 3.50376, 2.55451, 1.59743, ) )->round(3) ==
  SFRotation->new( -0.0556002, -0.972788, -0.224925, 2.66962 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.170631, 6.40739, -5.38061, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

ok
  get_orientation( new SFVec3f( -0.170631, 6.40739, -5.38061, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3) ==
  SFRotation->new( -0.427996, -0.849352, -0.308903, 1.40871 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 9.58133, -2.20582, -8.61723, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

ok
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 9.58133, -2.20582, -8.61723, ) )->round(3) ==
  SFRotation->new( 0.183264, -0.979606, 0.0823819, 0.86045 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.88, -5.93408, 5.9921, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

ok
  get_orientation( new SFVec3f( -6.88, -5.93408, 5.9921, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3) ==
  SFRotation->new( 0.624142, -0.758737, 0.186452, 0.750165 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( 2.12228, 2.65052, -7.73078, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

ok
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( 2.12228, 2.65052, -7.73078, ) )->round(3) ==
  SFRotation->new( 0.0158401, 0.99979, -0.0129847, 1.37368 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.70859, 2.44951, -6.21407, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

ok
  get_orientation( new SFVec3f( 9.70859, 2.44951, -6.21407, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3) ==
  SFRotation->new( -0.272336, 0.940545, 0.203, 1.34033 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -1.39494, -2.79624, -9.5238, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

ok
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -1.39494, -2.79624, -9.5238, ) )->round(3) ==
  SFRotation->new( 0.250544, 0.964863, -0.079166, 0.632983 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.16526, -5.83262, 5.51729, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

ok
  get_orientation( new SFVec3f( 9.16526, -5.83262, 5.51729, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3) ==
  SFRotation->new( 0.275342, 0.933019, -0.231652, 1.46754 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( -7.47256, 3.10362, 2.62838, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

ok
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( -7.47256, 3.10362, 2.62838, ) )->round(3) ==
  SFRotation->new( 0.00529299, -0.999703, 0.0237959, 2.70402 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.50878, 2.87479, -1.72279, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

ok
  get_orientation( new SFVec3f( -9.50878, 2.87479, -1.72279, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3) ==
  SFRotation->new( -0.0734476, -0.994904, -0.0690809, 1.51464 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( 7.52023, 0.49406, -2.76723, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

ok
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( 7.52023, 0.49406, -2.76723, ) )->round(3) ==
  SFRotation->new( -0.0411376, -0.997035, -0.0650347, 2.01627 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.0997, 1.74393, -6.85476, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

ok
  get_orientation( new SFVec3f( -1.0997, 1.74393, -6.85476, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3) ==
  SFRotation->new( 0.0139696, 0.999496, -0.0284894, 2.23025 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -7.68219, 2.21898, -1.75597, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

ok
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -7.68219, 2.21898, -1.75597, ) )->round(3) ==
  SFRotation->new( 0.0930797, 0.843331, -0.529272, 2.84712 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.45084, -5.25506, -5.14856, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

ok
  get_orientation( new SFVec3f( -6.45084, -5.25506, -5.14856, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3) ==
  SFRotation->new( 0.03516, 0.933553, -0.356712, 2.95807 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.28784, 3.16469, 4.07947, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

ok
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.28784, 3.16469, 4.07947, ) )->round(3) ==
  SFRotation->new( -0.140331, 0.970799, 0.19457, 1.91991 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.2575, 9.56636, -0.758833, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

ok
  get_orientation( new SFVec3f( 6.2575, 9.56636, -0.758833, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3) ==
  SFRotation->new( -0.164301, 0.981393, 0.0993606, 1.10451 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( -8.29153, 6.20536, -8.38859, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

ok
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( -8.29153, 6.20536, -8.38859, ) )->round(3) ==
  SFRotation->new( -0.200569, 0.977743, 0.0615753, 0.6085 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 4.14991, 9.00921, 9.96384, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

ok
  get_orientation( new SFVec3f( 4.14991, 9.00921, 9.96384, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3) ==
  SFRotation->new( -0.993863, -0.102046, -0.0426989, 0.797076 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 5.14694, -2.78439, -1.61635, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

ok
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 5.14694, -2.78439, -1.61635, ) )->round(3) ==
  SFRotation->new( -0.328998, -0.935262, -0.130561, 0.802595 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -5.14186, 1.48818, 9.30504, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

ok
  get_orientation( new SFVec3f( -5.14186, 1.48818, 9.30504, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3) ==
  SFRotation->new( 0.297309, -0.927795, 0.225397, 1.37019 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -8.37878, -5.98755, -6.42387, ), new Weed::Values::Vec3( 9.88843, 9.54854, 5.08964, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

ok
  get_orientation( new SFVec3f( -8.37878, -5.98755, -6.42387, ), new SFVec3f( 9.88843, 9.54854, 5.08964, ) )->round(3) ==
  SFRotation->new( 0.166918, -0.938416, 0.302513, 2.18603 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 3.49423, -3.79675, -6.40206, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

ok
  get_orientation( new SFVec3f( 3.49423, -3.79675, -6.40206, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3) ==
  SFRotation->new( 0.116267, 0.933877, -0.338165, 2.52022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -5.94271, 8.99432, 5.69944, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -5.94271, 8.99432, 5.69944, ) )->round(3) ==
  SFRotation->new( -0.0097193, -0.998942, -0.0449485, 2.71612 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.67909, 9.80984, -2.53636, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

ok
  get_orientation( new SFVec3f( -9.67909, 9.80984, -2.53636, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3) ==
  SFRotation->new( -0.636117, -0.594418, -0.491958, 1.83099 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( -7.16887, -3.81766, -3.18858, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

ok
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( -7.16887, -3.81766, -3.18858, ) )->round(3) ==
  SFRotation->new( -0.253029, 0.942629, 0.217778, 1.47997 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 7.44768, 3.3974, -0.987402, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

ok
  get_orientation( new SFVec3f( 7.44768, 3.3974, -0.987402, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3) ==
  SFRotation->new( -0.760074, 0.611915, 0.218744, 0.879237 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 2.07464, -4.88815, -9.54918, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

ok
  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 2.07464, -4.88815, -9.54918, ) )->round(3) ==
  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#ok
#  get_orientation0( new Weed::Values::Vec3( -0.212805, 2.25209, 9.53048, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3) ==
#  Weed::Values::Rotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

#ok
#  get_orientation( new SFVec3f( -0.212805, 2.25209, 9.53048, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3) ==
#  SFRotation->new( -0.947474, -0.314788, -0.0565861, 0.375038 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 0.0768747, -3.65617, -4.07584, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

ok
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 0.0768747, -3.65617, -4.07584, ) )->round(3) ==
  SFRotation->new( -0.99589, -0.0858968, -0.0287171, 0.647933 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.545635, 4.47647, 6.7058, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

ok
  get_orientation( new SFVec3f( -0.545635, 4.47647, 6.7058, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3) ==
  SFRotation->new( 0.299528, -0.93667, 0.181471, 1.14827 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 8.26102, 8.47652, 2.10566, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

ok
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 8.26102, 8.47652, 2.10566, ) )->round(3) ==
  SFRotation->new( 0.0715627, -0.99046, 0.117763, 2.05798 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.10054, 5.389, -3.79051, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

ok
  get_orientation( new SFVec3f( -3.10054, 5.389, -3.79051, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3) ==
  SFRotation->new( -0.0348367, -0.98562, -0.165348, 2.7321 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 1.92906, 1.08528, 7.61582, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

ok
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 1.92906, 1.08528, 7.61582, ) )->round(3) ==
  SFRotation->new( 0.222523, -0.92467, 0.308982, 1.96661 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -9.18255, -7.72854, 3.90252, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

ok
  get_orientation( new SFVec3f( -9.18255, -7.72854, 3.90252, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3) ==
  SFRotation->new( 0.0472984, -0.997249, 0.0570695, 1.76022 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( 4.02459, -6.18513, 6.39757, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

ok
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( 4.02459, -6.18513, 6.39757, ) )->round(3) ==
  SFRotation->new( -0.0267763, -0.993645, -0.109327, 2.66415 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -2.97794, -2.80976, -7.04058, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

ok
  get_orientation( new SFVec3f( -2.97794, -2.80976, -7.04058, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3) ==
  SFRotation->new( -0.00429283, 0.963712, 0.266911, 3.1106 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( -3.24442, -7.7812, 1.24166, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

ok
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( -3.24442, -7.7812, 1.24166, ) )->round(3) ==
  SFRotation->new( -0.0354301, 0.94652, 0.320695, 2.93321 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.744699, 0.984711, -9.93329, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

ok
  get_orientation( new SFVec3f( -0.744699, 0.984711, -9.93329, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3) ==
  SFRotation->new( -0.186628, -0.920212, -0.344063, 2.21566 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 2.22637, -2.09657, -8.00039, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

ok
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 2.22637, -2.09657, -8.00039, ) )->round(3) ==
  SFRotation->new( -0.842262, -0.533602, -0.0765773, 0.337541 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 0.286256, 1.05604, 2.58063, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

ok
  get_orientation( new SFVec3f( 0.286256, 1.05604, 2.58063, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3) ==
  SFRotation->new( 0.260168, -0.935033, 0.240886, 1.56097 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( 8.82505, 5.78237, 1.92249, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

ok
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( 8.82505, 5.78237, 1.92249, ) )->round(3) ==
  SFRotation->new( 0.0861721, -0.994734, 0.0554855, 1.14893 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -0.498599, 4.63625, 6.16104, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

ok
  get_orientation( new SFVec3f( -0.498599, 4.63625, 6.16104, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3) ==
  SFRotation->new( -0.813591, 0.533629, 0.230889, 0.977542 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( -4.04151, -2.54479, 0.42161, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

ok
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( -4.04151, -2.54479, 0.42161, ) )->round(3) ==
  SFRotation->new( -0.00328994, 0.996935, 0.0781644, 3.05772 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -3.19843, -0.961783, -9.57598, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

ok
  get_orientation( new SFVec3f( -3.19843, -0.961783, -9.57598, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3) ==
  SFRotation->new( 0.0914303, -0.940854, 0.326243, 2.62598 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( 2.71454, 8.00731, 0.144857, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

ok
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( 2.71454, 8.00731, 0.144857, ) )->round(3) ==
  SFRotation->new( 0.531796, -0.740917, 0.410164, 1.61095 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.26197, -6.80895, 2.50238, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

ok
  get_orientation( new SFVec3f( -6.26197, -6.80895, 2.50238, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3) ==
  SFRotation->new( 0.998547, -0.0521437, 0.013567, 0.51019 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -6.00675, -1.56541, -6.87977, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

ok
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -6.00675, -1.56541, -6.87977, ) )->round(3) ==
  SFRotation->new( -0.0180786, 0.999814, 0.00677301, 0.722894 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.61652, -1.30482, 7.43261, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

ok
  get_orientation( new SFVec3f( 6.61652, -1.30482, 7.43261, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3) ==
  SFRotation->new( 0.0647167, 0.995487, -0.0694094, 1.64525 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -5.64508, 0.417597, 8.2916, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

ok
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -5.64508, 0.417597, 8.2916, ) )->round(3) ==
  SFRotation->new( 0.218318, 0.938317, -0.26814, 1.83683 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.38716, -7.22953, 5.80082, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

ok
  get_orientation( new SFVec3f( 6.38716, -7.22953, 5.80082, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3) ==
  SFRotation->new( -0.291925, 0.954657, 0.0583995, 0.413261 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( -0.010172, -9.27173, -9.54297, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

ok
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( -0.010172, -9.27173, -9.54297, ) )->round(3) ==
  SFRotation->new( -0.87083, -0.464759, -0.160167, 0.75366 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -6.42891, 4.83779, 7.31613, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

ok
  get_orientation( new SFVec3f( -6.42891, 4.83779, 7.31613, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(3) ==
  SFRotation->new( -0.0685958, -0.997153, -0.0313253, 0.859322 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 3.46657, 4.01421, -1.25199, ) )->round(2) ==
  Weed::Values::Rotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(2);

ok
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 3.46657, 4.01421, -1.25199, ) )->round(2) ==
  SFRotation->new( 0.0783284, -0.962433, 0.259976, 2.57713 )->round(2);

ok
  get_orientation0( new Weed::Values::Vec3( -1.26113, -0.973091, -8.38551, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

ok
  get_orientation( new SFVec3f( -1.26113, -0.973091, -8.38551, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3) ==
  SFRotation->new( 0.0998951, -0.971405, 0.21539, 2.29501 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( 5.84628, 3.36925, -2.3713, ) )->round(3) ==
  Weed::Values::Rotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

ok
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( 5.84628, 3.36925, -2.3713, ) )->round(3) ==
  SFRotation->new( 0.684965, 0.667825, -0.291262, 1.13397 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 9.07798, -1.46409, 0.741627, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

ok
  get_orientation( new SFVec3f( 9.07798, -1.46409, 0.741627, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3) ==
  SFRotation->new( -0.111072, 0.986311, 0.121875, 1.67721 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -6.12343, -5.29558, 2.15483, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

ok
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -6.12343, -5.29558, 2.15483, ) )->round(3) ==
  SFRotation->new( -0.090376, 0.990968, 0.0990731, 1.67159 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 6.7296, -2.68866, 0.972051, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

ok
  get_orientation( new SFVec3f( 6.7296, -2.68866, 0.972051, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3) ==
  SFRotation->new( -0.0998113, 0.985176, 0.139521, 1.91374 )->round(3);

ok
  get_orientation0( new Weed::Values::Vec3( 5.63912, 8.74404, 2.87949, ), new Weed::Values::Vec3( -5.23998, -6.34421, 5.05649, ) )->round(3) ==
  Weed::Values::Rotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

ok
  get_orientation( new SFVec3f( 5.63912, 8.74404, 2.87949, ), new SFVec3f( -5.23998, -6.34421, 5.05649, ) )->round(3) ==
  SFRotation->new( -0.347051, 0.836842, 0.42338, 1.93909 )->round(3);

__END__

sub get_orientation {
	my ( $fromVec, $toVec ) = @_;
	my $distance    = $toVec->subtract($fromVec);
	my $rA          = new SFRotation( $zAxis, $distance );
	my $cameraUp    = $rA->multVec($yAxis);
	my $N2          = $distance->cross($yAxis);
	my $N1          = $distance->cross($cameraUp);
	my $rB          = new SFRotation( $N1, $N2 );
	my $orientation = $rA->multiply($rB);
	return $orientation;
}

function get_orientation (fromVec, toVec) {

	distance = toVec.subtract(fromVec);
	rA = new SFRotation(zAxis, distance);
	cameraUp = rA.multVec(yAxis);
	N2 = distance.cross(yAxis);
	N1 = distance.cross(cameraUp);
	rB = new SFRotation(N1, N2);
	if (rB.x && rB.y  && rB.z) {
		orientation = rA.multiply(rB);
	} else {
		//print(fromVec + '  ' +  toVec);
	}
	print('' + fromVec + ' ' +  toVec + ']), \'' + orientation + '\'');
	return orientation;
}

([\+\-\d.]+ [\+\-\d.]+ [\+\-\d.]+) ([\+\-\d.]+ [\+\-\d.]+ [\+\-\d.]+) ([\+\-\d.]+ [\+\-\d.]+ [\+\-\d.]+  [\+\-\d.]+)

is
  get_orientation0( new Weed::Values::Vec3( \1 ), new Weed::Values::Vec3( \2 ) )->round(3),
  Weed::Values::Rotation->new( \3 )->round(3);

is
  get_orientation( new SFVec3f( \1 ), new SFVec3f( \2 ) )->round(3),
  SFRotation->new( \3 )->round(3);


