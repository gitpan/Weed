package Weed::Values::Vec2;

use strict;
use warnings;

use Weed::Math ();

#use Exporter;

our $VERSION = '0.3449';

use base 'Weed::Values::Vector';

use overload
  #"&", "^", "|",

  #'>>' => sub { $_[1] & 1 ? ~$_[0] : $_[0]->copy },
  #'<<' => sub { $_[1] & 1 ? ~$_[0] : $_[0]->copy },
  #'>>=' => sub { @{ $_[0] } = CORE::reverse @{ $_[0] } if $_[1] & 1; $_[0] },
  #'<<=' => sub { @{ $_[0] } = CORE::reverse @{ $_[0] } if $_[1] & 1; $_[0] },

  #"!" => sub { !$_[0]->length },

  '+='  => \&_add,
  '-='  => \&_subtract,
  '*='  => \&_multiply,
  '/='  => \&_divide,
  '**=' => \&__pow,
  '%='  => \&__mod,
  #".=",

  '+'  => 'add',
  '-'  => 'subtract',
  '*'  => 'multiply',
  '/'  => 'divide',
  '**' => \&_pow,
  '%'  => \&_mod,
  '.'  => 'dot',

  #"x", "x=",

  #"atan2", "cos", "sin", "exp", "log", "sqrt", "int"

  #"<>"

  #'${}', '@{}', '%{}', '&{}', '*{}'.

  #"nomethod", "fallback",
  ;

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
	return $a->new( [
			$a->[0] + $b->[0],
			$a->[1] + $b->[1],
	] );
}

sub _add {
	my ( $a, $b ) = @_;
	$a->[0] += $b->[0];
	$a->[1] += $b->[1];
	return $a;
}

sub subtract {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
			  ) ] )
	  ;
}

sub _subtract {
	my ( $a, $b ) = @_;
	$a->[0] -= $b->[0];
	$a->[1] -= $b->[1];
	return $a;
}

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

sub _multiply {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] *= $b->[0];
		$a->[1] *= $b->[1];
	} else {
		$a->[0] *= $b;
		$a->[1] *= $b;
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
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
	  ] );
}

sub _divide {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] /= $b->[0];
		$a->[1] /= $b->[1];
	} else {
		$a->[0] /= $b;
		$a->[1] /= $b;
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
			  ) : (
				Math::fmod( $a->[0], $b->[0] ),
				Math::fmod( $a->[1], $b->[1] ),
			  ) ] )
	  : $a->new( [
			Math::fmod( $a->[0], $b ),
			Math::fmod( $a->[1], $b ),
	  ] );
}

sub __mod {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::fmod( $a->[0], $b->[0] );
		$a->[1] = Math::fmod( $a->[1], $b->[1] );
	} else {
		$a->[0] = Math::fmod( $a->[0], $b );
		$a->[1] = Math::fmod( $a->[1], $b );
	}
	return $a;
}

sub _pow {
	my ( $a, $b ) = @_;
	return $a->new( [
			$a->[0]**$b,
			$a->[1]**$b
	] );
}

sub __pow {
	my ( $a, $b ) = @_;
	$a->[0]**= $b;
	$a->[1]**= $b;
	return $a;
}

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
