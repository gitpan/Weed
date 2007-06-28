package VRML::Field::SFInt32;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return sprintf "%d", int(${$this});
}

1;
__END__
