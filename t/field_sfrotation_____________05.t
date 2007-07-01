#!/usr/bin/perl -w
#package field_sfrotation_____________05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

__END__

my $yAxis = [ 0, 1, 0 ];
my $zAxis = [ 0, 0, -1 ];

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

get_orientation( new SFVec3f( rand, rand, rand ), new SFVec3f( rand, rand, rand ) );

function set_position () {
	viewpoint.orientation = get_orientation(viewpoint.position, data.pointOfInterest);
}

