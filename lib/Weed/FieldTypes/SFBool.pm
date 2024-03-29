package Weed::FieldTypes::SFBool;

our $VERSION = '0.009';

use Weed 'SFBool : X3DField { FALSE }';

use base 'Weed::BaseFieldTypes::Scalar';

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( defined $value ? ($value ? YES: NO) : $this->getDefaultValue );
}

sub toString { $_[0]->getValue ? X3DGenerator->TRUE: X3DGenerator->FALSE }

1;
__END__
