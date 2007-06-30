package Weed::Values::Color;
use Weed::Perl;

use base 'Weed::Values::Vec3';

*setRed = \&Weed::Values::Vec3::setX;
*getRed = \&Weed::Values::Vec3::getX;

*setGreen = \&Weed::Values::Vec3::setY;
*getGreen = \&Weed::Values::Vec3::getY;

*setBlue = \&Weed::Values::Vec3::setZ;
*getBlue = \&Weed::Values::Vec3::getZ;

sub getValue { map { Math::clamp( $_, 0, 1 ) } $_[0]->SUPER::getValue }

sub setValue {
	my $this = shift;
	$this->SUPER::setValue( map { Math::clamp( $_, 0, 1 ) } @_ );
	return;
}

sub setHSV {
	my ( $this, $h, $s, $v ) = @_;

	# H is given on [0, 2 PI]. S and V are given on [0, 1].
	# RGB are each returned on [0, 1].

	# achromatic (grey)
	return $this->setValue( $v, $v, $v ) if $s == 0;

	my ( $i, $f, $p, $q, $t );

	$h /= Math::PI2;    # radiants
	$h *= 6;            # do not optimize

	$i = Math::floor($h);
	$f = $h - $i;                        # factorial part of h
	$p = $v * ( 1 - $s );
	$q = $v * ( 1 - $s * $f );
	$t = $v * ( 1 - $s * ( 1 - $f ) );

	return $this->setValue( $v, $t, $p ) if $i == 0;
	return $this->setValue( $q, $v, $p ) if $i == 1;
	return $this->setValue( $p, $v, $t ) if $i == 2;
	return $this->setValue( $p, $q, $v ) if $i == 3;
	return $this->setValue( $t, $p, $v ) if $i == 4;
	return $this->setValue( $v, $p, $q ) if $i == 5;

	return $this->setValue( $v, $t, $p );
}

sub getHSV {
	my ($this) = @_;

	my ( $r, $g, $b ) = $this->getValue;
	my ( $h, $s, $v );

	my $min = Math::min( $r, $g, $b );
	my $max = Math::max( $r, $g, $b );
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
	$h *= Math::PI2;                      # radiants

	return ( $h, $s, $v );
}

sub negate {
	my ($a) = @_;
	return $a->new( [
			1 - $a->[0],
			1 - $a->[1],
			1 - $a->[2],
	] );
}

use overload "+=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0] + $b->[0], 0, 1 );
	$a->[1] = Math::clamp( $a->[1] + $b->[1], 0, 1 );
	$a->[2] = Math::clamp( $a->[2] + $b->[2], 0, 1 );
	return $a;
};

use overload "-=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0] - $b->[0], 0, 1 );
	$a->[1] = Math::clamp( $a->[1] - $b->[1], 0, 1 );
	$a->[2] = Math::clamp( $a->[2] - $b->[2], 0, 1 );
	return $a;
};

use overload "*=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::clamp( $a->[0] * $b->[0], 0, 1 );
		$a->[1] = Math::clamp( $a->[1] * $b->[1], 0, 1 );
		$a->[2] = Math::clamp( $a->[2] * $b->[2], 0, 1 );
	} else {
		$a->[0] = Math::clamp( $a->[0] * $b, 0, 1 );
		$a->[1] = Math::clamp( $a->[1] * $b, 0, 1 );
		$a->[2] = Math::clamp( $a->[2] * $b, 0, 1 );
	}
	return $a;
};

use overload "/=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::clamp( $a->[0] / $b->[0], 0, 1 );
		$a->[1] = Math::clamp( $a->[1] / $b->[1], 0, 1 );
		$a->[2] = Math::clamp( $a->[2] / $b->[2], 0, 1 );
	} else {
		$a->[0] = Math::clamp( $a->[0] / $b, 0, 1 );
		$a->[1] = Math::clamp( $a->[1] / $b, 0, 1 );
		$a->[2] = Math::clamp( $a->[2] / $b, 0, 1 );
	}
	return $a;
};

use overload "%=" => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = Math::clamp( Math::fmod( $a->[0], $b->[0] ), 0, 1 );
		$a->[1] = Math::clamp( Math::fmod( $a->[1], $b->[1] ), 0, 1 );
		$a->[2] = Math::clamp( Math::fmod( $a->[2], $b->[2] ), 0, 1 );
	} else {
		$a->[0] = Math::clamp( Math::fmod( $a->[0], $b ), 0, 1 );
		$a->[1] = Math::clamp( Math::fmod( $a->[1], $b ), 0, 1 );
		$a->[2] = Math::clamp( Math::fmod( $a->[2], $b ), 0, 1 );
	}
	return $a;
};

use overload "**=" => sub {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0]**$b, 0, 1 );
	$a->[1] = Math::clamp( $a->[1]**$b, 0, 1 );
	$a->[2] = Math::clamp( $a->[2]**$b, 0, 1 );
	return $a;
};

use overload "x=" => sub {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	$a->[0] = Math::clamp( $a1 * $b2 - $a2 * $b1, 0, 1 );
	$a->[1] = Math::clamp( $a2 * $b0 - $a0 * $b2, 0, 1 );
	$a->[2] = Math::clamp( $a0 * $b1 - $a1 * $b0, 0, 1 );

	return $a;
};

1;
