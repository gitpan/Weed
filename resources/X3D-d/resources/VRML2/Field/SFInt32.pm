package VRML2::Field::SFInt32;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return sprintf "%d", int(${$this});
}

1;
__END__
