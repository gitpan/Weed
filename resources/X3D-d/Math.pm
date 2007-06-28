package Math;
use strict;
use warnings;

use POSIX ();
	
use constant E       => 2.718281828459045235360287471352662497757247;
use constant LN10    => 2.302585092994045684017991454684;
use constant LN2     => 0.693147180559945309417232121458;
use constant PI      => 3.141592653589793238462643383279502884197168;
use constant SQRT1_2 => 0.707106781186547524400844362105;
use constant SQRT2   => 1.41421356237309504880168872421;

sub abs    { CORE::abs $_[0] }
sub acos   { POSIX::acos $_[0] }
sub asin   { POSIX::asin $_[0] }
sub atan   { POSIX::atan $_[0] }
sub ceil   { POSIX::ceil $_[0] }
sub cos    { CORE::cos $_[0] }
sub exp    { CORE::exp $_[0] }
sub floor  { POSIX::floor $_[0] }
sub log    { CORE::log $_[0] }
sub max    { $_[0] > $_[1] ? $_[0] : $_[1] }
sub min    { $_[0] < $_[1] ? $_[0] : $_[1] }
sub minmax { min(max($_[0], $_[1]), $_[2]) }
sub pow    { $_[0] ** $_[1] }
sub random { rand }
sub round  { POSIX::round $_[0] }
sub sin    { CORE::sin $_[0] }
sub sqrt   { CORE::sqrt $_[0] }
sub tan    { POSIX::tan $_[0] }

1;
__END__
