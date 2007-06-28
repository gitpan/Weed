package VRML2::Math;
use strict;

BEGIN {
	use Carp;
	use POSIX qw();

	use vars qw(@ISA @EXPORT_OK);
	@ISA = qw(Exporter);

	@EXPORT_OK = qw(
		abs
		acos
		asin
		atan
		ceil
		cos
		pow
		exp
		floor
		log
		min
		max
		round
		sin
		sqrt
		tan
	);
}

use constant E  => 2.718281828459045235360287471352662497757247;
use constant PI => 3.141592653589793238462643383279502884197168;

sub abs   { CORE::abs $_[0] }
sub acos  { POSIX::acos $_[0] }
sub asin  { POSIX::asin $_[0] }
sub atan  { POSIX::atan $_[0] }
sub ceil  { POSIX::ceil $_[0] }
sub cos   { CORE::cos $_[0] }
sub pow   { $_[0] ** $_[1] }
sub exp   { CORE::exp $_[0] }
sub floor { POSIX::floor $_[0] }
sub log   { CORE::log $_[0] }
sub min   { $_[0] < $_[1] ? $_[0] : $_[1] }
sub max   { $_[0] > $_[1] ? $_[0] : $_[1] }
sub round { POSIX::round $_[0] }
sub sin   { CORE::sin $_[0] }
sub sqrt  { CORE::sqrt $_[0] }
sub tan   { POSIX::tan $_[0] }

1;
__END__
