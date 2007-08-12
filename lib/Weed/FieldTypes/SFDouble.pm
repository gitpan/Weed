package Weed::FieldTypes::SFDouble;

our $VERSION = '0.01';

use Weed 'SFDouble : X3DField { 0 }';

use base 'Weed::BaseFieldTypes::Scalar';

sub setValue {
	my ( $this, $value ) = @_;

	$this->X3DField::setValue(
		defined $value ? eval { no warnings; $value + 0 } || 0 : $this->getDefaultValue
	);
}

sub toString { sprintf X3DGenerator->DOUBLE, $_[0]->getValue }

1;
__END__
