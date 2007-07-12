package Weed::FieldTypes::SFDouble;

our $VERSION = '0.008';

use Weed 'SFDouble : X3DField { 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::Number';

use Weed::Parse::Double;

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue(
		defined $value ? Weed::Parse::Double::double( \"$value" ) || 0 : $this->getDefaultValue
	);
}

sub toString { sprintf X3DGenerator->DOUBLE, $_[0]->getValue }

1;
__END__
