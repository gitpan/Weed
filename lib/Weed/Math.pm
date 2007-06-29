package Weed::Math;
use Weed::Perl;

use Package::Alias Math => __PACKAGE__;

our $VERSION = '0.0036';

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

sub abs { CORE::abs( $_[0] ) }
sub atan2 { CORE::atan2( $_[0], $_[1] ) }

sub cos { CORE::cos( $_[0] ) }

sub exp { CORE::exp( $_[0] ) }
sub log { CORE::log( $_[0] ) }

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
	return int( $_[0] + ( $_[0] < 0 ? -0.5 : 0.5 ) ) if @_ == 1 || $_[1] == 0;    # @_ == 1 || $_[1] == 0;
	return sprintf "%.$_[1]f", $_[0] if $_[1] >= 0;

	my $f = 10**-$_[1];
	return round( $_[0] / $f ) * $f;
}

sub sig { $_[0] ? ( $_[0] < 0 ? -1 : 1 ) : 0 }

sub sum {
	my $sum = 0;
	$sum += $_ foreach @_;
	return $sum;
}

sub sin  { CORE::sin( $_[0] ) }
sub sqrt { CORE::sqrt( $_[0] ) }

sub even { $_[0] & 1 ? 0 : 1 }
sub odd { $_[0] & 1 }

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
