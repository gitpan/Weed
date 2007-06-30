package Weed::BaseNode;
use Weed::Perl;
use Weed::Parse::FieldDescription;

sub setDescription {
	my ( $this, $description ) = @_;
	my $fieldDescriptions = Weed::Parse::FieldDescription::parse @{ $description->{body} };
	my $fieldDefinitions = [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ];
	${ $this->Weed::Package::scalar("FieldDefinitions") } = $fieldDefinitions;
}

use Weed 'X3DBaseNode { }';

sub new {
	my $this = shift->CREATE;
	my $name = shift;

	$this->setName($name);

	tie $this->{fields}->{ $_->getName }, 'Weed::Tie::Field', $_->createField($this)
	  foreach $this->getFieldDefinitions;

	# $this->{fields}->{sf[color|colorrgba|...]} *= 2 needs this
	map { ref $this->{fields}->{ $_->getName } } $this->getFieldDefinitions;

	return $this;
}

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = $_[1] || '' }
sub getName { $_[0]->{name} }

sub getTiedField : lvalue {
	my ( $this, $name ) = @_;

	X3DMessage->UnknownField(@_) unless exists $this->{fields}->{$name};

	return ${ tied $this->{fields}->{$name} }
	  if Want::want('CODE') || Want::want('OBJECT') || Want::want('ARRAY');

	$this->{fields}->{$name};
}

sub getField {
	my ( $this, $name ) = @_;
	return ${ tied $this->getTiedField($name) };
}

sub getFields {
	my ( $this, $tidy ) = @_;
	my $fields = [];

	foreach ( $this->getFieldDefinitions ) {
		my $field = $this->getField( $_->getName );

		push @$fields, $field
		  unless
		  ( $_->isIn ^ $_->isOut ) ||
		  ( $tidy && ( $_ eq $field ) );
	}

	return wantarray ? @$fields : $fields;
}

sub getFieldDefinitions {
	wantarray ?
	  @${ $_[0]->Weed::Package::scalar("FieldDefinitions") } :
	  ${ $_[0]->Weed::Package::scalar("FieldDefinitions") }
}

sub toString {
	my $this   = shift;
	my $string = "";

	if ( $this->getName ) {
		$string .= X3DGenerator->DEF;
		$string .= X3DGenerator->space;
		$string .= $this->getName;
		$string .= X3DGenerator->space;
	}

	$string .= $this->getTypeName;
	$string .= X3DGenerator->tidy_space;
	$string .= X3DGenerator->open_brace;

	if ( @{ $this->getComments } ) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach ( $this->getComments ) {
			$string .= X3DGenerator->indent;
			$string .= X3DGenerator->comment;
			$string .= $_;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}

	my $fields = $this->getFields( X3DGenerator->tidy_fields );
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


sub private::getField : lvalue {
	my ( $this, $name ) = @_;
	X3DMessage->UnknownField(@_) unless exists $this->{fields}->{$name};

	return ${ tied $this->{fields}->{$name} } if Want::want('CODE') || Want::want('OBJECT') || Want::want('ARRAY');
	$this->{fields}->{$name};
}

sub getField {
	my ( $this, $name ) = @_;
	X3DMessage->UnknownField(@_) unless exists $this->{fields}->{$name};
	return ${ tied $this->{fields}->{ $_->getName } };
}

