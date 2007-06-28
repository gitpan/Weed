package VRML::Field::SFBool;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	'""' => \&toString;

sub setValue {
	my $this = shift;
	$this->SUPER::setValue(@_ ? @_ : 0);
}

sub toString {
	my $this   = shift;
	return ${$this} ? 'TRUE' : 'FALSE';
}

1;
__END__
