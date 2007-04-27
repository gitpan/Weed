package Weed::Parser::Description;
use strict;
use warnings;
use package;

use Carp;
$Carp::CarpLevel = 1;

our $VERSION = '0.0109';

use Weed::Parser::Symbols qw($_ObjectDescription $_FieldDescription $_whitespace $_break);

sub parse ($\$) {
	my ( $package, $string ) = @_;

	if ( $string =~ /$_ObjectDescription/gc ) {
		my ( $alias, $superclasses, $fieldDescriptions ) = ( $1, $2, $3 );
		return unless $alias;

		package::alias($alias, $package);

		if ($@) {
			carp "Could not parse description in package '$package'\n\t$@";
		} else {

			if ($superclasses) {
				unshift @{ $package->ARRAY("ISA") }, &superClasses($superclasses);
				return carp "Could not parse description in package '$package'\n\t$@" if $@;
			}

			my $fieldDescriptions = &fieldDescriptions( $package, $fieldDescriptions );
			if (@$fieldDescriptions) {
				${ $package->SCALAR("FieldDescriptions") } = $fieldDescriptions;
			}
		}
	} else {
		carp "Could not parse description in package '$package'\n\t$@";
	}

	return;
}

sub superClasses (\$) { split /$_whitespace+/, $_[0] }

sub fieldDescriptions (\$\$) {
	my ( $package, $string ) = @_;

	my $fieldDescriptions = [];

	foreach ( split /$_break+/, $string ) {
		my $fieldDescription = &fieldDescription( $package, $_ );
		if ( ref $fieldDescription ) {
			push @$fieldDescriptions, $fieldDescription;
		}
	}

	return $fieldDescriptions;
}

sub fieldDescription (\$\$) {
	my ( $package, $string ) = @_;

	if ( $string =~ /$_FieldDescription/gc ) {
		#my ( $type, $in, $out, $name, $value ) = ( $1, $2, $3, $4, $5 );
		return [ $1, $2, $3, $4, $5 ];
	}

	return;
}

1;
__END__
