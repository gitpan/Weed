package Weed::Values::Color;

use strict;
use warnings;

our $VERSION = '0.3444';

use Weed::Math ();

use base 'Weed::Values::Vec3';

=head1 NAME

Math::Color - Perl class to represent colors

=head1 TREE

-+- L<Math::Vector> -+- L<Math::Vec3> -+- L<Math::Color>

=head1 SEE ALSO

L<PDL> for scientific and bulk numeric data processing and display

L<Math>

L<Math::Vectors>

L<Math::Color>, L<Math::ColorRGBA>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>

=head1 SYNOPSIS
	
	use Math::Vectors;
	my $c = new Math::Color;  # Make a new Color

	my $c1 = new Math::Color(0,1,0);

=head1 DESCRIPTION

=head2 DefaultValue

	0 0 0

=cut

use overload
  '~' => 'inverse',
  ;

=head1 METHODS

=head2 new(r,g,b)

r, g, b are given on [0, 1].

	my $c = new Math::Color; 					  
	my $c2 = new Math::Color(0, 0.5, 1);   
	my $c3 = new Math::Color([0, 0.5, 1]); 

=cut

=head2 copy

Makes a copy
	
	$c2 = $c1->copy;

=cut

=head2 setValue(r,g,b)

Sets the value of the color.
r, g, b are given on [0, 1].

	$c1->setValue(0, 0.2, 1);

=cut

=head2 setRed(r)

Sets the first value of the color
r is given on [0, 1].

	$c1->setRed(1);

=cut

*setRed = \&Weed::Values::Vec3::setX;
*getRed = \&Weed::Values::Vec3::getX;

=head2 setGreen(g)

Sets the second value of the color.
g is given on [0, 1].

	$c1->setGreen(0.2);

=cut

*setGreen = \&Weed::Values::Vec3::setY;
*getGreen = \&Weed::Values::Vec3::getY;

=head2 setBlue(b)

Sets the third value of the color.
b is given on [0, 1].

	$c1->setBlue(0.3);

=cut

*setBlue = \&Weed::Values::Vec3::setZ;
*getBlue = \&Weed::Values::Vec3::getZ;

=head2 getValue

Returns the value of the color (r, g, b) as a 3 components array.

	@v = $c1->getValue;

=cut

sub getValue { map { Math::clamp( $_, 0, 1 ) } $_[0]->SUPER::getValue }

sub setValue {
	my $this = shift;
	$this->SUPER::setValue( map { Math::clamp( $_, 0, 1 ) } @_ );
	return;
}

=head2 getRed

Returns the first value of the color.

	$r = $c1->getRed;

=cut

=head2 getGreen

Returns the second value of the color.

	$g = $c1->getGreen;

=cut

=head2 getBlue

Returns the third value of the color.

	$b = $c1->getBlue;

=cut

=head2 setHSV(h,s,v)

h is given on [0, 2 PI]. s, v are given on [0, 1].
RGB are each returned on [0, 1].

	$c->setHSV(1/12,1,1);  # 1 0.5 0

=cut

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

=head2 getHSV

h is in [0, 2 PI]. s, v are each returned on [0, 1].

	@hsv = $c->getHSV;

=cut

sub getHSV {
	my ($this) = @_;

	my ( $r, $g, $b ) = $this->getValue;
	my ( $h, $s, $v );

	my $min = Math::min( $r, $g, $b );
	my $max = Math::max( $r, $g, $b );
	$v = $max;    # v

	my $delta = $max - $min;

	if ( $max != 0 && $delta != 0 ) {
		$s = $delta / $max;    # s
	} else {
		# r = g = b = 0                            # s = 0, h is undefined
		return ( 0, 0, 0 );
	}

	if ( $r == $max ) {
		$h = ( $g - $b ) / $delta;    # between yellow & magenta
	} elsif ( $g == $max ) {
		$h = 2 + ( $b - $r ) / $delta;    # between cyan & yellow
	} else {
		$h = 4 + ( $r - $g ) / $delta;    # between magenta & cyan
	}

	$h += 6 if $h < 0;

	$h /= 6;                              # do not optimize
	$h *= Math::PI2;                      # radiants

	return ( $h, $s, $v );
}

sub _add {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0] + $b->[0], 0, 1 );
	$a->[1] = Math::clamp( $a->[1] + $b->[1], 0, 1 );
	$a->[2] = Math::clamp( $a->[2] + $b->[2], 0, 1 );
	return $a;
}

sub _subtract {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0] - $b->[0], 0, 1 );
	$a->[1] = Math::clamp( $a->[1] - $b->[1], 0, 1 );
	$a->[2] = Math::clamp( $a->[2] - $b->[2], 0, 1 );
	return $a;
}

sub _multiply {
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
}

sub _divide {
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
}

sub __mod {
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
}

sub __pow {
	my ( $a, $b ) = @_;
	$a->[0] = Math::clamp( $a->[0]**$b, 0, 1 );
	$a->[1] = Math::clamp( $a->[1]**$b, 0, 1 );
	$a->[2] = Math::clamp( $a->[2]**$b, 0, 1 );
	return $a;
}

sub _cross {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2 ) = @$a;
	my ( $b0, $b1, $b2 ) = @$b;

	$a->[0] = Math::clamp( $a1 * $b2 - $a2 * $b1, 0, 1 );
	$a->[1] = Math::clamp( $a2 * $b0 - $a0 * $b2, 0, 1 );
	$a->[2] = Math::clamp( $a0 * $b1 - $a1 * $b0, 0, 1 );

	return $a;
}

=head2 inverse

Returns the inverse of the color.
This is used to overload the '~' operator.

	$v = new Math::Color(0, 0.1, 1);
	$v = $v1->inverse;  # 1 0.9 0
	$v = -$v1;         # 1 0.9 0

=cut

sub inverse {
	my ($a) = @_;
	return $a->new( [
			1 - $a->[0],
			1 - $a->[1],
			1 - $a->[2],
	] );
}

=head2 toString

Returns a string representation of the color. This is used
to overload the '""' operator, so that color may be
freely interpolated in strings.

	my $c = new Math::Color(0.1, 0.2, 0.3);
	print $c->toString; # "0.1, 0.2, 0.3"
	print "$c";         # "0.1, 0.2, 0.3"

=cut

1;

=head1 SEE ALSO

L<PDL> for scientific and bulk numeric data processing and display

L<Math>

L<Math::Vectors>

L<Math::Color>, L<Math::ColorRGBA>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>

=head1 BUGS & SUGGESTIONS

If you run into a miscalculation or need some sort of feature please drop the author a note.

=head1 ARRANGED BY

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

This is free software; you can redistribute it and/or modify it
under the same terms as L<Perl|perl> itself.

=cut

