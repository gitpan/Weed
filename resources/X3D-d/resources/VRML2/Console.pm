package VRML2::Console;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);

	@EXPORT = qw(*CONSOLE);

	open CONSOLE, ">/dev/console";
}

sub print {
	CORE::print CONSOLE @_;
}

END {
	close CONSOLE;
}

1;

__END__
