package Weed::Values::ColorRGBA;

use strict;
use warnings;

our $VERSION = '0.2549';

use Weed::Math ();
use Weed::Values::Color;
use base 'Weed::Values::Vec4';

use constant getDefaultValue => [ 0, 0, 0, 0 ];

use overload
  '~' => 'inverse',

  '+='  => \&_add,
  '-='  => \&_subtract,
  '*='  => \&_multiply,
  '/='  => \&_divide,
  '**=' => \&__pow,
  '%='  => \&__mod,

  '+'  => 'add',
  '-'  => 'subtract',
  '*'  => 'multiply',
  '/'  => 'divide',
  '**' => \&_pow,
  '%'  => \&_mod,
  ;

sub setRGB { @{ $_[0] }[ 0, 1, 2 ] = @{ $_[1] }[ 0, 1, 2 ] }

*setRed = \&Weed::Values::Vec4::setX;
*getRed = \&Weed::Values::Vec4::getX;

*setGreen = \&Weed::Values::Vec4::setY;
*getGreen = \&Weed::Values::Vec4::getY;

*setBlue = \&Weed::Values::Vec4::setZ;
*getBlue = \&Weed::Values::Vec4::getZ;

*setAlpha = \&Weed::Values::Vec4::setW;
*getAlpha = \&Weed::Values::Vec4::getW;

sub getValue { map { Math::clamp( $_, 0, 1 ) } $_[0]->SUPER::getValue }

sub setValue {
	my $this = shift;
	$this->SUPER::setValue( map { Math::clamp( $_, 0, 1 ) } @_ );
	return;
}

sub getRGB { new Weed::Values::Color( map { Math::clamp( $_, 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ) }

sub setHSV {
	my ( $this, $h, $s, $v, $a ) = @_;

	my $c = new Weed::Values::Color;
	$c->setHSV( $h, $s, $v );

	$this->setRGB($c);
	$this->setAlpha($a) if defined $a;
}

sub getHSV { ( $_[0]->getRGB->getHSV, 0 ) }

sub inverse {
	my ($a) = @_;
	return $a->new( [
			1 - $a->[0],
			1 - $a->[1],
			1 - $a->[2],
			$a->[3],
	] );
}

sub add {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$a->[0] + $b->[0],
			$a->[1] + $b->[1],
			$a->[2] + $b->[2],
			$r ? $b->[3] : $a->[3],
	] );
}

*_add = \&Weed::Values::Color::_add;

sub subtract {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
				$b->[2] - $a->[2],
				$b->[3],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
				$a->[2] - $b->[2],
				$a->[3],
			  ) ] )
	  ;
}

*_subtract = \&Weed::Values::Color::_subtract;

sub multiply {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$a->[0] * $b->[0],
			$a->[1] * $b->[1],
			$a->[2] * $b->[2],
			$r ? $b->[3] : $a->[3],
		] )
	  :
	  $a->new( [
			$a->[0] * $b,
			$a->[1] * $b,
			$a->[2] * $b,
			$a->[3],
	  ] );
}

*_multiply = \&Weed::Values::Color::_multiply;

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] / $a->[0],
				$b->[1] / $a->[1],
				$b->[2] / $a->[2],
				$b->[3],
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
				$a->[2] / $b->[2],
				$a->[3],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
			$a->[3],
	  ] );
}

*_divide = \&Weed::Values::Color::_divide;

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
				$b->[3],
			  ) : (
				Math::fmod( $a->[0], $b->[0] ),
				Math::fmod( $a->[1], $b->[1] ),
				Math::fmod( $a->[2], $b->[2] ),
				$a->[3],
			  ) ] )
	  : $a->new( [
			Math::fmod( $a->[0], $b ),
			Math::fmod( $a->[1], $b ),
			Math::fmod( $a->[2], $b ),
			$a->[3],
	  ] );
}

*__mod = \&Weed::Values::Color::__mod;

sub _pow {
	my ( $a, $b ) = @_;
	return $a->new( [
			$a->[0]**$b,
			$a->[1]**$b,
			$a->[2]**$b,
			$a->[3],
	] );
}

*__pow = \&Weed::Values::Color::__pow;

*_dot = \&Weed::Values::Vec3::_dot;

*_cross = \&Weed::Values::Color::_cross;

1;
