package Weed::Field;
use Weed;

our $VERSION = '0.01';

use Weed::Parse::FieldValue;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	my $typeName        = $description->{typeName};
	my $defaultValue    = Weed::Parse::FieldValue::parse( $typeName, @{ $description->{body} } );
	my $fieldDefinition = new X3DFieldDefinition( $typeName, YES, YES, '', $defaultValue, '' );
	$this->X3DPackage::Scalar("DefaultDefinition") = $fieldDefinition;
}

use Weed 'X3DField : X3DObject { }', 'new';

use overload
  '=' => 'getClone',
  'bool' => sub { $_[0]->getValue ? YES : NO },
  ;

sub new {
	my $type = shift;
	my $this = $type->new_from_definition( $type->X3DPackage::Scalar("DefaultDefinition") );
	$this->setValue(@_) if @_;
	$this->setTainted(NO);
	return $this;
}

sub new_from_definition {
	my $this       = shift->X3DObject::new;
	my $definition = shift;

	$this->setDefinition($definition);

	$$this->{value} = $this->getInitialValue;

	return $this;
}

sub getClone { $_[0]->new( $_[0]->getValue ) }

*getCopy = \&getClone;

sub getDefinition { ${ $_[0] }->{definition} }
sub setDefinition { ${ $_[0] }->{definition} = $_[1] }

sub getDefaultValue { $_[0]->X3DPackage::Scalar("DefaultDefinition")->getValue }
sub getInitialValue { $_[0]->getDefinition->getValue }

sub getParent { shift @{ $_[0]->getParents->getValues } if $_[0]->getParents }

sub getAccessType { $_[0]->getDefinition->getAccessType }

#sub isReadable { $_[0]->getAccessType != X3DConstants->inputOnly }
#sub isWritable { $_[0]->getAccessType & X3DConstants->inputOnly }

sub getName { $_[0]->getDefinition->getName }

sub getValue { ${ $_[0] }->{value} }

sub setValue {
	my ( $this, $value ) = @_;
	
	$$this->{value} = $value;
	$this->setTainted(time);

	return;
}

#
sub toString { sprintf "%s", $_[0]->getValue }

1;
__END__
