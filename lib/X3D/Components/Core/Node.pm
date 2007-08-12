package X3D::Components::Core::Node;

our $VERSION = '0.009';

use X3D '
X3DNode : X3DBaseNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my $this = shift->X3DBaseNode::new(@_);

	$this->getCallbacks->add( $this, $this->can("processEvent") );

	#$this->setTainted(NO);

	$_->getCallbacks->add( $this, UNIVERSAL::can( $this, $_->getName ) )
	  foreach grep { $_->getDefinition->isIn } @{ $this->getFields };

	#$this->can("initialize")->( $$this->{self}, $this );

	return $this;
}

# node
sub initialize { }

sub processEvent {
	my ( $self, $this, $time ) = @_;
	$_->processEvents($time) foreach @{ $this->getFields };
	return;
}

sub prepareEvents   { }
sub eventsProcessed { }

sub dispose {
	my ($this) = @_;
	#return unless $this->getParents == 1;
	#$this->{self}->setValue(undef);
	return;
}

1;
__END__

build
display

sub DESTROY { X3DMessage->Debug;
	my $this = shift;
	return;
}
