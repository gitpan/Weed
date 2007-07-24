package Weed::FieldTypes::SFNode;

our $VERSION = '0.009';

use Weed 'SFNode : X3DField { NULL }';

use Want ();

use overload
  'int' => sub { $_[0]->getValue ? 1 : 0 },
  '0+'  => sub { $_[0]->getValue ? 1 : 0 },

  '==' => sub { $_[0]->getValue ? $_[0]->getValue == $_[1] : !$_[1] },
  '!=' => sub { $_[0]->getValue ? $_[0]->getValue != $_[1] : $_[1] ? YES : NO },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },

  #'@{}' => sub { $_[0]->getValue },
  #'%{}' => sub { $_[0]->getValue },
  ;

sub AUTOLOAD : lvalue {    #X3DMessage->Debug(@_);
	my $this = shift;
	my $name = substr our $AUTOLOAD, rindex( $AUTOLOAD, ':' ) + 1;

	my $node = $this->getValue;
	X3DMessage->UnknownField( 1, $this, $AUTOLOAD ) unless ref $node;

	if ( Want::want('RVALUE') ) {
		my $field = $node->getField($name);
		Want::rreturn $field if Want::want 'ARRAY';
		Want::rreturn $field->getClone;
	}

	if ( Want::want('ASSIGN') ) {
		$node->getField($name)->setValue( Want::want('ASSIGN') );
		Want::lnoreturn;
	}

	return $node->getFields->getField($name)
	  if Want::want('REF');

	$node->getFields->getTiedField($name)
}

#sub getClone { $_[0]->new( $_[0]->getValue ) }

sub getCopy {
	my $value = $_[0]->getValue;
	return $_[0]->new( defined $value ? $value->getCopy : $value );
}

sub getInitialValue { $_[0]->getDefinition->getValue }

sub setValue {
	my ( $this, $value ) = @_;

	my $node = $this->getValue;
	if ($node) {
		$node->getParents->remove($this);
		#$node->dispose;
	}

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

	return;
}

sub toString { sprintf "%s", $_[0]->getValue || X3DGenerator->NULL }

sub dispose {    #print " SFNode::dispose ", $_[0]->getName;
	my ( $this ) = @_;

	return;
}

sub DESTROY {
	my $this = shift;
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

