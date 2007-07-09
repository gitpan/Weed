package Weed::Values::Vec3;
use Weed::Perl;

use base 'Weed::Values::Vector';

use overload "x" => 'cross';

use constant getDefaultValue => [ 0, 0, 0 ];

sub setX { $_[0]->[0] = $_[1]; return }

sub setY { $_[0]->[1] = $_[1]; return }

sub setZ { $_[0]->[2] = $_[1]; return }

sub getX { $_[0]->[0] }

sub getY { $_[0]->[1] }

sub getZ { $_[0]->[2] }

sub negate {
	my ($a) = @_;
	return $a->new( [
			-$a->[0],
			-$a->[1],
			-$a->[2],
	] );
}

sub add {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] + $b->[0],
			$a->[1] + $b->[1],
			$a->[2] + $b->[2],
		] )
	  :
	  $a->new( [
			$a->[0] + $b,
			$a->[1] + $b,
			$a->[2] + $b,
	  ] );
}

use overload '+=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] += $b->[0];
		$a->[1] += $b->[1];
		$a->[2] += $b->[2];
	} else {
		$a->[0] += $b;
		$a->[1] += $b;
		$a->[2] += $b;
	}
	return $a;
};

sub subtract {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
				$b->[2] - $a->[2],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
				$a->[2] - $b->[2],
			  ) ] )
	  : $a->new( [
			$a->[0] - $b,
			$a->[1] - $b,
			$a->[2] - $b,
	  ] );
}

use overload '-=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] -= $b->[0];
		$a->[1] -= $b->[1];
		$a->[2] -= $b->[2];
	} else {
		$a->[0] -= $b;
		$a->[1] -= $b;
		$a->[2] -= $b;
	}
	return $a;
};

sub multiply {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] * $b->[0],
			$a->[1] * $b->[1],
			$a->[2] * $b->[2],
		] )
	  :
	  $a->new( [
			$a->[0] * $b,
			$a->[1] * $b,
			$a->[2] * $b,
	  ] );
}

use overload '*=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] *= $b->[0];
		$a->[1] *= $b->[1];
		$a->[2] *= $b->[2];
	} else {
		$a->[0] *= $b;
		$a->[1] *= $b;
		$a->[2] *= $b;
	}
	return $a;
};

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] / $a->[0],
				$b->[1] / $a->[1],
				$b->[2] / $a->[2],
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
				$a->[2] / $b->[2],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
	  ] );
}

use overload '/=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] /= $b->[0];
		$a->[1] /= $b->[1];
		$a->[2] /= $b->[2];
	} else {
		$a->[0] /= $b;
		$a->[1] /= $b;
		$a->[2] /= $b;
	}
	return $a;
};

sub mod {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				Math::fmod( $b->[0], $a->[0] ),
				Math::fmod( $b->[1], $a->[1] ),
				Math::fmod( $b->[2], $a->[2] ),
			  ) : (
				Math::fmod( $a->[0], $b->[0] ),
				Math::fmod( $a->[1], $b->[1] ),
				Math::fmod( $a->[2], $b->[2] ),
			  ) ] )
	  : $a->new( [
			Math::fmod( $a->[0], $b ),
			Math::fmod( $a->[1], $b ),
			Math::fmod( $a->[2], $b ),
	  ] );
}

#cut
use overload '%=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::fmod( $a->[0], $b->[0] );
		$a->[1] = Math::fmod( $a->[1], $b->[1] );
		$a->[2] = Math::fmod( $a->[2], $b->[2] );
	} else {
		$a->[0] = Math::fmod( $a->[0], $b );
		$a->[1] = Math::fmod( $a->[1], $b );
		$a->[2] = Math::fmod( $a->[2], $b );
	}
	return $a;
};

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b**$a->[0],
				$b**$a->[1],
				$b**$a->[2],
			  ) : (
				$a->[0]**$b,
				$a->[1]**$b,
				$a->[2]**$b,
			  )
	] );
}

use overload '**=' => sub {
	my ( $a, $b ) = @_;
	$a->[0]**= $b;
	$a->[1]**= $b;
	$a->[2]**= $b;
	return $a;
};

sub dot {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->[0] * $b->[0] +
	  $a->[1] * $b->[1] +
	  $a->[2] * $b->[2]
	  : ( $r ? $b . "$a" : "$a" . "$b" )
	  ;
}

sub cross {
	my ( $a, $b, $r ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	return $a->new( [
			$a1 * $b2 - $a2 * $b1,
			$a2 * $b0 - $a0 * $b2,
			$a0 * $b1 - $a1 * $b0
	] );
}

use overload "x=" => sub {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	$a->[0] = $a1 * $b2 - $a2 * $b1;
	$a->[1] = $a2 * $b0 - $a0 * $b2;
	$a->[2] = $a0 * $b1 - $a1 * $b0;

	return $a;
};

sub length {
	my ($a) = @_;
	return sqrt(
		$a->[0] * $a->[0] +
		  $a->[1] * $a->[1] +
		  $a->[2] * $a->[2]
	);
}

1;
