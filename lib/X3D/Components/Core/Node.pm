package X3D::Components::Core::Node;

our $VERSION = '0.003';

use Weed '
X3DNode : X3DBaseNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my $this = shift->X3DBaseNode::new(@_);

	$$this->{self} = new SFNode($this);

	$this->getCallbacks->add( $$this->{self}, $this->can("processEvent") );

	$this->can("processEvent")->( $$this->{self}, $this );
	$this->setTainted(NO);

	$_->getCallbacks->add( $$this->{self}, UNIVERSAL::can( $this, $_->getName ) )
	  foreach grep { $_->getDefinition->isIn } @$this;

	$this->can("initialize")->( $$this->{self}, $this );

	return $this;
}

# node
sub initialize { }

sub processEvent {
	my ( $self, $this, $time ) = @_;
	$_->processEvents($time) foreach @$this;
	return;
}

sub prepareEvents { }
# set_
sub eventsProcessed { }

1;
__END__
