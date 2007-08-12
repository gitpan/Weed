package Weed::FieldTypes::SFNode;

our $VERSION = '0.016';

use Weed 'SFNode : X3DField { NULL }';

use overload
  'int' => sub { $_[0]->getValue ? 1 : 0 },
  '0+'  => sub { $_[0]->getValue ? 1 : 0 },

  '==' => sub { $_[0]->getValue ? $_[0]->getValue == $_[1] : !$_[1] },
  '!=' => sub { $_[0]->getValue ? $_[0]->getValue != $_[1] : $_[1] ? YES : NO },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },
  ;

use Want ();

sub AUTOLOAD : lvalue {    #X3DMessage->Debug( @_, our $AUTOLOAD );
	my $this = shift;
	my $name = substr our $AUTOLOAD, rindex( $AUTOLOAD, ':' ) + 1;

	$this = $this->getValue;
	X3DMessage->UnknownField( 1, $this, $AUTOLOAD ), return unless ref $this;

	#X3DMessage->DirectOutputIsFALSE, return unless $this->{directOutput};

	if ( Want::want('RVALUE') ) {
		my $field = $this->getField($name);
		Want::rreturn $field if Want::want 'ARRAY';
		Want::rreturn $field->getClone->getValue;
	}

	if ( Want::want('ASSIGN') ) {
		$this->getField($name)->setValue( Want::want('ASSIGN') );
		Want::lnoreturn;
	}

	if ( Want::want('CODE') ) {
		my $value = $this->getField($name)->getClone->getValue;
		return $value;
	}

	return $this->getFields->getField( $name, $this ) if Want::want('REF');

	$this->getFields->getTiedField( $name, $this )    # für: += ++ ...
}

#sub new {  X3DMessage->Debug;
#shift->X3DField::new(@_) }

#sub getClone { $_[0]->new( $_[0]->getValue ) }

sub getCopy {
	my $value = $_[0]->getValue;
	return $_[0]->new( defined $value ? $value->getCopy : $value );
}

sub getInitialValue { $_[0]->getDefinition->getValue }

sub setValue {
	my ( $this, $value ) = @_;

	my $node = $this->getValue;
	$node->getParents->remove($this) if ref $node;

	$value = $value->getValue
	  if UNIVERSAL::isa( $value, 'SFNode' );

	if ( UNIVERSAL::isa( $value, 'X3DBaseNode' ) )
	{
		$value->getParents->add($this);
		$this->X3DField::setValue($value);
	}
	elsif ( !defined $value )
	{
		$this->X3DField::setValue($value)
	}
	else
	{
		X3DMessage->ValueHasToBeAtLeastOfTypeX3DNode( 1, $this, $value );
	}

	$node->dispose if ref $node;
	return;
}

sub toString { sprintf "%s", $_[0]->getValue || X3DGenerator->NULL }

sub DESTROY {    #X3DMessage->Debug(undef, $_[0]->getId, $_[0]->getName);
	my $this = shift;
	#print new X3DHash $this;
	$this->setValue(undef);
	return;
}

1;
__END__

	print '';
	print 'wantref: ', Want::wantref() if Want::wantref();
	print 'VOID'          if Want::want('VOID');
	print 'SCALAR'        if Want::want('SCALAR');
	print 'REF'           if Want::want('REF');
	print 'REFSCALAR'     if Want::want('REFSCALAR');
	print 'CODE'          if Want::want('CODE');
	print 'HASH'          if Want::want('HASH');
	print 'ARRAY'         if Want::want('ARRAY');
	print 'GLOB'          if Want::want('GLOB');
	print 'OBJECT'        if Want::want('OBJECT');
	print 'BOOL'          if Want::want('BOOL');
	print 'LIST'          if Want::want('LIST');
	print 'COUNT'         if Want::want('COUNT');
	print 'Infinity'      if Want::want('Infinity');
	print 'LVALUE'        if Want::want('LVALUE');
	print 'ASSIGN'        if Want::want('ASSIGN');
	print 'RVALUE'        if Want::want('RVALUE');

