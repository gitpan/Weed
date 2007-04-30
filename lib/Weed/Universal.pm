package Weed::Universal;
use strict;
use warnings;

use Class::ISA;
use Scalar::Util;
use Attribute::Overload;
use Time::HiRes 'time';

use Weed::Constants;
use Weed::Parse::Concept;

use base 'UNIVERSAL';
use package "X3DUniversal", qw'time';

sub import {
	shift;
	return unless @_;
	my $package = caller;
	IMPORT( $package, ['X3DUniversal'], @_ );
}

sub IMPORT {
	my ( $package, $supertypes, $description ) = @_;

	#printf "X3DUniversal import %s\n", $package;

	SUPERTYPES( $package, $supertypes );
	DESCRIPTION( $package, $description );
}

sub DESCRIPTION {
	my ( $package, $string ) = @_;

	return unless defined $string;

	#printf "DESCRIPTION *** %s\n", $package;

	#printf "import public *** %s -> %s\n", $package, $string;

	my $description = parse::Concept($string);
	if ( ref $description ) {

		package::alias( $description->{name}, $package );
		SUPERTYPES( $package, $description->{supertypes} );

		$package->setDescription($description)
		  if $package->can("setDescription");
	}

	return;
}

sub SUPERTYPES {
	my ( $package, $supertypes ) = @_;
	unshift @{ ARRAY( $package, "ISA" ) }, @$supertypes;
}

sub NEW { bless $_[1], PACKAGE( $_[0] ) }

no strict 'refs';
no warnings;

sub SCALAR {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', PACKAGE($this), $name;
	return \$$property;
}

use warnings;

sub ARRAY {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', PACKAGE($this), $name;
	return \@$property;
}

sub HASH {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', PACKAGE($this), $name;
	return \%$property;
}

sub CAN {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::CAN::%s", $this->PACKAGE, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { \&{"${_}::${name}"} }
		  grep { exists &{"${_}::${name}"} } reverse PATH($this);
	}

	return @$$property;
}

use strict 'refs';

sub SUB { ( caller(1) )[3] }

sub PACKAGE { ref( $_[0] ) || $_[0] }

sub PATH { reverse Class::ISA::self_and_super_path( PACKAGE( $_[0] ) ) }

sub SUPER { ARRAY( $_[0], "ISA" )->[0] }

*ID = \&Scalar::Util::refaddr;

sub CALL {
	my ( $this, $name ) = ( shift, shift );
	return map { &$_( $this, @_ ) } CAN( $this, $name );
}

sub REVERSE_CALL {
	my ( $this, $name ) = ( shift, shift );
	return map { &$_( $this, @_ ) } reverse CAN( $this, $name );
}

sub DESTROY { CALL( $_[0], "dispose" ); 0; }

1;
__END__


#sub IS_IN { !index( PACKAGE( $_[0] ), PACKAGE( $_[1] ) . '::' ) }
