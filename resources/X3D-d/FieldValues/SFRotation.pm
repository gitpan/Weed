package SFRotation;
use strict;
use warnings;

use rlib "../";

BEGIN {
	use SFVec3f;

	our $VERSION = '0.00';
	
	use DynaLoader;
	our @ISA = qw(DynaLoader);
	sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }
	# now load the XS code.
	__PACKAGE__->bootstrap ($VERSION);
}

# Preloaded methods go here.

use X3DGenerator;
use Attribute::Overload;

sub toString : Overload("") {
	my ($this) = @_;
	return join $X3DGenerator::SPACE x 2, $this->getAxis, $this->getAngle;
}

1;
__END__

use Benchmark qw(timethis);

#timethis 4000000,  sub { new SFRotation() };
#timethis 4000000,  sub { SFRotation->new(1,2,3, 4)->multiply(new SFRotation(1,2,3, 5)) };
#timethis 4000000,  sub { SFRotation->new(new SFVec3f(0,1,0), new SFVec3f(1,0,0))->multVec(new SFVec3f(0,1,0)) };
timethis 4000000,  sub { SFRotation->new(1,2,3, 40)->slerp(SFRotation->new(1,3,2, 60), 0) };

printf "%s\n", new SFRotation;
printf "%s\n", new SFRotation(new SFVec3f(1,2,3), 4);
printf "%s\n", new SFRotation(new SFVec3f(1,2,3), new SFVec3f(3,2,1));
printf "%s\n", SFRotation->new(new SFVec3f(1,2,3), new SFVec3f(3,2,1))->inverse;
printf "%s\n", new SFRotation(1,2,3, 4);
printf "%s\n", SFRotation->new(new SFVec3f(0,1,0), new SFVec3f(1,0,0))->multVec(new SFVec3f(0,1,0));
printf "%s\n", SFRotation->new(1,2,3, 40)->slerp(SFRotation->new(1,3,2, 60), 0);
#timethis 4000000,  sub { "$r" };

my $h = {};
my $f = new SFRotation($h);
$f->setValue($h);
my $n = new SFRotation($h);
#my $n = new SFRotation(10);

#timethis 2000000, sub { $f->setValue({}) };

printf "%s\n", $f->getReferenceCount;
printf "%s\n", $n;
printf "%d\n", $n;
printf "%s\n", NULL;
printf "%d\n", NULL;

