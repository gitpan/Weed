package X3DError;
use strict;
use warnings;
no strict 'refs';

use Carp qw(croak);
$Carp::CarpLevel = 2;

our $DEBUG            = 1;
our $SHOW_LINE_NUMBER = 0;

sub carp {
	Carp::carp(@_), return if $SHOW_LINE_NUMBER;
	printf STDERR "%s\n", @_;
	return;
}

sub Debug {
	return unless $DEBUG;

	my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(1);

	return carp sprintf "%s: (%s) %s", $subroutine, $package, join ", ", @_ if @_;
	return carp sprintf "%s: (%s)", $subroutine, $package;
}

sub Warning {
	my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(1);

	return carp sprintf "%s: %s\n ", "Error", join ", ", @_ if @_;
	return carp sprintf "%s\n", $subroutine;
}

sub Error {
	my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(1);

	return croak sprintf "%s: %s\n", "Error", join ", ", @_ if @_;
	return croak sprintf "%s\n", $subroutine;
}

sub UnknownStatement { Error( sprintf "Unknown statement '%s'", $_[0] ) }
sub UnknownClass     { Error( sprintf "Unknown class '%s'",     $_[0] ) }

sub UnknownNamedNode { Warning( sprintf "Unknown named node '%s'", $_[0] ) }
sub UnknownField { Error( sprintf "Unknown field '%s' in class '%s'", $_[1], $_[0]->getTypeName ) }

sub BadRouteSpecification        { Error("Bad ROUTE specification") }
sub RouteTypesDoNotMatch         { Error("ROUTE types do not match") }
sub RouteUnknownDestinationField { Error( sprintf "Bad ROUTE specification.\n Unknown destinationField '%s' in node '%s'", $_[1], $_[0]->getValue->getName ) }
sub RouteUnknownSourceField      { Error( sprintf "Bad ROUTE specification.\n Unknown sourceField '%s' in node '%s'", $_[1], $_[0]->getValue->getName ) }

1;
__END__
