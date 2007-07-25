package X3D::Components::Core::Node;

our $VERSION = '0.002';

use Weed '
X3DNode : X3DBaseNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my $this = shift->X3DBaseNode::new(@_);

	$$this->{self} = new SFNode($this);

	$this->addCallback( $$this->{self}, $this->can("prepareEvents") );
	$this->addCallback( $$this->{self}, $this->can("processEvent") );
	$this->addCallback( $$this->{self}, $this->can("eventsProcessed") );

	$this->can("processEvent")->( $$this->{self}, $this );
	$this->setTainted(NO);

	$_->addCallback( $$this->{self}, UNIVERSAL::can( $this, $_->getName ) )
	  foreach grep { $_->getDefinition->isIn } @$this;

	$this->can("initialize")->( $$this->{self}, $this );

	return $this;
}

# node
sub initialize { }

sub processEvent {
	my ( $self, $this, $time ) = @_;
	$_->processEvents($time) foreach sort { $a->getTainted <=> $b->getTainted } grep { $_->getTainted } @$this;
	return;
}

sub prepareEvents { }
# set_
sub eventsProcessed { }

1;
__END__
