package VRML2::Field::SFString;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(VRML2::Field);
}

use overload
	"<=>"  => \&ncmp,
	"=="   => \&neq,
	"!="   => \&nne,

	"cmp"  => \&cmp,
	"eq"   => \&eq,
	"ne"   => \&ne,

	'""' => \&toString;

sub ncmp { $_[0] cmp $_[1] }
sub neq  { $_[0] eq $_[1] }
sub nne  { $_[0] ne $_[1] }

sub cmp { $_[1] cmp ${$_[0]} }
sub eq  { $_[1] eq ${$_[0]} }
sub ne  { $_[1] ne ${$_[0]} }

sub toString {
	my $this = shift;
	return sprintf "\"%s\"", ${$this};
}


1;
__END__
