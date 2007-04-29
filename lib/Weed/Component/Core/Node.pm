package Weed::Component::Core::Node;
use strict;
use warnings;

use Weed '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my ( $self, $name ) = @_;
	my $this = $self->SUPER::new($self->PACKAGE);
	$this->create($name);
	return $this;
}

sub create {
	my ( $this, $name) = @_;
	$this->setName($name);
	$this->setFieldDescriptions( $this->getFieldDescriptions );
}

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = $_[1] || '' }
sub getName { $_[0]->{name} }

sub setFieldDescriptions {
	my ( $this, $fieldDescriptions ) = @_;
		
	${ $this->SCALAR( "FieldDescriptions") } = $fieldDescriptions;
	$this->setFieldDefinitions( [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ] );
}

sub private::getFieldDescriptions {
	my ($this) = @_;
	my $fieldDescriptions =  ${ $this->SCALAR("FieldDescriptions") };
	$fieldDescriptions = $this->SUPER->private::getFieldDescriptions
	  unless ref $fieldDescriptions;
	return $fieldDescriptions;
}

sub getFieldDescriptions { $_[0]->private::getFieldDescriptions }

sub setFieldDefinitions {
	my ( $this, $fieldDefinitions ) = @_;
	${ $this->SCALAR( "FieldDefinitions") } = $fieldDefinitions;
}

sub getFieldDefinitions { ${ $_[0]->SCALAR("FieldDefinitions") } }


1;
__END__
sub toString {
	printf "### %d\n", scalar @_;

	my ( $this, $generator ) = @_;
	$generator = $this->getGenerator unless ref $generator;
}

