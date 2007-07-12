package Weed::FieldTypes::SFImage;

our $VERSION = '0.0078';

use Weed 'SFImage : X3DField { 0 0 0 }';

sub setValue {
	my ( $this, @value ) = @_;

	if ( UNIVERSAL::isa( $value[0], 'X3DField' ) ) {
		return $this->X3DField::setValue( $value[0]->getValue->getClone )
		  if UNIVERSAL::isa( $value[0], 'SFImage' );

		@value = map { 0 + $_ } @value;
	}

	$this->X3DField::setValue( new Weed::Values::Image(@value) );
}

sub toString {
	return $_[0]->getValue->toString;
}

1;
__END__
