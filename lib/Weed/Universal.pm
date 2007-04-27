package Weed::Universal;
use strict;
use warnings;

our $VERSION = '0.0009';

use Class::ISA;
use Scalar::Util;
use Attribute::Overload;
use Time::HiRes 'time';

use base 'UNIVERSAL';
use package "X3DUniversal", 'time';

sub NEW { bless $_[1], $_[0]->PACKAGE }

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

use strict 'refs';

sub PACKAGE { ref( $_[0] ) || $_[0] }

sub PATH { reverse Class::ISA::self_and_super_path( PACKAGE( $_[0] ) ) }

sub SUPER { $_[0]->ARRAY("ISA")->[0] }

*ID = \&Scalar::Util::refaddr;

1;
__END__

sub CAN {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::CAN::%s", $this->PACKAGE, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { \&{"${_}::${name}"} }
		  grep { exists &{"${_}::${name}"} } $this->ISA;
	}

	wantarray ? @$$property : $$property;
}

sub SUB {
	my ($this, $name) = (shift, shift);
	return map { &$_( $this, @_ ) } $this->CAN($name);
}

#sub IS_IN { !index( PACKAGE( $_[0] ), PACKAGE( $_[1] ) . '::' ) }
