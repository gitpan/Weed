package Weed::Parse::Concept;
use Weed::Perl;

our $VERSION = '0.011';

use Carp (); $Carp::CarpLevel = 1;

use Weed::Tie::WeakHash;

use Weed::RegularExpressions;

use Weed::Parse::Id qw.RestrictedIds RestrictedId.;
use Weed::Parse::String 'string';
use Weed::Parse::Double 'double';

sub parse {
	my ($string) = @_;
	return unless defined $string;
	my $statement = eval { &conceptStatement( \$string ) };
	#die "Error Parse::Concept: '$string'\n", $@ if $@;
	return $statement;
}

sub conceptStatement {
	my ($string) = @_;

	my $name = &RestrictedId($string);

	if ( defined $name ) {

		my $supertypes;

		if ( $$string =~ m.$_colon_test.gc ) {

			$supertypes = &RestrictedIds($string);

			die "No supertypes after ':'" unless @$supertypes;

		}
		else {

			$supertypes = [];

			die "Expected ' : '" if $$string =~ m.$_colon.gc;
		}

		if ( $$string =~ m.$_open_brace.gc ) {

			my $body = &body($string);

			if ( $$string =~ m.$_close_brace.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub { bless {}, $_[0] },
					body       => $body,
				};

			}
			else {
				die "Expected '}'";
			}

		}

		elsif ( $$string =~ m.$_open_bracket.gc ) {

			#my $body = &body($string);

			if ( $$string =~ m.$_close_bracket.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub { bless $_[1] || [], $_[0] },
					#body       => $body,
				};

			}
			else {
				die "Expected ']'";
			}
		}
		elsif ( $$string =~ m.$_open_parenthesis.gc ) {
			my $value;
			$value = string($string);
			$value = double($string) unless defined $value;

			#$value = Weed::Parse::FieldValue::null( \"$$string" ) unless defined $value;
			if ( $$string =~ m.$_close_parenthesis.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub { bless \$value, $_[0] },
					#body  	  => $body,
				};
			}
			else {
				die "Expected ')'";
			}
		}

		return {
			typeName   => $name,
			supertypes => $supertypes,
			new        => sub () { die "Package 'does not have a default value"; },
			#body  	  => $body,
		} unless $@;
		#		else {
		#			die "Expected '{' or '['";
		#		}

	}
	else {
		die "Expected a package name\n";
	}

	return;
}

sub body {
	my ($string) = @_;

	return '' if $$string =~ m.$_close_brace_test.gc;

	return $1 if $$string =~ m.$_ConceptBody.gc;

	die "Expected '{ ... }'";
	#die "Expected '}'";
	return;
}

1;
__END__

#use Data::Validate::URI qw(is_http_uri);
#use URI2::Heuristic qw(uf_urlstr); ???
#use LWP::Simple;
