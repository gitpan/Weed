package Weed::FieldTypes::SFInt32;

our $VERSION = '0.01';

use Weed 'SFInt32 : X3DField { 0 }';

use integer;

use base 'Weed::BaseFieldTypes::Scalar';

sub setValue {
	my ( $this, $value ) = @_;
	
	$this->X3DField::setValue(
		defined $value ? eval { no warnings; int($value) } || 0 : $this->getDefaultValue
	);
}

sub toString {
	return sprintf X3DGenerator->INT32, $_[0]->getValue;
}

1;
__END__
Data::Integer
