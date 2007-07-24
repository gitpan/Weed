package Weed::Parse::FieldDescription;
use Weed;

our $VERSION = '0.009';

use Weed::RegularExpressions;
use Weed::Parse::Id qw.Ids Id.;

# Definition
# SFNode [in,out] metadata NULL [X3DMetadataObject]

sub parse {
	my $statement = &fieldDescriptions(@_);
	return $statement;
}

sub fieldDescriptions (\@) {
	my (@string) = @_;

	my $fieldDescriptions = [];

	foreach (@string) {
		my $fieldDescription = &fieldDescription( \$_ );
		if ( ref $fieldDescription ) {
			push @$fieldDescriptions, $fieldDescription;
		}
	}

	return $fieldDescriptions;
}

sub fieldDescription {
	my ($string) = @_;
	my $type = &Id($string);

	if ( defined $type ) {

		if ( $$string =~ m.$_open_bracket.gc ) {

			my $in  = &in($string);
			my $out = &out($string);

			if ( $$string =~ m.$_close_bracket.gc ) {

				my $name = &Id($string);
				if ( defined $name ) {

					my $value = Weed::Parse::FieldValue::fieldValue( $type, $string );

					my $range = &range($string);
					
					return [$type, $in, $out, $name, $value, $range];
				}

			} else {
				Carp::croak "Expected ']'";
			}
		} else {
			Carp::croak "Expected '['";
		}

	}

	return;
}

sub in {
	my ($string) = @_;
	return $$string =~ m.$_in.gc ? YES: NO;
}

sub out {
	my ($string) = @_;
	return $$string =~ m.$_out.gc ? YES: NO;
}

sub range {
	my ($string) = @_;
	$$string =~ m.$_whitespace.gc;
	return substr $$string, pos($$string);
}

1;
__END__
