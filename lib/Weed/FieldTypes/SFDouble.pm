package Weed::FieldTypes::SFDouble;

use Weed 'SFDouble : X3DField { 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFNumber';

sub parseFloat  { &Weed::Parse::FieldValue::float( \$_[0] ) }
sub parseDouble { &Weed::Parse::FieldValue::double( \$_[0] ) }

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( defined $value ? parseDouble("$value") : $this->getInitialValue );
}

sub toString { sprintf X3DGenerator->DOUBLE, $_[0]->getValue }

1;
__END__
