package Weed::Field;
use Weed::Perl;
use Weed::Parse::FieldValue;

sub setDescription {
	my ( $this, $description ) = @_;
	my $typeName        = $description->{typeName};
	my $initialValue    = Weed::Parse::FieldValue::parse( $typeName, @{ $description->{body} } );
	my $fieldDefinition = new X3DFieldDefinition( $typeName, YES, YES, '', $initialValue, '' );
	${ $this->Weed::Package::scalar("DefaultDefinition") } = $fieldDefinition;
}

use Weed 'X3DField { }';

use overload
  '=' => 'clone',
  'bool' => sub { $_[0]->getValue ? YES: NO },
  ;

sub new {
	my $type = shift;
	my $this = $type->new_from_definition( ${ $type->Weed::Package::scalar("DefaultDefinition") } );
	$this->setValue(@_) if @_;
	return $this;
}

sub new_from_definition {
	my $this       = shift->CREATE;
	my $definition = shift;

	$this->setDefinition($definition);

	$this->{value} = ref $this->getInitialValue ?
	  $this->getInitialValue->copy : $this->getInitialValue;

	return $this;
}

sub clone { $_[0]->new( $_[0]->getValue ) }

sub getDefinition { $_[0]->{definition} }
sub setDefinition { $_[0]->{definition} = $_[1] }

sub getInitialValue { $_[0]->getDefinition->getValue }

sub getAccessType { $_[0]->getDefinition->getAccessType }

sub isReadable { $_[0]->getAccessType != X3DConstants->inputOnly }
sub isWritable { $_[0]->getAccessType & X3DConstants->inputOnly }

sub getName { $_[0]->getDefinition->getName }

sub getValue { $_[0]->{value} }

sub setValue {
	my ( $this, $value ) = @_;

	$this->{value} = $value;

	return;
}

sub toString { sprintf "%s", $_[0]->getValue }

1;
__END__
