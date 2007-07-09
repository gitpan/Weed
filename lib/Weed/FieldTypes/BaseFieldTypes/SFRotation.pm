package Weed::FieldTypes::BaseFieldTypes::SFRotation;

use UNIVERSAL 'isa';

use base 'Weed::FieldTypes::BaseFieldTypes::SFVector';

sub new_from_definition {
	my $this = shift->X3DField::new_from_definition(@_);
#	tie @{ $this->getValue }, 'Weed::Tie::VectorValue', $this;
	return $this;
}

sub setValue {
	my $this  = shift;
	my $VALUE = ref( $this->getInitialValue );

	if ( isa( $_[0], 'X3DField' ) ) {

		return $this->X3DField::setValue( $VALUE->new( $_[0]->getValue ) )
		  if isa( $_[0]->getValue, $VALUE );

		return $this->X3DField::setValue( $VALUE->new( map { "$_" } @_ ) );
	}

	$this->X3DField::setValue( $VALUE->new(@_) );
}

1;
__END__
