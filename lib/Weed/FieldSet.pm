package Weed::FieldSet;

use Weed 'X3DFieldSet : X3DArrayHash { }';

our $VERSION = '0.0002';

sub new {
	my ( $self, $fieldDefinitions, $parent ) = @_;

	my @fields;
	my %fields;

	for ( my $i = 0 ; $i < @$fieldDefinitions ; $i++ ) {
		my $fieldDefinition = $fieldDefinitions->[$i];
		my $field           = $fieldDefinition->createField($parent);

		tie $fields{ $fieldDefinition->getName }, 'Weed::Tie::Field', $field;
		tie $fields[$i], 'Weed::Tie::Field', $field;

		scalar $fields[$i];
		scalar $fields{ $fieldDefinition->getName };
	}

	my $this = $self->X3DArrayHash::new( \@fields, \%fields );

	return $this;
}

sub getField {
	return ${ tied $_[0]->{ $_[1] } }
	  if exists $_[0]->{ $_[1] };

	X3DMessage->UnknownField( 2, @_[ 2, 1 ] )
}

sub getPrintableFields {
	my ( $this, $tidy ) = @_;
	my $fields = [];

	foreach ( map { ${ tied $_ } } @$this ) {
		my $fieldDefiniton = $_->getDefinition;

		push @$fields, $_
		  unless
		  ( $fieldDefiniton->isIn ^ $fieldDefiniton->isOut ) ||
		  ( $tidy && ( $fieldDefiniton eq $_ ) );
	}

	return $fields;
}

sub toString {
	my ($this) = @_;

	my $fields = $this->getPrintableFields( X3DGenerator->getTidyFields );

	my $string = "";

	$string .= X3DGenerator->open_brace;

	if (@$fields) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach (@$fields) {
			$string .= X3DGenerator->indent;
			$string .= $_->getName;
			$string .= X3DGenerator->space;
			$string .= $_->isa('SFString') ? sprintf X3DGenerator->STRING, $_ : $_;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}
	else {
		$string .= X3DGenerator->tidy_space;
	}

	$string .= X3DGenerator->close_brace;

	return $string;
}

1;
__END__
	my $fields = $this->getFields( X3DGenerator->getTidyFields );
	if (@$fields) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach (@$fields) {
			$string .= X3DGenerator->indent;
			$string .= $_->getName;
			$string .= X3DGenerator->space;
			$string .= $_->isa('SFString') ? sprintf X3DGenerator->STRING, $_ : "$_";
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}
	else {
		$string .= X3DGenerator->tidy_space;
	}

