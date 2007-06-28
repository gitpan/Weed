package VRML2::Field::SFBool;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;

	use VRML2::Console;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	'""' => \&toString;

sub setValue ($$) {
	my $this = shift;
	${$this} = (ref $_[0] ? ${$_[0]} : $_[0]) ? 1 : 0;
	return;
}

sub toString {
	my $this = shift;
	#printf CONSOLE " VRML2::Field::SFBool::toString %s\n", ${$this} ? 'TRUE' : 'FALSE';
	return ${$this} ? 'TRUE' : 'FALSE';
}

1;
__END__
