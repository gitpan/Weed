package VRML2::Event::exposedField;
use strict;

BEGIN {
	use Carp;

	use VRML2::Event;

	use VRML2::Generator;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Event);
}

use overload
	'""'   => \&toString;

sub toString {
	my $this = shift;
	my $string = '';

	my $space2 = -8 * length $TSPACE;

	if (ref $this->{value}) {
		$string =  sprintf "exposedField %".$space2."s %s$TAB%s",
			$this->{type},
			$this->{name},
			$this->{value};
	} else {
		$string =  sprintf "exposedField %".$space2."s %s",
			$this->{type},
			$this->{name};
	}

	return $string;
}

1;
__END__
