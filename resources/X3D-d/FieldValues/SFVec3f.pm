package SFVec3f;
use strict;
use warnings;

use rlib "../";

BEGIN {
	our $VERSION = '0.00';
	
	use DynaLoader;
	our @ISA = qw(DynaLoader);
	sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }
	# now load the XS code.
	__PACKAGE__->bootstrap ($VERSION);
}

# Preloaded methods go here.

use Array;
use X3DGenerator;
use Attribute::Overload;

use overload
	"<=>" => \&Array::ncmp,
	"=="	=> sub { !($_[0] <=> $_[1]) },
	"!="	=> sub { ($_[0] <=> $_[1]) && 1 },

	"neg"  => \&negate,

	"+"  => \&add,
	"-"  => \&subtract,
	"*"  => \&multiply,
	"/"  => \&divide,

	"."  => \&dot,
	"x"  => \&cross,

	"0+" => \&length,

	"="  => \&copy,
;

sub getArray : Overload(@{}) {
	my $this = shift;
	tie my @a, ref $this, $this;
	return \@a;
}

sub TIEARRAY { $_[1] }
  
sub STORE {
	my $this = shift;
	my $key  = shift;
	return $this->setX(shift) if $key == 0;
	return $this->setY(shift) if $key == 1;
	return $this->setZ(shift) if $key == 2;
}
  
sub FETCH {
	my $this = shift;
	my $key  = shift;
	return $this->getX if $key == 0;
	return $this->getY if $key == 1;
	return $this->getZ if $key == 2;
}

sub FETCHSIZE { 3 }

sub toString : Overload("") {
	my ($this) = @_;
	return join $X3DGenerator::SPACE, map {(sprintf $X3DGenerator::FLOAT, $_) +0} $this->getValue;
}

1;
__END__
use Benchmark qw(timethis);

my $v1 = new SFVec3f(1,2,3);
my $v2 = new SFVec3f(2,3,4);

$v1 = $v1->normalize;

printf "%s\n", $v1;
printf "%s\n", $v2;

timethis (1000000, sub { my $v = new SFVec3f });
timethis (1000000, sub { my $v = $v1 + $v2 });
timethis (1000000, sub { my $v = $v1 * 2 });
timethis (1000000, sub { my $v = $v1 x $v2 });
timethis (1000000, sub { my $v = $v1->cross($v2) });

#timethis 1000000:  5 wallclock secs ( 3.82 usr +  0.01 sys =  3.83 CPU) @ 261096.61/s (n=1000000)
#timethis 1000000: 10 wallclock secs ( 8.78 usr +  0.02 sys =  8.80 CPU) @ 113636.36/s (n=1000000)
#timethis 1000000:  8 wallclock secs ( 8.39 usr +  0.04 sys =  8.43 CPU) @ 118623.96/s (n=1000000)
#timethis 1000000: 12 wallclock secs (10.59 usr +  0.14 sys = 10.73 CPU) @ 93196.64/s (n=1000000)

use PDL;

my $p1 = float (1,2,3);
my $p2 = float (2,3,4);

my $v1 = new SFVec3f(1,2,3);
my $v2 = new SFVec3f(2,3,4);
timethis (1000000, sub { my $v = new SFVec3f });
timethis (1000000, sub { my $v = $v1 + $v2 });
timethis (1000000, sub { my $v = $p1 + $p2 });

printf "%s\n", $v1 + $v2;
printf "%s\n", $p1 + $p2;



my $translation0 = new SFVec3f();
my $translation1 = new SFVec3f(1,2,3);
printf "%s %s %s\n", @{ $translation1->getValue };
printf "%s\n", $translation0;
printf "%s\n", $translation1;
printf "%s\n", $translation0->toString;
printf "%s\n", $translation1->toString;


$translation1->x (32);
printf "%s\n", $translation1->x;
printf "%s\n", $translation1->y;
printf "%s\n", $translation1->z;


$translation1->[0] = 123;

printf "%s\n", $translation1->[0];
printf "%s\n", $translation1->[1];
printf "%s\n", $translation1->[2];

printf "%s\n", $translation1->negate;
printf "%s\n", -$translation1;
printf "%g\n", abs($translation1);
printf "%g\n", $translation1;
printf "%s\n", $translation1->normalize;
printf "%g\n", $translation1->normalize;

printf "%s\n", $translation1;
printf "%s\n", $translation1 / 2;
printf "%s\n", $translation1 += $translation1;
printf "%s\n", $translation1;

printf "%g\n", $translation1 == $translation1;
printf "%g\n", $translation1 != $translation1;
1;

#use Hash::NoRef;
#my $var = 123 ;
#$refcnt = Hash::NoRef::SvREFCNT( \$var ) ; ## returns 1

#Hash::NoRef::SvREFCNT_inc(\$var) ; ## adda fake reference, so, it will never die.
#Hash::NoRef::SvREFCNT_dec(\$var) ; ## get back to the normal reference count.
