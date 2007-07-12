package Weed::FieldTypes::SFFloat;

our $VERSION = '0.008';

use Weed 'SFFloat : X3DField { 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::Number';

use Weed::Parse::Float;

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue(
		defined $value ? Weed::Parse::Float::float( \"$value" ) || 0 : $this->getDefaultValue
	);
}

sub toString { sprintf X3DGenerator->FLOAT, $_[0]->getValue }

1;
__END__
