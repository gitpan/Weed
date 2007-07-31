package Weed::Message;

our $VERSION = '0.01';

use Weed 'X3DMessage';

use Carp ();

sub caller_package    { ( caller(1) )[0] }
sub caller_filename   { ( caller(2) )[1] }
sub caller_line       { ( caller(2) )[2] }
sub caller_subroutine { ( caller(2) )[3] }

sub field_name { substr( $_[0], rindex( $_[0], ':' ) + 1 ) }

sub warn {
	shift;
	$Carp::CarpLevel = shift;
	Weed->warnings::warn(@_);
	return;
}

sub Debug {
	#	return unless $DEBUG;
	shift;
	my $type = ref(shift) || &caller_package;

	return print sprintf
	  "D: %s->%s(%s) called at %s line %s",
	  $type,
	  &field_name(&caller_subroutine),
	  @_ ? join( ", ", @_ ) : '',
	  &caller_filename, &caller_line;
}

sub die {
	shift;
	$Carp::CarpLevel = shift;
	Carp::croak(@_);
	return;
}

# Scalar Field
# sub NotArrayReference {
# 	shift->die( shift,
# 		sprintf 'Not an ARRAY reference',
# 		#UNIVERSAL::isa( $_[0], 'X3DUniversal' ) ? $_[0]->getType : $_[0]
# 	);
# }

# Field
sub CouldNotAssign {
	shift->die( shift,
		sprintf 'Could not assign %s',
		UNIVERSAL::isa( $_[0], 'X3DUniversal' ) ? $_[0]->getType : $_[0]
	);
}

# Vector Field, Array
sub WrongElementCount {
	shift->die( shift,
		sprintf "Could not assign %s, wrong element count. Expected at least %d values",
		UNIVERSAL::isa( $_[0], 'X3DUniversal' ) ? $_[0]->getType : $_[0],
		$_[1]
	);
}

sub IndexOutOfRange {
	shift->die( shift,
		sprintf 'Modification of non-creatable array value attempted, subscript %d',
		$_[1]
	);
}

# Node, SFNode
sub UnknownField {
	shift->die( shift,
		sprintf "Unknown field '%s' in class '%s' named '%s'",
		field_name( $_[1] ),
		$_[0]->getType,
		$_[0]->getName
	);
}

sub ValueHasToBeAtLeastOfTypeX3DNode {
	shift->warn( shift,
		sprintf "%s->setValue(%s), value has to be at least of type X3DNode",
		$_[0]->getType,
		overload::StrVal( $_[1] )
	);
}

1;
__END__

use Carp ();
$Carp::CarpLevel = 2;

our $DEBUG = 1;

our $LEVEL = 0;

sub get_toplevel {
	for ( my $i ; ++$i ; ) {
		return $i - 2 unless caller($i);
	}
}

sub package    { ( caller(get_toplevel) )[0] }
sub filename   { ( caller(get_toplevel) )[1] }
sub line       { ( caller(get_toplevel) )[2] }
sub subroutine { ( caller(get_toplevel) )[3] }

sub caller_subroutine { ( caller(2) )[3] }

sub Warning {
	shift;
	return Carp::carp sprintf "%s: %s\n ", "Warning", join ", ", @_ if @_;
	return Carp::carp sprintf "%s\n", &subroutine;
}

sub Error {
	shift;
	return Carp::croak sprintf "%s: %s\n", "Error", join ", ", @_ if @_;
	return Carp::croak sprintf "%s\n", &subroutine;
}

sub UnknownField { $_[0]->Error( sprintf "Unknown field '%s' in class '%s' named '%s'", substr( $_[2], rindex( $_[2], ':' ) + 1 ), $_[1]->getType, $_[1]->getName ) }

sub DontAssignToGetField { $_[0]->Error( sprintf "Dont assign to getField use %s->%s = \$value instead", $_[1]->getTypeName, $_[2] ) }

sub ValueHasToBeAtLeastOfTypeX3DNode { $_[0]->Error( sprintf "%s->setValue(\$value), value has to be at least of type X3DNode", $_[1]->getType ) }

	
my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(1);

sub UnknownObjectId { warn sprintf "Unknown object id '%s'", $_[0] }


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

sub UnknownStatement { Error( sprintf "Unknown statement '%s'", $_[0] ) }
sub UnknownClass     { Error( sprintf "Unknown class '%s'",     $_[0] ) }

sub UnknownNamedNode { Warning( sprintf "Unknown named node '%s'", $_[0] ) }

sub BadRouteSpecification        { Error("Bad ROUTE specification") }
sub RouteTypesDoNotMatch         { Error("ROUTE types do not match") }
sub RouteUnknownDestinationField { Error( sprintf "Bad ROUTE specification.\n Unknown destinationField '%s' in node '%s'", $_[1], $_[0]->getValue->getName ) }
sub RouteUnknownSourceField      { Error( sprintf "Bad ROUTE specification.\n Unknown sourceField '%s' in node '%s'", $_[1], $_[0]->getValue->getName ) }

1;
__END__
