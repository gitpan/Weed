package VRML;
require 5.005;
use strict;
use Carp;

BEGIN {
	use VRML::Constants;
	use VRML::Functions;
	use VRML::Browser;
	use Array;

	use constant Browser => new VRML::Browser;
	
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(
		Browser
		FALSE TRUE NULL
		parseInt parseFloat
	);
}

1;
__END__
sub new {
	my $self = shift;
	return new VRML::Browser(@_);
}

