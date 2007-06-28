package X3DField;
use strict;
use warnings;

use base qw(X3DObject);

use X3DConstants;
use X3DGenerator;

sub new {
	my $self = shift;
	my $this = $self->SUPER::new;
	@$this{ "node", "accessType", "type", "name", "value" } = @_;
	$this->{update}         = FALSE;
	$this->{callbacks}      = {};
	$this->{fieldCallbacks} = {};
	return $this;
}

sub getNode { $_[0]->{node} }

sub getAccessType { $_[0]->{accessType} }
sub isWritable    { $_[0]->{accessType} & outputOnly }
sub isReadable    { $_[0]->{accessType} ^ inputOnly }

sub getValue { $_[0]->{value} }

sub setValue {
	my ( $this, @value ) = @_;
	#X3DError::Debug ref $value;

	$this->{update} = TRUE;
	$this->removeParent;
	$this->{value}->setValue( ref $value[0] ? $value[0]->getValue : @value );
	$this->addParent;

	return;
}

sub addParent {
	my ($this) = @_;

	if ( $this->{value}->isa("SFNode") ) {
		my $node = $this->{value}->getValue;
		$node->addParent( $this->{node} ) if ref $node;
		return;
	}

	if ( $this->{value}->isa("MFNode") ) {
		foreach my $node ( map { $_->getValue } @{ $this->{value} } ) {
			$node->addParent( $this->{node} ) if ref $node;
		}
		return;
	}

	return;
}

sub removeParent {
	my ($this) = @_;

	if ( $this->{value}->isa("SFNode") ) {
		my $node = $this->{value}->getValue;
		$node->removeParent( $this->{node} ) if ref $node;
		return;
	}

	if ( $this->{value}->isa("MFNode") ) {
		foreach my $node ( map { $_->getValue } @{ $this->{value} } ) {
			$node->removeParent( $this->{node} ) if ref $node;
		}
		return;
	}

	return;
}

#registerFieldInterest
# $field->addFieldCallback("callback", $node);
sub addFieldCallback {    #X3DError::Debug;
	my ( $this, $callbackName, $object ) = @_;

	my $callback = $object->can($callbackName);
	return $this->{callbacks}->{ X3DObject::getId($object) . $callbackName } =
	  [ $callback, $object ]
	  if ref $callback;

	return $this->{fieldCallbacks}->{ X3DObject::getId($object) . $callbackName } =
	  [ $object, $callbackName ]
	  if $object->isa("SFNode")
	  and ref $object->getValue->getField($callbackName);

	return;
}

sub removeFieldCallback {
	my ( $this, $callbackName, $object ) = @_;
	delete $this->{callbacks}->{ X3DObject::getId($object) . $callbackName };
	#delete $this->{fieldCallbacks}->{ X3DObject::getId($object) . $callbackName };
	return;
}

sub processEvent {    #X3DError::Debug;
	my ($this) = @_;
	return unless $this->{update};

	#### fieldCallbacks
	$_->[0]->getValue->getField( $_->[1] )->setValue( $this->{value} )
	  foreach values %{ $this->{fieldCallbacks} };

	$_->[0]->getValue->processEvents foreach values %{ $this->{fieldCallbacks} };

	#### callbacks
	&{ $_->[0] }( $_->[1], $this->{value} ) foreach values %{ $this->{callbacks} };

	$this->{update} = FALSE;
	return;
}

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= $this->{name};
	$string .= $X3DGenerator::SPACE;
	$string .= $this->{value};

	if ( $this->{comment} ) {
		$string .= $X3DGenerator::TAB;
		$string .= "#";
		$string .= $this->{comment};
	}

	return $string;
}

1;
__END__
