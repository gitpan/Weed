package VRML2::Field::SFFloat;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;

	use VRML2::Generator;

	use VRML2::Console;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);

}

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	#print CONSOLE " VRML2::Field::SFFloat::toString\n";

	return sprintf "%s", (sprintf $FLOAT, ${$this}) +0;
}

1;
__END__
