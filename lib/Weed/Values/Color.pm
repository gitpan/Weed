package Weed::Values::Color;
use Weed::Perl;

our $VERSION = '0.0081';

use Package::Alias X3DColor => __PACKAGE__;

use Weed::Values::Vec3;
use base 'X3DVec3';

*setRed = \&X3DVec3::setX;
*getRed = \&X3DVec3::getX;

*setGreen = \&X3DVec3::setY;
*getGreen = \&X3DVec3::getY;

*setBlue = \&X3DVec3::setZ;
*getBlue = \&X3DVec3::getZ;

*r = \&X3DVec3::x;

*g = \&X3DVec3::y;

*b = \&X3DVec3::z;

sub getValue { [ map { X3DMath::clamp( $_, 0, 1 ) } @{ $_[0]->SUPER::getValue } ] }

sub setValue {
	my $this = shift;
	$this->SUPER::setValue( [ map { X3DMath::clamp( $_, 0, 1 ) } @{ $_[0] } ] );
	return;
}

sub set1Value {
	my ( $this, $index, $value ) = @_;
	return $this->[$index] = X3DMath::clamp( $value, 0, 1 ) if exists $this->[$index];
	return;
}

sub setHSV {
	my ( $this, $h, $s, $v ) = @_;

	# H is given on [0, 2 PI]. S and V are given on [0, 1].
	# RGB are each returned on [0, 1].

	# achromatic (grey)
	return $this->setValue( [ $v, $v, $v ] ) if $s == 0;

	my ( $i, $f, $p, $q, $t );

	$h /= X3DMath::PI2;    # radiants
	$h *= 6;               # do not optimize

	$i = X3DMath::floor($h);
	$f = $h - $i;                        # factorial part of h
	$p = $v * ( 1 - $s );
	$q = $v * ( 1 - $s * $f );
	$t = $v * ( 1 - $s * ( 1 - $f ) );

	return $this->setValue( [ $v, $t, $p ] ) if $i == 0;
	return $this->setValue( [ $q, $v, $p ] ) if $i == 1;
	return $this->setValue( [ $p, $v, $t ] ) if $i == 2;
	return $this->setValue( [ $p, $q, $v ] ) if $i == 3;
	return $this->setValue( [ $t, $p, $v ] ) if $i == 4;
	return $this->setValue( [ $v, $p, $q ] ) if $i == 5;

	$this->setValue( [ $v, $t, $p ] );
	return;
}

sub getHSV {
	my ($this) = @_;

	my ( $r, $g, $b ) = @{ $this->getValue };
	my ( $h, $s, $v );

	my $min = X3DMath::min( $r, $g, $b );
	my $max = X3DMath::max( $r, $g, $b );
	$v = $max;    # v

	my $delta = $max - $min;

	# r = g = b = 0								# s = 0, h is undefined
	return ( 0, 0, 0 ) unless $max != 0 && $delta != 0;

	$s = $delta / $max;    # s

	if ( $r == $max ) {
		$h = ( $g - $b ) / $delta;    # between yellow & magenta
	}
	elsif ( $g == $max ) {
		$h = 2 + ( $b - $r ) / $delta;    # between cyan & yellow
	}
	else {
		$h = 4 + ( $r - $g ) / $delta;    # between magenta & cyan
	}

	$h += 6 if $h < 0;

	$h /= 6;                              # do not optimize
	$h *= X3DMath::PI2;                   # radiants

	return ( $h, $s, $v );
}

sub negate {
	my ($a) = @_;
	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  1 - $a->[0],
			1 - $a->[1],
			1 - $a->[2],
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
			  ) : (
				$a->[0] + $b->[0],
				$a->[1] + $b->[1],
				$a->[2] + $b->[2],
			  ) ] )
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] + $b,
			$a->[1] + $b,
			$a->[2] + $b,
	  ] );
}

use overload "+=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = X3DMath::clamp( $a->[0] + $b->[0], 0, 1 );
	$a->[1] = X3DMath::clamp( $a->[1] + $b->[1], 0, 1 );
	$a->[2] = X3DMath::clamp( $a->[2] + $b->[2], 0, 1 );
	return $a;
};

sub subtract {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
				$b->[2] - $a->[2],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
				$a->[2] - $b->[2],
			  ) ] )
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] - $b,
			$a->[1] - $b,
			$a->[2] - $b,
	  ] );
}

use overload "-=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = X3DMath::clamp( $a->[0] - $b->[0], 0, 1 );
	$a->[1] = X3DMath::clamp( $a->[1] - $b->[1], 0, 1 );
	$a->[2] = X3DMath::clamp( $a->[2] - $b->[2], 0, 1 );
	return $a;
};

sub multiply {
	my ( $a, $b, $r ) = @_;
	return
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  ref $b ? (
				$a->[0] * $b->[0],
				$a->[1] * $b->[1],
				$a->[2] * $b->[2],
			  ) : (
				$a->[0] * $b,
				$a->[1] * $b,
				$a->[2] * $b,
			  ) ] );
}

use overload "*=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = X3DMath::clamp( $a->[0] * $b->[0], 0, 1 );
		$a->[1] = X3DMath::clamp( $a->[1] * $b->[1], 0, 1 );
		$a->[2] = X3DMath::clamp( $a->[2] * $b->[2], 0, 1 );
	} else {
		$a->[0] = X3DMath::clamp( $a->[0] * $b, 0, 1 );
		$a->[1] = X3DMath::clamp( $a->[1] * $b, 0, 1 );
		$a->[2] = X3DMath::clamp( $a->[2] * $b, 0, 1 );
	}
	return $a;
};

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $r ? (
				$b->[0] / $a->[0],
				$b->[1] / $a->[1],
				$b->[2] / $a->[2],
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
				$a->[2] / $b->[2],
			  ) ] )
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
	  ] );
}

use overload "/=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = X3DMath::clamp( $a->[0] / $b->[0], 0, 1 );
		$a->[1] = X3DMath::clamp( $a->[1] / $b->[1], 0, 1 );
		$a->[2] = X3DMath::clamp( $a->[2] / $b->[2], 0, 1 );
	} else {
		$a->[0] = X3DMath::clamp( $a->[0] / $b, 0, 1 );
		$a->[1] = X3DMath::clamp( $a->[1] / $b, 0, 1 );
		$a->[2] = X3DMath::clamp( $a->[2] / $b, 0, 1 );
	}
	return $a;
};

sub mod {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $r ? (
				X3DMath::fmod( $b->[0], $a->[0] ),
				X3DMath::fmod( $b->[1], $a->[1] ),
				X3DMath::fmod( $b->[2], $a->[2] ),
			  ) : (
				X3DMath::fmod( $a->[0], $b->[0] ),
				X3DMath::fmod( $a->[1], $b->[1] ),
				X3DMath::fmod( $a->[2], $b->[2] ),
			  ) ] )
	  : $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  X3DMath::fmod( $a->[0], $b ),
			X3DMath::fmod( $a->[1],   $b ),
			X3DMath::fmod( $a->[2],   $b ),
	  ] );
}

use overload "%=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = X3DMath::clamp( X3DMath::fmod( $a->[0], $b->[0] ), 0, 1 );
		$a->[1] = X3DMath::clamp( X3DMath::fmod( $a->[1], $b->[1] ), 0, 1 );
		$a->[2] = X3DMath::clamp( X3DMath::fmod( $a->[2], $b->[2] ), 0, 1 );
	} else {
		$a->[0] = X3DMath::clamp( X3DMath::fmod( $a->[0], $b ), 0, 1 );
		$a->[1] = X3DMath::clamp( X3DMath::fmod( $a->[1], $b ), 0, 1 );
		$a->[2] = X3DMath::clamp( X3DMath::fmod( $a->[2], $b ), 0, 1 );
	}
	return $a;
};

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
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

use overload "**=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = X3DMath::clamp( $a->[0]**$b, 0, 1 );
	$a->[1] = X3DMath::clamp( $a->[1]**$b, 0, 1 );
	$a->[2] = X3DMath::clamp( $a->[2]**$b, 0, 1 );
	return $a;
};

sub cross {
	my ( $a, $b, $r ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	return $a->new( [ map { X3DMath::clamp( $_, 0, 1 ) }
			  $a1 * $b2 - $a2 * $b1,
			$a2 * $b0 - $a0 * $b2,
			$a0 * $b1 - $a1 * $b0,
	] );
}

use overload "x=" => sub {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	$a->[0] = X3DMath::clamp( $a1 * $b2 - $a2 * $b1, 0, 1 );
	$a->[1] = X3DMath::clamp( $a2 * $b0 - $a0 * $b2, 0, 1 );
	$a->[2] = X3DMath::clamp( $a0 * $b1 - $a1 * $b0, 0, 1 );

	return $a;
};

use overload 'cos' => sub { $_[0]->new( [ map { X3DMath::clamp( CORE::cos($_), 0, 1 ) } @{ $_[0] } ] ) };
use overload 'sin' => sub { $_[0]->new( [ map { X3DMath::clamp( CORE::sin($_), 0, 1 ) } @{ $_[0] } ] ) };

sub tan ($) { $_[0]->new( [ map { X3DMath::clamp( Math::Trig::tan($_), 0, 1 ) } @{ $_[0] } ] ) }

use overload 'exp' => sub { $_[0]->new( [ map { X3DMath::clamp( CORE::exp($_), 0, 1 ) } @{ $_[0] } ] ) };
use overload 'log' => sub { $_[0]->new( [ map { X3DMath::clamp( CORE::log($_), 0, 1 ) } @{ $_[0] } ] ) };

use overload 'sqrt' => sub { $_[0]->new( [ map { X3DMath::clamp( CORE::sqrt($_), 0, 1 ) } @{ $_[0] } ] ) };

1;
