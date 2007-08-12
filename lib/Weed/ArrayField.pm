package Weed::ArrayField;
use Weed;

our $VERSION = '0.012';

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	$this->X3DField::SET_DESCRIPTION($description);
	$_[0]->X3DPackage::Scalar("FieldType") = 'S' . substr $description->{typeName}, 1;
}

use Weed 'X3DArrayField : X3DField { [] }';

use base 'X3DArray';

use Weed::Tie::Value::Array;
use Weed::Tie::ArrayLength;

use overload '@{}' => sub { $_[0]->{array} };

#sub new { shift->X3DField::new(@_) }
*new = \&X3DField::new;

sub create {    # also in MFNode
	my ($this) = @_;

	die $this->getDefinition unless defined $this->getInitialValue;

	$this->{value} = $this->getInitialValue->getClone;
	$this->{array} = new Weed::Tie::Value::Array $this;

	tie $this->{length}, 'Weed::Tie::ArrayLength', $this->{array};

	return;
}

#sub getClone { $_[0]->X3DField::getClone }
#sub getCopy  { $_[0]->X3DField::getCopy }

sub getFieldType { $_[0]->X3DPackage::Scalar("FieldType") }

sub setValue {
	my $this  = shift;
	my $array = $this->{array};

	if ( 0 == @_ ) {
		@$array = ();
	}
	elsif ( 1 == @_ )
	{
		my $value = shift;

		if ( X3DArray::isArray($value) ) {
			@$array = @$value;
		}
		else {
			@$array = ($value);
		}
	}
	else {
		@$array = @_;
	}

	$this->X3DField::setValue( $this->getValue );
}

#sub set1Value { $_[0]->[ $_[1] ] = $_[2] }

#sub get1Value { $_[0]->[ $_[1] ] }

sub length : lvalue { $_[0]->{length} }

1;
__END__
