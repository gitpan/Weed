package SFString;
use strict;
use warnings;

use rlib "../";

BEGIN {
	our $VERSION = '0.00';

	use DynaLoader;
	our @ISA = qw(DynaLoader);
	sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }

	# now load the XS code.
	__PACKAGE__->bootstrap($VERSION);
}

# Preloaded methods go here.

use X3DGenerator;

use overload
  "<=>" => sub { $_[0]->getValue cmp $_[1] },
  "=="  => sub { $_[0]->getValue eq $_[1] },
  "!="  => sub { $_[0]->getValue ne $_[1] },

  "cmp" => sub { $_[0]->getValue cmp $_[1] },
  "eq"  => sub { $_[0]->getValue eq $_[1] },
  "ne"  => sub { $_[0]->getValue ne $_[1] },

  "0+" => sub { sprintf "%g", $_[0]->getValue },
  '""' => \&toString,
  ;

sub toString {
	return sprintf $X3DGenerator::STRING, $_[0]->getValue;
}

1;
__END__


use Benchmark qw(timethis);

my $f = new SFString("as0.1");
my $n = new SFString(0.1);
timethis (2000000, sub { $f = new SFString(0.1) });
#timethis (2000000, sub { $f = new SFColor(1,2,3) });
#timethis (2000000, sub { $f = $f + 0.1 });
#timethis (2000000, sub { $f += 0.1 });
#timethis (2000000, sub { $f = $f->add($n) });
#timethis (2000000, sub { $f += $n });
#timethis (2000000, sub { $n = new SFColor; });

printf "%s\n", $f;
