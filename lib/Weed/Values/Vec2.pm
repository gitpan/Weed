package Weed::Values::Vec2;
use Weed::Perl;

our $VERSION = '0.009';

use Package::Alias X3DVec2 => __PACKAGE__;

use Weed::Values::Vector;
use base 'X3DVector';

use constant getDefaultValue => [ 0, 0 ];

sub setX { $_[0]->[0] = $_[1]; return }

sub setY { $_[0]->[1] = $_[1]; return }

sub getX { $_[0]->[0] }

sub getY { $_[0]->[1] }

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

sub negate {
	my ($a) = @_;
	return $a->new( [
			-$a->[0],
			-$a->[1],
	] );
}

sub add {
	my ( $a, $b ) = @_;
	return
	  $a->new( [ ref $b ? (
				$a->[0] + $b->[0],
				$a->[1] + $b->[1],
			  ) : (
				$a->[0] + $b,
				$a->[1] + $b,
			  ) ] );
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
	return
	  $a->new( [ ref $b ? (
				$a->[0] * $b->[0],
				$a->[1] * $b->[1],
			  ) : (
				$a->[0] * $b,
				$a->[1] * $b,
			  ) ] );
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
				X3DMath::fmod( $b->[0], $a->[0] ),
				X3DMath::fmod( $b->[1], $a->[1] ),
			  ) : (
				X3DMath::fmod( $a->[0], $b->[0] ),
				X3DMath::fmod( $a->[1], $b->[1] ),
			  ) ] )
	  : $a->new( [
			X3DMath::fmod( $a->[0], $b ),
			X3DMath::fmod( $a->[1], $b ),
	  ] );
}

use overload '%=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = X3DMath::fmod( $a->[0], $b->[0] );
		$a->[1] = X3DMath::fmod( $a->[1], $b->[1] );
	} else {
		$a->[0] = X3DMath::fmod( $a->[0], $b );
		$a->[1] = X3DMath::fmod( $a->[1], $b );
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
	  : ( $r ? $b . "$a" : "$a" . $b )
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

use constant elementCount => 2;

1;
__END__
