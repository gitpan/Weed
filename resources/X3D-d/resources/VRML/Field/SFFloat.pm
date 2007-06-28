package VRML::Field::SFFloat;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return ${$this} +0;
}

1;
__END__
