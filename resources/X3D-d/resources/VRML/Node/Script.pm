package VRML::Node::Script;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Node::Node;
push @ISA, qw(VRML::Node::Node);

use VRML::Generator qw($TIDY_SPACE $TIDY_BREAK $BREAK $SPACE indent $SCRIPT_FIELD_CLASS $FIELD_TYPE $FIELD_TYPE $DEEP);

sub fieldsToString {											
	my $this = shift;									

	my $string = '';
	my @fields;				

	foreach (@{$this->{fields}}) {
		next if exists $this->getProto->{field}->{$_->{name}};
		my $field;

		$field .= sprintf $SCRIPT_FIELD_CLASS, $_->{class};
		$field .= sprintf $FIELD_TYPE, $_->{type};
		$field .= $_->{name};

		if (ref $_->{value} eq "REF") {
			$field .= " IS " . ${$_->{value}}->{name};
		} elsif ($_->{class} =~ /^field|exposedField$/) {
			$field .= $SPACE;
			if (ref $_->{value} eq "SFString") {
				$field .= "\"$_->{value}\"";
			} else {
				$field .= $_->{value};
			}
		}
		push @fields, $field;
	}

	if (@fields) {
		$string .= $TIDY_BREAK.indent;
		$string .= join $BREAK.indent, @fields;
	}

	return $string . $this->SUPER::fieldsToString;
}

1;
__END__
	if (@{$this->{fields}}) {
		$string .= $TIDY_BREAK.indent;
		$string .= join $BREAK.indent, grep {$_} map {
			my $value = '';
			if (exists $_->{value}) {
				if (exists $_->{is}) {
					$value .= $SPACE;
					$value .= "IS".$SPACE.$_->{is};
				} else {
					$value .= $SPACE;
					if (ref $_->{value} eq "SFString" && !$_->{value}->IS) {
						$value .= "\"";
						$value .= $_->{value};
						$value .= "\"";
					} elsif (ref $_->{value} eq "MFString" && !$_->{value}->IS) {
						$value .= $_->{value};
					} else {
						$value .= $_->{value};
					}
				}
			}

			#print STDERR $this;
			((!exists $this->getProto->{field}->{$_->{name}}) &&
				(sprintf $SCRIPT_FIELD_CLASS, $_->{class}).
				(sprintf $FIELD_TYPE, $_->{type})). $_->{name}.$value

		} @{$this->{fields}};
	}
