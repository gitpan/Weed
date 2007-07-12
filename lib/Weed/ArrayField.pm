package Weed::ArrayField;
use Weed;

our $VERSION = '0.0078';

sub setDescription {
	my ( $this, $description ) = @_;
	$this->X3DField::setDescription($description);
	$_[0]->X3DPackage::Scalar("FieldType") = 'S' . substr $description->{typeName}, 1;
}

use Weed 'X3DArrayField : X3DField { [] }';

use base 'Weed::Array';

use Weed::Tie::ArrayFieldValue;
use Weed::Tie::Length;

use overload '@{}' => 'getValue';

sub new { shift->X3DField::new(@_) }

sub new_from_definition {    # also in MFNode
	my $this = shift->X3DField::new_from_definition(@_);

	tie @{ $this->getValue }, 'Weed::Tie::ArrayFieldValue', $this;
	tie $this->length, 'Weed::Tie::Length', $this->getValue;

	return $this;
}

sub getClone { $_[0]->X3DField::getClone }
#sub getCopy  { $_[0]->X3DField::getCopy }

sub getFieldType { $_[0]->X3DPackage::Scalar("FieldType") }

sub getValue { shift->X3DField::getValue }

sub setValue {
	my $this  = shift;
	my $array = $this->getValue;
	$array->setValue(@_);
	$this->X3DField::setValue($array);
}

sub set1Value {
}

sub get1Value {
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

