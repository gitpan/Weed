package Weed::FieldTypes::SFInt32;

our $VERSION = '0.0081';

use Weed 'SFInt32 : X3DField { 0 }';

use base 'Weed::BaseFieldTypes::Scalar';

use Weed::Parse::Int32;

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue(
		defined $value ? Weed::Parse::Int32::int32( \"$value" ) || 0 : $this->getDefaultValue
	);
}

sub toString {
	return sprintf X3DGenerator->INT32, $_[0]->getValue;
}

1;
__END__
