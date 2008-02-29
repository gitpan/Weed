package Weed::Field;
use Weed;

our $VERSION = '0.016';

use Weed::Parse::FieldValue;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	my $typeName        = $description->{typeName};
	my $defaultValue    = Weed::Parse::FieldValue::parse( $typeName, $description->{body} );
	my $fieldDefinition = new X3DFieldDefinition( $typeName, YES, YES, '', $defaultValue, '' );
	$this->X3DPackage::Scalar("X3DDefaultDefinition") = $fieldDefinition;
}

use Weed 'X3DField : X3DObject { }', 'new';

use overload
  '=' => 'getClone',
  'bool' => sub { $_[0]->getValue ? YES : NO },
  ;

sub new {
	my $this = shift->X3DObject::new;

	$this->setDefinition( $this->X3DPackage::Scalar("X3DDefaultDefinition") );

	$this->create;

	if (@_) {
		$this->setValue(@_);
		$this->setTainted(NO);
	}

	return $this;
}

sub create {
	my ($this) = @_;
	$this->{value} = $this->getInitialValue;
	return;
}

sub getClone { $_[0]->new( $_[0]->getValue ) }

*getCopy = \&getClone;

sub getDefinition { $_[0]->{definition} }
sub setDefinition { $_[0]->{definition} = $_[1] }

sub getDefaultValue { $_[0]->X3DPackage::Scalar("X3DDefaultDefinition")->getValue }
sub getInitialValue { $_[0]->getDefinition->getValue }

sub getAccessType { $_[0]->getDefinition->getAccessType }

#sub isReadable { $_[0]->getAccessType != X3DConstants->inputOnly }
#sub isWritable { $_[0]->getAccessType & X3DConstants->inputOnly }

sub getName { $_[0]->getDefinition->getName }

sub getValue { $_[0]->{value} }

sub setValue {
	my ( $this, $value ) = @_;

	$this->{value} = $value;
	$this->setTainted(time);

	return;
}

#*
#sub addFieldCallback {
#	my ( $this, $destinationField ) = @_;
#	X3DMessage->Debug;

# 	return $this->{fieldCallbacks}->{ X3DUniversal::getId($object) . $callbackName } =
# 	  [ $object, $callbackName ]
# 	  if $object->isa("SFNode")
# 	  and ref $object->getValue->getField($callbackName);

#	return;
#}

#*
#sub removeFieldCallback {
#	my ( $this, $callbackName, $object ) = @_;
#	delete $this->{fieldCallbacks}->{ X3DUniversal::getId($object) . $callbackName };
#	return;
#}

#
sub toString { sprintf "%s", $_[0]->getValue }

#sub DESTROY { X3DMessage->Debug($_[0], X3DUniversal::getId($_[0]));
#}

1;
__END__
