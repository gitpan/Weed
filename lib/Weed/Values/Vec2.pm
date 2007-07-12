package Weed::Values::Vec2;
use Weed::Perl;

our $VERSION = '0.0078';

use base 'Weed::Values::Vector';

use constant getDefaultValue => [ 0, 0 ];

sub setX { $_[0]->[0] = $_[1]; return }

sub setY { $_[0]->[1] = $_[1]; return }

sub getX { $_[0]->[0] }

sub getY { $_[0]->[1] }

sub negate {
	my ($a) = @_;
	return $a->new( [
			-$a->[0],
			-$a->[1],
	] );
}

sub add {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] + $b->[0],
			$a->[1] + $b->[1],
		] )
	  :
	  $a->new( [
			$a->[0] + $b,
			$a->[1] + $b,
	  ] );
}

use overload '+=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] += $b->[0];
		$a->[1] += $b->[1];
	} else {
		$a->[0] += $b;
		$a->[1] += $b;
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
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
			  ) ] )
	  : $a->new( [
			$a->[0] - $b,
			$a->[1] - $b,
	  ] );
}

use overload '-=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] -= $b->[0];
		$a->[1] -= $b->[1];
	} else {
		$a->[0] -= $b;
		$a->[1] -= $b;
	}
	return $a;
};

sub multiply {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] * $b->[0],
			$a->[1] * $b->[1],
		] )
	  :
	  $a->new( [
			$a->[0] * $b,
			$a->[1] * $b,
	  ] );
}

use overload '*=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] *= $b->[0];
		$a->[1] *= $b->[1];
	} else {
		$a->[0] *= $b;
		$a->[1] *= $b;
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
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
	  ] );
}

use overload '/=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] /= $b->[0];
		$a->[1] /= $b->[1];
	} else {
		$a->[0] /= $b;
		$a->[1] /= $b;
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
			  ) : (
				Math::fmod( $a->[0], $b->[0] ),
				Math::fmod( $a->[1], $b->[1] ),
			  ) ] )
	  : $a->new( [
			Math::fmod( $a->[0], $b ),
			Math::fmod( $a->[1], $b ),
	  ] );
}

use overload '%=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::fmod( $a->[0], $b->[0] );
		$a->[1] = Math::fmod( $a->[1], $b->[1] );
	} else {
		$a->[0] = Math::fmod( $a->[0], $b );
		$a->[1] = Math::fmod( $a->[1], $b );
	}
	return $a;
};

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b**$a->[0],
				$b**$a->[1],
			  ) : (
				$a->[0]**$b,
				$a->[1]**$b,
			  )
	] );
}

use overload '**=' => sub {
	my ( $a, $b ) = @_;
	$a->[0]**= $b;
	$a->[1]**= $b;
	return $a;
};

sub dot {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->[0] * $b->[0] +
	  $a->[1] * $b->[1]
	  : ( $r ? $b . "$a" : "$a" . "$b" )
	  ;
}

sub length {
	my ($a) = @_;
	return sqrt(
		$a->[0] * $a->[0] +
		  $a->[1] * $a->[1]
	);
}

sub sum { $_[0]->[0] + $_[0]->[1] }

1;
