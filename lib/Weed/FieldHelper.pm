package Weed::FieldHelper;
use Weed::Perl;

use UNIVERSAL 'isa';
use overload;

use constant VECTOR   => "Weed::Values::Vector";
use constant ROTATION => "Weed::Values::Rotation";

sub IsaVector { isa( $_[0], VECTOR ) || isa( $_[0], ROTATION ) }

sub NumVal {
	my @values = ();

	foreach (@_) {
		if ( isa( $_, 'X3DField' ) ) {
			my $value = $_->getValue;
			if ( isa( $value, VECTOR ) || isa( $value, ROTATION ) ) {
				push @values, $value->getValue;
			}
			else {    # Scalar
				push @values, $value;
			}
			# SFImage
			# SFNode
		}
		elsif ( isa( $_, VECTOR ) || isa( $_, ROTATION ) ) {
			push @values, $_->getValue;
		}
		elsif ( ref($_) eq 'ARRAY' ) {
			push @values, NumVal(@$_);
		}
		else {
			my $numify = overload::Method( $_, "0+" );
			push @values, ref $numify ? &{$numify}($_) : $_;
		}
	}

	return $#values ? @values : shift @values;
}

1;
__END__
