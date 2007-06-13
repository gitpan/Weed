package Weed::Components::Core::Node;

sub setDescription {
	my ( $this, $description ) = @_;

	printf "%s %s\n", $this, $_
	  foreach @{$description->{body}};

	#die;
}

use Weed '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub create {
	my ( $this, $name ) = @_;
	#printf "%s->%s %s\n", $_[0]->getType, $_[0]->Weed::Package::sub, $_[0];
	$this->setName($name);
}

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = $_[1] || '' }
sub getName { $_[0]->{name} }

sub getFieldDefinitions { ${ $_[0]->Weed::Package::scalar("FieldDefinitions") } }

1;
__END__

sub setFieldDescriptions {
	my ( $this, $fieldDescriptions ) = @_;

	${ $this->Weed::Package::scalar("FieldDescriptions") } = $fieldDescriptions;
	$this->setFieldDefinitions( [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ] );
}

sub private::getFieldDescriptions {
	my ($this) = @_;
	my $fieldDescriptions = ${ $this->Weed::Package::scalar("FieldDescriptions") };
	$fieldDescriptions = $this->SU PER->private::getFieldDescriptions
	  unless ref $fieldDescriptions;
	return $fieldDescriptions;
}

sub getFieldDescriptions { $_[0]->private::getFieldDescriptions }

sub setFieldDefinitions {
	my ( $this, $fieldDefinitions ) = @_;
	${ $this->Weed::Package::scalar("FieldDefinitions") } = $fieldDefinitions;
}
sub toString {
	printf "### %d\n", scalar @_;

	my ( $this, $generator ) = @_;
	$generator = $this->getGenerator unless ref $generator;
}

