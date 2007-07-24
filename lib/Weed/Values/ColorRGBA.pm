package Weed::Values::ColorRGBA;
use Weed::Perl;

our $VERSION = '0.009';

use Package::Alias X3DColorRGBA => __PACKAGE__;

use Weed::Values::Color;
use Weed::Values::Vec4;

use base 'X3DVec4';

use constant getDefaultValue => [ 0, 0, 0, 0 ];

*setRed = \&X3DVec4::setX;
*getRed = \&X3DVec4::getX;

*setGreen = \&X3DVec4::setY;
*getGreen = \&X3DVec4::getY;

*setBlue = \&X3DVec4::setZ;
*getBlue = \&X3DVec4::getZ;

*setAlpha = \&X3DVec4::setW;
*getAlpha = \&X3DVec4::getW;

*r = \&X3DVec4::x;

*g = \&X3DVec4::y;

*b = \&X3DVec4::z;

*a = \&X3DVec4::w;

*getValue = \&X3DColor::getValue;

*setValue = \&X3DColor::setValue;

sub setRGB { @{ $_[0] }[ 0, 1, 2 ] = @{ $_[1] }[ 0, 1, 2 ] }

sub getRGB { new X3DColor [ map { X3DMath::clamp( $_, 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ] }

sub setHSV {
	my ( $this, $h, $s, $v, $a ) = @_;

	my $c = new X3DColor;
	$c->setHSV( $h, $s, $v );

	$this->setRGB($c);
	$this->[3] = $a if defined $a;

	return;
}

sub getHSV { ( $_[0]->getRGB->getHSV, 0 ) }

sub negate {
	my ($a) = @_;
	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  1 - $a->[0],
			1 - $a->[1],
			1 - $a->[2],
			$a->[3],
	] );
}

sub add {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
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
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] + $b,
			$a->[1] + $b,
			$a->[2] + $b,
			$a->[3],
	  ] );
}

use overload '+=' => 'X3DColor::(+=';

sub subtract {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
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
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] - $b,
			$a->[1] - $b,
			$a->[2] - $b,
			$a->[3],
	  ] );
}

use overload '-=' => 'X3DColor::(-=';

sub multiply {
	my ( $a, $b, $r ) = @_;
	return
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  ref $b ? (
				$a->[0] * $b->[0],
				$a->[1] * $b->[1],
				$a->[2] * $b->[2],
				$r ? $b->[3] : $a->[3],
			  ) : (
				$a->[0] * $b,
				$a->[1] * $b,
				$a->[2] * $b,
				$a->[3],
			  ) ] );
}

use overload '*=' => 'X3DColor::(*=';

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
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
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
			$a->[3],
	  ] );
}

use overload '/=' => 'X3DColor::(/=';

sub mod {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $r ? (
				X3DMath::fmod( $b->[0], $a->[0] ),
				X3DMath::fmod( $b->[1], $a->[1] ),
				X3DMath::fmod( $b->[2], $a->[2] ),
				$b->[3],
			  ) : (
				X3DMath::fmod( $a->[0], $b->[0] ),
				X3DMath::fmod( $a->[1], $b->[1] ),
				X3DMath::fmod( $a->[2], $b->[2] ),
				$a->[3],
			  ) ] )
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  X3DMath::fmod( $a->[0], $b ),
			X3DMath::fmod( $a->[1],   $b ),
			X3DMath::fmod( $a->[2],   $b ),
			$a->[3],
	  ] );
}

use overload '%=' => 'X3DColor::(%=';

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
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

use overload '**=' => 'X3DColor::(**=';

use overload '.' => 'X3DVec3::dot';

sub cross {
	my ( $a, $b, $r ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a1 * $b2 - $a2 * $b1,
			$a2 * $b0 - $a0 * $b2,
			$a0 * $b1 - $a1 * $b0,
			$a->[3],
	] );
}

use overload 'x=' => 'X3DColor::(x=';

use overload 'cos' => sub { $_[0]->new( [ ( map { X3DMath::clamp( CORE::cos($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };
use overload 'sin' => sub { $_[0]->new( [ ( map { X3DMath::clamp( CORE::sin($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

sub tan ($) { $_[0]->new( [ ( map { X3DMath::clamp( Math::Trig::tan($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) }

use overload 'exp' => sub { $_[0]->new( [ ( map { X3DMath::clamp( CORE::exp($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };
use overload 'log' => sub { $_[0]->new( [ ( map { X3DMath::clamp( CORE::log($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

use overload 'sqrt' => sub { $_[0]->new( [ ( map { X3DMath::clamp( CORE::sqrt($_), 0, 1 ) } @{ $_[0] }[ 0, 1, 2 ] ), $_[0]->[3] ] ) };

1;
