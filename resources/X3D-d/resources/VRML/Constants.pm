package VRML::Constants;
require 5.005;
use strict;
use Carp;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT @EXPORT_OK);
	@ISA = qw(Exporter);
	@EXPORT = qw(TRUE FALSE NULL);
	@EXPORT_OK = qw(header cosmo_header mime_type);
}

sub header { "#VRML V2.0 utf8\n\n" }
sub cosmo_header { "#VRML V2.0 utf8 CosmoWorlds V1.0\n\n" }
sub mime_type { 'x-world/x-vrml' }

use constant TRUE  => 1;
use constant FALSE => '';
use constant NULL  => '';

1;
__END__
