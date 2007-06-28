package VRML2::VrmlScript;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use VRML2::Parser::Symbols qw($_int32 $_double);

	use VRML2::Console;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(
		Exporter
	);

	@EXPORT = qw(TRUE FALSE parseInt parseFloat NULL);
}

use constant TRUE  => 1;
use constant FALSE => '';
use constant NULL  => '';


sub parseInt {
	my $string = shift;
	my $base   = shift || 10;
	return $string =~ /$_int32/ ? int($1) : 0;
}

sub parseFloat {
	my $string = shift;
	return $string =~ /$_double/ ? $1+0 : 0;
}

1;


__END__
