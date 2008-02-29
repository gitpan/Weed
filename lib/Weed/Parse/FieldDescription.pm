package Weed::Parse::FieldDescription;
use Weed;

our $VERSION = '0.011';

use Weed::RegularExpressions;
use Weed::Parse::Id qw.Ids Id.;
use Weed::Parse::Comment qw.comment.;

# Definition
# SFNode [in,out] metadata NULL [X3DMetadataObject]

sub parse {
	my $statement = eval { &fieldDescriptions( \$_[0] ) };
	Carp::croak $@ if $@;
	return $statement;
}

sub fieldDescriptions {
	my ($string) = @_;

	my $fieldDescription  = &fieldDescription($string);
	my $fieldDescriptions = [];

	while ( defined $fieldDescription ) {
		push @$fieldDescriptions, $fieldDescription;
		$fieldDescription = &fieldDescription($string);
	}

	return $fieldDescriptions;
}

sub fieldDescription {
	my ($string) = @_;

	1 while &comment($string);

	my $type = &Id($string);
	if ( defined $type )
	{
		#print $type;
		if ( $$string =~ m.$_open_bracket.gc )
		{
			my $in  = &in($string);
			my $out = &out($string);

			if ( $$string =~ m.$_close_bracket.gc )
			{
				my $name = &Id($string);
				if ( defined $name )
				{
					if ( not( $in xor $out ) )
					{
						my $value = eval { Weed::Parse::FieldValue::fieldValue( $type, $string ) };

						if ( not $@ and $type eq 'SFNode' or defined $value )
						{
							my $range = &range($string);
							return [ $type, $in, $out, $name, $value, $range ];

						}
						else {
							die "Couldn't read value for field description \n ", $$string, "\n";
						}
					} else {
						my $range = &range($string);
						return [ $type, $in, $out, $name,
							$type->X3DPackage::Scalar("X3DDefaultDefinition")->getValue,
							$range
						];
					}
				} else {
					die "Couldn't read name for field description \n ", $$string, "\n";
				}

			} else {
				die "Expected a ']' in field description \n ", $$string, "\n";
			}
		} else {
			die "Expected a '[' in field description \n ", $$string, "\n";
		}

	} else {
		#print substr ($$string, pos($$string)||0);
		die "Unknown event or field type in field description\n", substr( $$string, pos($$string) || 0 ), "\n"
		  if $$string !~ m.$_whitespace$.gc && ( pos($$string) || 0 ) < length($$string);
	}

	return;
}

sub in {
	my ($string) = @_;
	return $$string =~ m.$_in.gc ? YES : NO;
}

sub out {
	my ($string) = @_;
	return $$string =~ m.$_out.gc ? YES : NO;
}

sub range {
	my ($string) = @_;
	return $1 if $$string =~ m.$_FieldRange.gc;
	return;
}

1;
__END__
sub getError {
	my ($this) = @_;

	$this->{string} =~ m/\G$_whitespace*$/sgco;    # spaces at end of string$
	my $pos = pos( $this->{string} ) || 0;

	return unless length( $this->{string} ) - $pos;

	unless ($@) {
		$this->{string} =~ m/\G$_whitespace*/sgco;
		$pos = pos( $this->{string} ) || 0;
	}

	my $start = rindex( $this->{string}, "\n", $pos ) + 1;
	my $end = index( $this->{string}, "\n", $start );
	my $line = substr $this->{string}, $start, $end - $start;

	my $begin = substr $this->{string}, 0, $pos;
	my $lineNumber = ( $begin =~ s/\n/\n/sgo ) + 1;

	eval { X3DError::UnknownStatement $line } unless $@;

	X3DError::carp "*" x 80;
	X3DError::carp "Parser error at - line $lineNumber:";
	X3DError::carp $`;    # $`
	X3DError::carp $' unless $line;    # $'
	X3DError::carp "$line";
	X3DError::carp " " x ( $pos - $start ) . "^";
	X3DError::carp $@;
	X3DError::carp "*" x 80;

	$@ = "";
	return;
}
