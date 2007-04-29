package Weed::ConceptParser;
use strict;
use warnings;

use package;

use Carp; $Carp::CarpLevel = 1;
use Perl6::Say;

use Weed::Parser::Symbols;

# Description

sub parse {
	my ($string) = @_;
	my $statement = eval { &conceptStatement( \$string ) };
	return $statement;
}

sub conceptStatement {
	my ($string) = @_;

	my $name = &Id($string);

	if ( defined $name ) {

		my $supertypes;

		if ( $$string =~ m.$_colon_test.gc ) {

			$supertypes = &Ids($string);

			croak "No supertypes after ':'" unless @$supertypes;

		} else {

			$supertypes = [];

			croak "Expected ' : '" if $$string =~ m.$_colon.gc;
		}

		if ( $$string =~ m.$_open_brace.gc ) {

			my $body = &body($string);

			if ( $$string =~ m.$_close_brace.gc ) {

				return {
					name       => $name,
					supertypes => $supertypes,
					body       => $body,
				};

			} else {
				croak "Expected '}'";
			}

		} else {
			croak "Expected '{'";
		}

	} else {
		croak "Expected package name\n";
	}

	return;
}

sub Ids {
	my ($string) = @_;
	my $Id       = &Id($string);
	my $Ids      = [];
	while ( defined $Id ) {
		push @$Ids, $Id;
		$Id = &Id($string);
	}
	return $Ids;
}

sub Id {
	my $string = shift;
	return $1 if $$string =~ m.$_Id.gc;
	return;
}

sub body {
	my ($string) = @_;

	return [] if $$string =~ m.$_close_brace_test.gc;

	return [ split $_space_break_space, $1 ] if $$string =~ m.$_Body.gc;

	croak "Expected '}'";
	return;
}

1;
__END__

	if ( $string =~ /$_ObjectDescription/gc ) {
		my ( $alias, $superclasses, $fieldDescriptions ) = ( $1, $2, $3 );
		return unless $alias;

		package::alias( $alias, $package );

		if ($@) {
			COULD_NOT_PARSE_DESCRIPTION_IN_PACKAGE $package;
		} else {

			if ($superclasses) {
				unshift @{ $package->ARRAY("ISA") }, &superClasses($superclasses);
				return COULD_NOT_PARSE_DESCRIPTION_IN_PACKAGE $package if $@;
			}

			my $fieldDescriptions = &Descriptions($fieldDescriptions);
			if (@$fieldDescriptions) {
				${ $package->SCALAR("FieldDescriptions") } = $fieldDescriptions;
			}
		}
	} else {
		carp "Could not parse description in package '$package'\n\t$@";
	}

	return;

sub superClasses (\$) { split /$_whitespace+/, $_[0] }

sub Descriptions (\$) {
	my ($string) = @_;

	my $fieldDescriptions = [];

	foreach ( split /$_break+/, $string ) {
		my $fieldDescription = &Description($_);
		if ( ref $fieldDescription ) {
			push @$fieldDescriptions, $fieldDescription;
		}
	}

	return $fieldDescriptions;
}

sub Description (\$) {
	my ($string) = @_;

	if ( $string =~ /$_FieldDescription/gc ) {
		#my ( $type, $in, $out, $name, $value ) = ( $1, $2, $3, $4, $5 );
		return [ $1, $2, $3, $4, $5 ];
	}

	return;
}

	#$string = parseHTML( $string, get $string) if is_http_uri $string;

sub parseHTML (\$\$) {
	my ( $url, $html ) = @_;
#use Data::Validate::URI qw(is_http_uri);
#use URI2::Heuristic qw(uf_urlstr); ???
#use LWP::Simple;
#parse( '', 'http://www.web3d.org/x3d/specifications/ISO-IEC-19775-X3DAbstractSpecification/Part01/components/core.html#X3DNode' );
	my $string;

}

