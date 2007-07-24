package Weed::ArrayField;
use Weed;

our $VERSION = '0.009';

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	$this->X3DField::SET_DESCRIPTION($description);
	$_[0]->X3DPackage::Scalar("FieldType") = 'S' . substr $description->{typeName}, 1;
}

use Weed 'X3DArrayField : X3DField { [] }';

use base 'X3DArray';

use Weed::Tie::Value::Array;
use Weed::Tie::ArrayLength;

use overload '@{}' => 'getArray';

#sub new { shift->X3DField::new(@_) }
*new = \&X3DField::new;

sub new_from_definition {    # also in MFNode
	my $this = shift->X3DField::new_from_definition(@_);

	$this->{array} = new Weed::Tie::Value::Array $this;
	tie $this->{length}, 'Weed::Tie::ArrayLength', $this->{array};

	return $this;
}

#sub getClone { $_[0]->X3DField::getClone }
#sub getCopy  { $_[0]->X3DField::getCopy }

sub getInitialValue { $_[0]->getDefinition->getValue->getClone }

sub getFieldType { $_[0]->X3DPackage::Scalar("FieldType") }

sub getArray { ${ $_[0] }->{array} }

sub setValue {
	my $this  = shift;
	my $array = $this->getArray;

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

sub set1Value {
	warn;
}

sub get1Value {
	warn;
}

sub length : lvalue { $_[0]->{length} }

1;
__END__
