package VRML2::Field::SFTime;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;

	use VRML2::Generator;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	'""' => \&toString;

sub setValue {
	my $this = shift;
	${$this} = @_ ? ref $_[0] ? ${$_[0]} : $_[0] : -1;
	return ${$this};
}

sub toString {
	my $this = shift;
	return sprintf "%s", (sprintf $DOUBLE, ${$this}) +0;
}

1;
__END__
