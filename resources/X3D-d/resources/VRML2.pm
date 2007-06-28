package VRML2;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use VRML2::Browser;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);

	@EXPORT = qw(
		Browser
		TRUE FALSE
		parseInt parseFloat
		NULL
	);
}

use constant Browser => new VRML2::Browser;

1;
__END__
