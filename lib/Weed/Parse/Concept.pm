package Weed::Parse::Concept;
use Weed::Perl;

our $VERSION = '0.0078';

use Carp (); $Carp::CarpLevel = 1;
use Object::MultiType;

use Weed::Tie::WeakHash;

use Weed::RegularExpressions;

use Weed::Parse::Id qw.RestrictedIds RestrictedId.;
use Weed::Parse::String 'string';
use Weed::Parse::Double 'double';

sub parse {
	my ($string) = @_;
	return unless defined $string;
	my $statement = eval { &conceptStatement( \$string ) };
	#Carp::croak "Error Parse::Concept: '$string'\n", $@ if $@;
	return $statement;
}

sub conceptStatement {
	my ($string) = @_;

	my $name = &RestrictedId($string);

	if ( defined $name ) {

		my $supertypes;

		if ( $$string =~ m.$_colon_test.gc ) {

			$supertypes = &RestrictedIds($string);

			Carp::croak "No supertypes after ':'" unless @$supertypes;

		}
		else {

			$supertypes = [];

			Carp::croak "Expected ' : '" if $$string =~ m.$_colon.gc;
		}

		if ( $$string =~ m.$_open_brace.gc ) {

			my $body = &body($string);

			if ( $$string =~ m.$_close_brace.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub { bless {}, shift },
					body       => $body,
				};

			}
			else {
				Carp::croak "Expected '}'";
			}

		}
		elsif ( $$string =~ m.$_week_hash.gc ) {

			my $body = &body($string);

			if ( $$string =~ m.$_close_brace.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub {
						bless Weed::Tie::WeakHash->new, shift;
					},
					body => $body,
				};

			}
			else {
				Carp::croak "Expected '}'";
			}

		}

		elsif ( $$string =~ m.$_open_bracket.gc ) {

			#my $body = &body($string);

			if ( $$string =~ m.$_close_bracket.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					new        => sub { bless [], shift },
					#body       => $body,
				};

			}
			else {
				Carp::croak "Expected ']'";
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
					new        => sub { my $scalar = $value; bless \$scalar, shift },
					#body  	  => $body,
				};
			}
			else {
				Carp::croak "Expected ')'";
			}
		}
		elsif ( $$string =~ m.$_open_angle_bracket.gc ) {

			if ( $$string =~ m.$_close_angle_bracket.gc ) {

				return {
					typeName   => $name,
					supertypes => $supertypes,
					base       => 'Object::MultiType',
					new        => sub {
						bless Object::MultiType->new( array => [], hash => {} ), shift
					},
					#body  	  => $body,
				};
			}
			else {
				Carp::croak "Expected ')'";
			}
		}

		return {
			typeName   => $name,
			supertypes => $supertypes,
			new        => sub () { Carp::croak "Package 'does not have a default value"; },
			#body  	  => $body,
		} unless $@;
		#		else {
		#			Carp::croak "Expected '{' or '['";
		#		}

	}
	else {
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

#use Data::Validate::URI qw(is_http_uri);
#use URI2::Heuristic qw(uf_urlstr); ???
#use LWP::Simple;
