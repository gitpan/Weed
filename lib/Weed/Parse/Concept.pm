package Weed::Parse::Concept;
use Weed::Perl;

use Carp (); $Carp::CarpLevel = 1;

use Weed::RegularExpressions;
use Weed::Parse::Id;

# Description

sub parse {
	my ($string) = @_;
	return unless defined $string;
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

			Carp::croak "No supertypes after ':'" unless @$supertypes;

		} else {

			$supertypes = [];

			Carp::croak "Expected ' : '" if $$string =~ m.$_colon.gc;
		}

		if ( $$string =~ m.$_open_brace.gc ) {

			my $body = &body($string);

			if ( $$string =~ m.$_close_brace.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					body       => $body,
				};

			} else {
				Carp::croak "Expected '}'";
			}

		} else {
			Carp::croak "Expected '{'";
		}

	} else {
		Carp::croak "Expected package name\n";
	}

	return;
}

sub body {
	my ($string) = @_;

	return [] if $$string =~ m.$_close_brace_test.gc;

	return [ split $_space_break_space, $1 ] if $$string =~ m.$_Body.gc;

	Carp::croak "Expected '}'";
	return;
}

1;
__END__

	if ( $string =~ /$_ObjectDescription/gc ) {
		my ( $alias, $superclasses, $fieldDescriptions ) = ( $1, $2, $3 );
		return unless $alias;

		Weed::Package::alias( $alias, $package );

		if ($@) {
			COULD_NOT_PARSE_DESCRIPTION_IN_PACKAGE $package;
		} else {

			if ($superclasses) {
				unshift @{ $package->Weed::Package::arrray("ISA") }, &superClasses($superclasses);
				return COULD_NOT_PARSE_DESCRIPTION_IN_PACKAGE $package if $@;
			}

			my $fieldDescriptions = &Descriptions($fieldDescriptions);
			if (@$fieldDescriptions) {
				${ $package->Weed::Package::scalar("FieldDescriptions") } = $fieldDescriptions;
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

