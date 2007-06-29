package Weed::Values::Vec4;

use strict;
use warnings;

use Weed::Math ();

#use Exporter;

our $VERSION = '0.3449';

use base 'Weed::Values::Vector';

use overload
  #"&", "^", "|",

  #'>>=' => sub { @{ $_[0] } = CORE::reverse @{ $_[0] } if $_[1] & 1; $_[0] },
  #'<<=' => sub { @{ $_[0] } = CORE::reverse @{ $_[0] } if $_[1] & 1; $_[0] },

  #"!" => sub { !$_[0]->length },

  '+='  => \&_add,
  '-='  => \&_subtract,
  '*='  => \&_multiply,
  '/='  => \&_divide,
  '**=' => \&__pow,
  '%='  => \&__mod,
  #".=", # not posible
  "x=" => \&_cross,

  '+'  => 'add',
  '-'  => 'subtract',
  '*'  => 'multiply',
  '/'  => 'divide',
  '**' => \&_pow,
  '%'  => \&_mod,
  '.'  => 'dot',
  "x"  => 'cross',

  #"atan2", "cos", "sin", "exp", "log", "sqrt", "int"

  #"<>"

  #'${}', '@{}', '%{}', '&{}', '*{}'.

  #"nomethod", "fallback",
  ;

use constant getDefaultValue => [ 0, 0, 0, 0 ];

sub setX { $_[0]->[0] = $_[1]; return }

sub setY { $_[0]->[1] = $_[1]; return }

sub setZ { $_[0]->[2] = $_[1]; return }

sub setW { $_[0]->[3] = $_[1]; return }

sub getReal { new Weed::Values::Vec3( [ @{ $_[0] }[ 0, 1, 2 ] ] ) }

sub getX { $_[0]->[0] }

sub getY { $_[0]->[1] }

sub getZ { $_[0]->[2] }

sub getW { $_[0]->[3] }

sub negate {
	my ($a) = @_;
	return $a->new( [
			-$a->[0],
			-$a->[1],
			-$a->[2],
			-$a->[3],
	] );
}

sub add {
	my ( $a, $b ) = @_;
	return $a->new( [
			$a->[0] + $b->[0],
			$a->[1] + $b->[1],
			$a->[2] + $b->[2],
			$a->[3] + $b->[3],
	] );
}

sub _add {
	my ( $a, $b ) = @_;
	$a->[0] += $b->[0];
	$a->[1] += $b->[1];
	$a->[2] += $b->[2];
	$a->[3] += $b->[3];
	return $a;
}

sub subtract {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
				$b->[2] - $a->[2],
				$b->[3] - $a->[3],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
				$a->[2] - $b->[2],
				$a->[3] - $b->[3],
			  ) ] )
	  ;
}

sub _subtract {
	my ( $a, $b ) = @_;
	$a->[0] -= $b->[0];
	$a->[1] -= $b->[1];
	$a->[2] -= $b->[2];
	$a->[3] -= $b->[3];
	return $a;
}

sub multiply {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] * $b->[0],
			$a->[1] * $b->[1],
			$a->[2] * $b->[2],
			$a->[3] * $b->[3],
		] )
	  :
	  $a->new( [
			$a->[0] * $b,
			$a->[1] * $b,
			$a->[2] * $b,
			$a->[3] * $b,
	  ] );
}

sub _multiply {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] *= $b->[0];
		$a->[1] *= $b->[1];
		$a->[2] *= $b->[2];
		$a->[3] *= $b->[3];
	} else {
		$a->[0] *= $b;
		$a->[1] *= $b;
		$a->[2] *= $b;
		$a->[3] *= $b;
	}
	return $a;
}

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] / $a->[0],
				$b->[1] / $a->[1],
				$b->[2] / $a->[2],
				$b->[3] / $a->[3],
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
				$a->[2] / $b->[2],
				$a->[3] / $b->[3],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
			$a->[3] / $b,
	  ] );
}

sub _divide {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] /= $b->[0];
		$a->[1] /= $b->[1];
		$a->[2] /= $b->[2];
		$a->[3] /= $b->[3];
	} else {
		$a->[0] /= $b;
		$a->[1] /= $b;
		$a->[2] /= $b;
		$a->[3] /= $b;
	}
	return $a;
}

#mod
#cut
sub _mod {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				Math::fmod( $b->[0], $a->[0] ),
				Math::fmod( $b->[1], $a->[1] ),
				Math::fmod( $b->[2], $a->[2] ),
				Math::fmod( $b->[3], $a->[3] ),
			  ) : (
				Math::fmod( $a->[0], $b->[0] ),
				Math::fmod( $a->[1], $b->[1] ),
				Math::fmod( $a->[2], $b->[2] ),
				Math::fmod( $a->[3], $b->[3] ),
			  ) ] )
	  : $a->new( [
			Math::fmod( $a->[0], $b ),
			Math::fmod( $a->[1], $b ),
			Math::fmod( $a->[2], $b ),
			Math::fmod( $a->[3], $b ),
	  ] );
}

sub __mod {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::fmod( $a->[0], $b->[0] );
		$a->[1] = Math::fmod( $a->[1], $b->[1] );
		$a->[2] = Math::fmod( $a->[2], $b->[2] );
		$a->[3] = Math::fmod( $a->[3], $b->[3] );
	} else {
		$a->[0] = Math::fmod( $a->[0], $b );
		$a->[1] = Math::fmod( $a->[1], $b );
		$a->[2] = Math::fmod( $a->[2], $b );
		$a->[3] = Math::fmod( $a->[3], $b );
	}
	return $a;
}

sub _pow {
	my ( $a, $b ) = @_;
	return $a->new( [
			$a->[0]**$b,
			$a->[1]**$b,
			$a->[2]**$b,
			$a->[3]**$b,
	] );
}

sub __pow {
	my ( $a, $b ) = @_;
	$a->[0]**= $b;
	$a->[1]**= $b;
	$a->[2]**= $b;
	$a->[3]**= $b;
	return $a;
}

sub dot {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->[0] * $b->[0] +
	  $a->[1] * $b->[1] +
	  $a->[2] * $b->[2] +
	  $a->[3] * $b->[3]
	  : ( $r ? $b . "$a" : "$a" . "$b" )
	  ;
}

sub cross {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2, $a3 ) = @$a;
	my ( $b0, $b1, $b2, $b3 ) = @$b;

	return $a->new(
		( $a0 * $b1 - $a1 * $b0 ) + ( $a0 * $b2 - $a2 * $b0 ) + ( $a1 * $b2 - $a2 * $b1 ),
		( $a2 * $b1 - $a1 * $b2 ) + ( $a1 * $b3 - $a3 * $b1 ) + ( $a2 * $b3 - $a3 * $b2 ),
		( $a0 * $b2 - $a2 * $b0 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a2 * $b3 - $a3 * $b2 ),
		( $a1 * $b0 - $a0 * $b1 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a3 * $b1 - $a1 * $b3 ),
	);
}

sub _cross {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2, $a3 ) = @$a;
	my ( $b0, $b1, $b2, $b3 ) = @$b;

	$a->[0] = ( $a0 * $b1 - $a1 * $b0 ) + ( $a0 * $b2 - $a2 * $b0 ) + ( $a1 * $b2 - $a2 * $b1 );
	$a->[1] = ( $a2 * $b1 - $a1 * $b2 ) + ( $a1 * $b3 - $a3 * $b1 ) + ( $a2 * $b3 - $a3 * $b2 );
	$a->[2] = ( $a0 * $b2 - $a2 * $b0 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a2 * $b3 - $a3 * $b2 );
	$a->[3] = ( $a1 * $b0 - $a0 * $b1 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a3 * $b1 - $a1 * $b3 );

	return $a;
}

sub length {
	my ($a) = @_;
	return sqrt(
		$a->[0] * $a->[0] +
		  $a->[1] * $a->[1] +
		  $a->[2] * $a->[2] +
		  $a->[3] * $a->[3]
	);
}

1;
