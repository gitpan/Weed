package X3D::Components::Core::Node;

our $VERSION = '0.006';

use X3D '
X3DNode : X3DBaseNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my $this = shift->X3DBaseNode::new(@_);

	$this->{self} = new SFNode($this);
	#$this->getParents->remove( $this->{self} );

	$this->getCallbacks->add( $this->{self}, $this->can("processEvent") );
	$this->setTainted(NO);

	$_->getCallbacks->add( $this->{self}, UNIVERSAL::can( $this, $_->getName ) )
	  foreach grep { $_->getDefinition->isIn } @{ $this->{fields} };

	#$this->can("initialize")->( $$this->{self}, $this );

	return $this;
}

# node
sub initialize { }

sub processEvent {
	my ( $self, $this, $time ) = @_;
	$_->processEvents($time) foreach @{ $this->{fields} };
	return;
}

sub prepareEvents   { }
sub eventsProcessed { }

1;
__END__

build
display

sub DESTROY { X3DMessage->Debug;
	my $this = shift;
	return;
}
