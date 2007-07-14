package Weed::ArrayField;
use Weed;

our $VERSION = '0.0079';

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	$this->X3DField::SET_DESCRIPTION($description);
	$_[0]->X3DPackage::Scalar("FieldType") = 'S' . substr $description->{typeName}, 1;
}

use Weed 'X3DArrayField : X3DField { [] }';

use base 'Weed::Array';

use Weed::Tie::Value::Array;
use Weed::Tie::ArrayLength;

use overload '@{}' => 'getValue';

sub new { shift->X3DField::new(@_) }

sub new_from_definition {    # also in MFNode
	my $this = shift->X3DField::new_from_definition(@_);

	tie @{ $this->getValue }, 'Weed::Tie::Value::Array', $this;
	tie $this->length, 'Weed::Tie::ArrayLength', $this->getValue;

	return $this;
}

sub getClone { $_[0]->X3DField::getClone }
#sub getCopy  { $_[0]->X3DField::getCopy }

sub getFieldType { $_[0]->X3DPackage::Scalar("FieldType") }

sub getValue { shift->X3DField::getValue }

sub setValue {
	my $this  = shift;
	my $array = $this->getValue;

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

	$this->X3DField::setValue($array);
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
sub length : lvalue {
	my $this = shift;

	if ( Want::want('RVALUE') ) {
		Want::rreturn $this->getLength;
	}

	if ( Want::want('ASSIGN') ) {
		$this->setLength( Want::want('ASSIGN') );
		Want::lnoreturn;
	}

	$this->{length};
}

