package Weed::FieldTypes::SFNode;

use Weed 'SFNode : X3DField { NULL }';

use overload
  'int' => sub { $_[0]->getValue ? 1 : 0 },
  '0+'  => sub { $_[0]->getValue ? 1 : 0 },

  '==' => sub { $_[0]->getId == $_[1] },
  '!=' => sub { $_[0]->getId != $_[1] },
  ;

sub AUTOLOAD : lvalue {    #X3DMessage->Debug(@_);
	my $this = shift;
	my $name = substr our $AUTOLOAD, rindex( $AUTOLOAD, ':' ) + 1;

	my $node = $this->getValue;
	X3DMessage->UnknownField( $this, $AUTOLOAD ) unless ref $node;

	if ( Want::want('RVALUE') ) {
		my $field = $node->getField($name);
		Want::rreturn $field if Want::want 'ARRAY';
		#X3DMessage->Debug('clone');
		Want::rreturn $field->clone;
	}

	if ( Want::want('ASSIGN') ) {
		$node->getField($name)->setValue( Want::want('ASSIGN') );
		Want::lnoreturn;
	}

	die unless Want::want('LVALUE');

	return ${ tied $node->private_getField($name) }
	  if Want::want('CODE') || Want::want('OBJECT') || Want::want('ARRAY');

	$node->private_getField($name)
}

sub setValue {
	my ( $this, $value ) = @_;

	return $this->X3DField::setValue( $value->getValue )
	  if UNIVERSAL::isa( $value, 'SFNode' );

	return $this->X3DField::setValue($value)
	  if UNIVERSAL::isa( $value, 'X3DNode' ) || !defined $value;

	X3DMessage->ValueHasToBeAtLeastOfTypeX3DNode(@_);
}

sub toString { sprintf "%s", $_[0]->getValue || X3DGenerator->NULL }

1;
__END__

	print '';
	print Want::wantref() if Want::wantref();
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

