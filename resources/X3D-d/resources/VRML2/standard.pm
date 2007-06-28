package VRML2::standard;
use strict;

BEGIN {
	use Carp;

	use vars qw(@ISA @EXPORT);
	use Exporter;

	use VRML2::standard::VRML97;
	use VRML2::standard::CosmoWorlds;

	@ISA = qw(Exporter);
	@EXPORT = qw($VRML97 $COSMOWORLDS);
}

1;
__END__
