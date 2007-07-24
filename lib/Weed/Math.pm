package Weed::Math;
use Weed::Perl;

our $VERSION = '0.009';

use Package::Alias X3DMath => __PACKAGE__;

use Exporter 'import';

use POSIX ();
*acos  = \&POSIX::acos;
*asin  = \&POSIX::asin;
*atan  = \&POSIX::atan;
*ceil  = \&POSIX::ceil;
*floor = \&POSIX::floor;
*fmod  = \&POSIX::fmod;
*log10 = \&POSIX::log10;
*pow   = \&POSIX::pow;
*tan   = \&POSIX::tan;

our @POSIX = qw(
  acos
  asin
  atan
  ceil
  floor
  fmod
  log10
  pow
  tan
);

our @CONSTANTS = qw(
  E
  LN10
  LN2
  PI
  PI1_4
  PI1_2
  PI3_4
  PI2
  SQRT1_2
  SQRT2
);

our @FUNCTIONS = qw(
  even
  max
  min
  clamp
  odd
  pro
  random
  round
  sig
  sum
);

our @EXPORT_OK = ( @CONSTANTS, @FUNCTIONS, @POSIX );

our %EXPORT_TAGS = (
	all       => \@EXPORT_OK,
	constants => \@CONSTANTS,
	functions => [ @FUNCTIONS, @POSIX ],
);

use constant E    => CORE::exp(1);
use constant LN10 => CORE::log(10);
use constant LN2  => CORE::log(2);

use constant PI    => CORE::atan2( 0, -1 );    #arg(-1+i*0)
use constant PI1_4 => CORE::atan2( 1, 1 );
use constant PI1_2 => CORE::atan2( 1, 0 );
use constant PI3_4 => CORE::atan2( 1, -1 );
use constant PI2   => PI * 2;

use constant SQRT1_2 => CORE::sqrt( 1 / 2 );
use constant SQRT2   => CORE::sqrt(2);

sub abs ($) { CORE::abs( $_[0] ) }
sub atan2 { CORE::atan2( $_[0], $_[1] ) }

sub cos ($) { CORE::cos( $_[0] ) }

sub exp ($) { CORE::exp( $_[0] ) }
sub log ($) { CORE::log( $_[0] ) }

sub min {
	@_ = sort { $a <=> $b } @_;
	shift;
}

sub max {
	@_ = sort { $a <=> $b } @_;
	pop;
}

sub clamp { min( max( $_[0], $_[1] ), $_[2] ) }

sub pro {
	my $pro = 1;
	$pro *= $_ foreach @_;
	return @_ ? $pro : 0;
}

sub random {
	@_ = sort { $a <=> $b } @_;
	return $_[0] + rand( $_[1] - $_[0] ) if @_ == 2;
	return rand(@_);
}

sub round {
	return int( $_[0] + ( $_[0] < 0 ? -0.5 : 0.5 ) )
		if @_ == 1 || $_[1] == 0;

	return 0+ sprintf "%.$_[1]f", $_[0] if $_[1] >= 0;

	my $f = 10**-$_[1];
	return round( $_[0] / $f ) * $f;
}

sub sig ($) { $_[0] ? ( $_[0] < 0 ? -1 : 1 ) : 0 }

sub sum {
	my $sum = 0;
	$sum += $_ foreach @_;
	return $sum;
}

sub sin ($) { CORE::sin( $_[0] ) }
sub sqrt($) { CORE::sqrt( $_[0] ) }

sub even($) { $_[0] & 1 ? 0 : 1 }
sub odd ($) { $_[0] & 1 }

sub xsum {
	my $Zahl  = shift;
	my $Basis = shift || 10;
	my $Quer  = 0;
	while ($Zahl) {
		$Quer = $Quer + ( $Zahl % $Basis );
		$Zahl = int( $Zahl / $Basis );
	}
	return $Quer;
}

sub x {
	my $Zahl = shift;
	my $Basis = shift || 10;
	while ( $Zahl >= $Basis ) {
		my $Quer = 0;
		while ($Zahl) {
			$Quer = $Quer + ( $Zahl % $Basis );
			$Zahl = int( $Zahl / $Basis );
		}
		$Zahl = $Quer;
	}
	return $Zahl;
}

1;

=head1 NAME

Weed::Math - constants and functions

=head1 SYNOPSIS

	use Weed::Math ':all';
	use Weed::Math ':constants';
	use Weed::Math ':functions';

	printf "2.71828182845905 = %s\n", E;
	printf "1.5707963267949  = %s\n", PI1_2;
	
	printf "1 = %s\n", round(0.5);
	printf "1 = %s\n", ceil(0.5);
	printf "0 = %s\n", floor(0.5);

	or 

	use Math;

	printf "%s\n", X3DMath::PI;
	printf "%s\n", X3DMath::round(0.5);

=head1 SEE ALSO

L<perlfunc> Perl built-in functions

L<POSIX>

=head1 Constants

=head2 E

	Euler's constant, e, approximately 2.718

=head2 LN10

	Natural logarithm of 10, approximately 2.302

=head2 LN2

	Natural logarithm of 2, approximately 0.693

=head2 PI

Ratio of the circumference of a circle to its diameter, approximately 3.1415
or L<atan2|http://perldoc.perl.org/search.html?q=atan2>( 0, -1 ).

	PI1_2 == PI * 1/2

=head2 SQRT1_2

	square root of 1/2, approximately 0.707

=head2 SQRT2

	square root of 2, approximately 1.414

=cut

=head1 Functions

Note number, number1, number2, base, and exponent indicate any expression with a scalar value.

=head2 abs(number)

	Returns the absolute value of number

=head2 acos(number)

	Returns the arc cosine (in radians) of number

=head2 asin(number)

	Returns the arc sine (in radians) of number

=head2 atan(number)

	Returns the arc tangent (in radians) of number

=head2 atan2(number1, number2)

	perls atan2

=head2 ceil(number)

	Returns the least integer greater than or equal to number

=head2 cos(number)

	Returns the cosine of number where number is expressed in radians

=head2 exp(number)

	Returns e, to the power of number (i.e. enumber)

=head2 even(number)

	Returns 1 if number is even otherwise 0

=head2 floor(number)

	Returns the greatest integer less than or equal to its argument

=head2 fmod(number, number)

	POSIX fmod

=head2 log(number)

	Returns the natural logarithm (base e) of number

=head2 log10(number)

	Returns the logarithm (base 10) of number

=head2 min(number1, number2)

	Returns the lesser of number1 and number2

=head2 max(number1, number2)

	Returns the greater of number1 and number2

=head2 clamp(number, min, max)

	Returns number between or equal min and max

=head2 odd(number)

	Returns 1 if number is odd otherwise 0

=head2 pro(number, number1, number2, ...)

	Returns the product of its arguments

	pro(1,2,3) == 1 * 2 * 3;
	my $product = pro(@array);

=head2 pow

Computes $x raised to the power $exponent .

	$ret = POSIX::pow( $x, $exponent );

You can also use the ** operator, see L<perlop>.

=head2 random

Returns a pseudo-random number between 0 and 1.

	$ret = random();

Returns a pseudo-random number between 0 and $number1.

	$ret = random($number1);

Returns a pseudo-random number between number1 and number2.

	$ret = random($number1, $number2);

=head2 round

Returns the value of $number rounded to the nearest integer

	$ret = round($number);

Returns the value of $number rounded to the nearest float point number.

	$ret = round($number, $digits);

	round(0.123456, 2) == 0.12;

	round(50, -2)   == 100;
	round(5, -1)    == 10;
	round(0.5)      == 1;
	round(0.05, 1)  == 0.1;
	round(0.005, 2) == 0.01;

=head2 sig(number)

	Returns 1 if number is greater 0.
	Returns -1 if number is lesser 0 otherwise -1.

=head2 sin(number)

	Returns the sine of number where number is expressed in radians

=head2 sqrt(number)

	Returns the square root of its argument

=head2 sum(number, number1, number2, ...)

Returns the sum of its arguments

	sum(1..3) == 1 + 2 + 3;
	my $sum = sum(@array);

=head2 tan(number)

Returns the tangent of number, where number is expressed in radians

=head2 x(number, base=10)

Returns the L<digital_root|http://de.wikipedia.org/wiki/Quersumme> of number to base

=cut

=head1 SEE ALSO

L<perlfunc> Perl built-in functions

L<POSIX>

=head1 BUGS & SUGGESTIONS

If you run into a miscalculation please drop the author a note.

=head1 ARRANGED BY

HOOO@cpan.org

=head1 COPYRIGHT

This is free software; you can redistribute it and/or modify it
under the same terms as L<Perl|perl> itself.

=cut
