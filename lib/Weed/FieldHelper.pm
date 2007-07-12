package Weed::FieldHelper;
use Weed::Perl;

our $VERSION = '0.008';

use UNIVERSAL 'isa';
use overload;

use Weed::Parse::Double 'double';

use constant VECTOR   => "Weed::Values::Vector";
use constant ROTATION => "Weed::Values::Rotation";

# NumVal($count, ...)
# returns a list of numbers as array ref with at most $count values
sub NumVal {
	my $count  = shift;
	my $values = [];

	foreach (@_) {
		my $ref = ref $_;

		if ($ref)
		{
			if ( isa( $_, 'X3DField' ) )
			{
				my $value = $_->getValue;

				if ( isa( $value, VECTOR ) )
				{
					push @$values, @{ $value->getValue };
				}
				elsif ( isa( $value, ROTATION ) )
				{
					push @$values, @{ $value->getValue };
				}
				elsif ( isa( $_, 'SFImage' ) )
				{
					X3DMessage->CouldNotAssign( 3, $_ );
				}
				elsif ( isa( $_, 'SFNode' ) )
				{
					X3DMessage->CouldNotAssign( 3, $_ );
				}
				elsif ( isa( $_, 'X3DArrayField' ) )
				{
					X3DMessage->CouldNotAssign( 3, $_ );
				}
				else
				{    # Scalar
					push @$values, $value;
				}
			}
			elsif ( isa( $_, VECTOR ) )
			{
				push @$values, @{ $_->getValue };
			}
			elsif ( isa( $_, ROTATION ) )
			{
				push @$values, @{ $_->getValue };
			}
			elsif ( $ref eq 'ARRAY' )
			{
				push @$values, @{ NumVal( $count, @$_ ) };
			}
			else
			{
				my $numify = overload::Method( $_, "0+" );
				push @$values, ref $numify ? &{$numify}($_) : double( \"$_" ) || 0;
			}
		}
		elsif ( defined $_ )
		{
			push @$values, $_;
		}
		else
		{
			push @$values, 0;
		}

		last if @$values > $count;
	}

	splice @$values, $count if @$values > $count;

	return $values;
}

sub RotVal {
	return unless @_;

	# Rotation (rotation)
	return $_[0]->getValue if isa( $_[0], 'SFRotation' );
	return $_[0]           if isa( $_[0], ROTATION );

	if ( 1 == @_ && isa( $_[0], 'ARRAY' ) )
	{
		# Rotation ([...])
		return RotVal( @{ $_[0] } )
	}
	else
	{
		my $value = NumVal( 6, @_ );
		return $value if @$value <= 4;    # Rotation (x,y,z,angle,...)
		return ( [ @$value[ 0 .. 2 ] ], [ @$value[ 3 .. 5 ] ] );    # Rotation (vector, vector)
	}
}

1;
__END__
