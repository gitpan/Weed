package VRML2::EventTypes;
use strict;

BEGIN {
	use Carp;
}

# This class should never need to be instantiated

1;
# SFields

package eventIn;
use vars qw(@ISA);
use VRML2::Event::eventIn;
@ISA = qw(VRML2::Event::eventIn);
1;

package eventOut;
use vars qw(@ISA);
use VRML2::Event::eventOut;
@ISA = qw(VRML2::Event::eventOut);
1;

package exposedField;
use vars qw(@ISA);
use VRML2::Event::exposedField;
@ISA = qw(VRML2::Event::exposedField);
1;

package field;
use vars qw(@ISA);
use VRML2::Event::field;
@ISA = qw(VRML2::Event::field);
1;

__END__
