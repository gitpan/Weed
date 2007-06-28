package Weed::FieldTypes::SFBool;

use Weed 'SFBool : X3DField { FALSE }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFNumber';

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( $value ? YES: NO );
}

sub toString { $_[0]->getValue ? X3DGenerator->TRUE: X3DGenerator->FALSE }

1;
__END__
