package VRML::BuiltIns;
require 5.005;
use strict;
use Carp;

BEGIN {
	use vars qw(@ISA @EXPORT);
	use Exporter;
	@ISA = qw(Exporter);
	@EXPORT = qw(@BUILT_INS);
}

use VRML::BuiltIns::VRML97;
use VRML::BuiltIns::CosmoWorlds;

use vars @EXPORT;
@BUILT_INS = ($VRML97, $COSMOWORLDS) unless defined @BUILT_INS;

1;
__END__
