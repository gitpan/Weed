package Weed::FieldTypes::SFInt32;

use Weed 'SFInt32 : X3DField { 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFNumber';

use integer;

sub parseInt { &Weed::Parse::FieldValue::int32( \$_[0] ) }

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( parseInt("$value") );
}

sub toString {
	return sprintf X3DGenerator->INT32, $_[0]->getValue;
}

1;
__END__
