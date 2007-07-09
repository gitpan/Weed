package Weed::Values::ColorRGBA;
use Weed::Perl;

use Weed::Values::Color;

use base 'Weed::Values::Vec4';

use constant getDefaultValue => [ 0, 0, 0, 0 ];

sub setRGB { @{ $_[0] }[ 0, 1, 2 ] = @{ $_[1] }[ 0, 1, 2 ] }

*setRed = \&Weed::Values::Vec4::setX;
*getRed = \&Weed::Values::Vec4::getX;

*setGreen = \&Weed::Values::Vec4::setY;
*getGreen = \&Weed::Values::Vec4::getY;

*setBlue = \&Weed::Values::Vec4::setZ;
*getBlue = \&Weed::Values::Vec4::getZ;

*setAlpha = \&Weed::Values::Vec4::setW;
*getAlpha = \&Weed::Values::Vec4::getW;

sub getValue { [ map { Math::clamp( $_, 0, 1 ) } @{ $_[0]->SUPER::getValue } ] }

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

sub negate {
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
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] + $a->[0],
				$b->[1] + $a->[1],
				$b->[2] + $a->[2],
				$b->[3],
			  ) : (
				$a->[0] + $b->[0],
				$a->[1] + $b->[1],
				$a->[2] + $b->[2],
				$a->[3],
			  ) ] )
	  : $a->new( [
			$a->[0] + $b,
			$a->[1] + $b,
			$a->[2] + $b,
			$a->[3],
	  ] );
}

use overload '+=' => 'Weed::Values::Color::(+=';

sub subtract {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
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
	  : $a->new( [
			$a->[0] - $b,
			$a->[1] - $b,
			$a->[2] - $b,
			$a->[3],
	  ] );
}

use overload '-=' => 'Weed::Values::Color::(-=';

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

use overload '*=' => 'Weed::Values::Color::(*=';

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

use overload '/=' => 'Weed::Values::Color::(/=';

sub mod {
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

use overload '%=' => 'Weed::Values::Color::(%=';

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b**$a->[0],
				$b**$a->[1],
				$b**$a->[2],
				$a->[3],
			  ) : (
				$a->[0]**$b,
				$a->[1]**$b,
				$a->[2]**$b,
				$a->[3],
			  )
	] );
}

use overload '**=' => 'Weed::Values::Color::(**=';

use overload '.' => 'Weed::Values::Vec3::dot';

sub cross {
	my ( $a, $b, $r ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	return $a->new( [
			$a1 * $b2 - $a2 * $b1,
			$a2 * $b0 - $a0 * $b2,
			$a0 * $b1 - $a1 * $b0,
			$a->[3],
	] );
}

use overload 'x=' => 'Weed::Values::Color::(x=';

use overload 'cos' => sub { $_[0]->new( [ ( map { CORE::cos($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };
use overload 'sin' => sub { $_[0]->new( [ ( map { CORE::sin($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

sub tan ($) { $_[0]->new( [ ( map { Math::Trig::tan($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) }

use overload 'exp' => sub { $_[0]->new( [ ( map { CORE::exp($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };
use overload 'log' => sub { $_[0]->new( [ ( map { CORE::log($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

use overload 'sqrt' => sub { $_[0]->new( [ ( map { CORE::sqrt($_) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

1;
