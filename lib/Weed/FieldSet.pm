package Weed::FieldSet;

use Weed 'X3DFieldSet : X3DArrayHash ()';

our $VERSION = '0.004';

use Weed::Tie::Field;

sub new {
	my ( $self, $fieldDefinitions, $parent ) = @_;

	my @fields;
	my %fields;
	my %tiedFields;

	for ( my $i = 0 ; $i < @$fieldDefinitions ; $i++ ) {
		my $fieldDefinition = $fieldDefinitions->[$i];
		my $name            = $fieldDefinition->getName;
		my $field           = $fieldDefinition->createField($parent);

		$fields[$i] = $field;
		$fields{$name} = $field;

		tie $tiedFields{$name}, 'Weed::Tie::Field', $field;

		#44217; make perl know that this is a ref
		scalar $tiedFields{$name};
	}

	my $this = $self->X3DArrayHash::new( \@fields, \%fields );
	$$this->{tiedFields} = new X3DHash \%tiedFields;

	return $this;
}

# sub getClone {
# 	my $this = shift;
# 	my $copy = $this->new( $this->getName );
#
# 	$$copy->{fields}->{$_}->setValue( $this->getField($_) )
# 	  foreach map { $_->getName } $this->getFieldDefinitions;
#
# 	return $copy;
# }

sub getField : lvalue {
	my ( $this, $name ) = @_;

	X3DMessage->UnknownField( 2, @_[ 2, 1 ] ), return
	  unless exists $this->{$name};

	$this->{$name}
}

sub getTiedField : lvalue {
	my ( $this, $name ) = @_;

	X3DMessage->UnknownField( 2, @_[ 2, 1 ] ), return
	  unless exists $this->{$name};

	$$this->{tiedFields}->{$name}
}

sub getPrintableFields {
	my ( $this, $tidy ) = @_;
	my $fields = [];

	foreach (@$this) {
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

