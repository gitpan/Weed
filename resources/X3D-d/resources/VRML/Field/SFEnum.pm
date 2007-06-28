package VRML::Field::SFEnum;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return uc ${$this};
}

1;
__END__
