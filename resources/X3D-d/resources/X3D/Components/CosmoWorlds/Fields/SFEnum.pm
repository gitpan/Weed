package VRML2::Field::SFEnum;
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
	return uc ${$this};
}

1;
__END__
