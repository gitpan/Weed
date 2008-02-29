package Weed::BaseNode;
use Weed;

our $VERSION = '0.016';

use Want      ();
use Sub::Name ();

use Weed::Parse::FieldDescription;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	print $this;
	my $fieldDescriptions = Weed::Parse::FieldDescription::parse $description->{body};
	my $fieldDefinitions = [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ];
	$this->X3DPackage::Scalar("X3DFieldDefinitions") = [];
	$this->setFieldDefinitions($fieldDefinitions) if @$fieldDefinitions;
}

use Weed 'X3DBaseNode : X3DObject { }';

sub new {
	my $this = shift->X3DObject::new;
	my $name = shift;

	$this->setName($name);

	$this->setFields( new X3DFieldSet( $this->getFieldDefinitions, $this ) );

	$this->getCallbacks->add( $this->can("processEvent") );

	return $this;
}

sub getClone {
	my ($this) = @_;
	my $copy = $this->new( $this->getName );

	$copy->getField( $_->getName )->setValue( $_->getValue )
	  foreach @{ $this->getFields };

	return $copy;
}

sub getCopy { $_[0]->getClone }    # should make a deep copy

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = new X3DName( $_[1] ) }
sub getName { $_[0]->{name}->toString }

# Fields
sub setFields {
	my ( $this, $fields ) = @_;
	$this->{fields} = $fields;
}
sub getFields { $_[0]->{fields} }

sub getField { $_[0]->getFields->getField( $_[1], $_[0] ) }

sub setFieldDefinitions {
	my ( $this, $fieldDefinitions ) = @_;

	$this->X3DPackage::Scalar("X3DFieldDefinitions") = $fieldDefinitions;
	$this->createFieldClosures($fieldDefinitions);
	$this->createFieldCallbacks($fieldDefinitions);

	return;
}
sub getFieldDefinitions { $_[0]->X3DPackage::Scalar("X3DFieldDefinitions") }

sub processEvent {
	my ( $this, $value, $time ) = @_;
	#X3DMessage->Debug(@_);

	$_->getDefinition->processEvents( $this, $_, $time )
	  foreach @{ $this->getFields };

	return;
}

sub createFieldCallbacks {
	my ( $this, $fieldDefinitions ) = @_;

	my $sypertype = $this->X3DPackage::getSupertype;

	foreach ( grep { $_->isIn } @$fieldDefinitions )
	{
		#X3DMessage->Debug( $this, $sypertype->UNIVERSAL::can( $_->getName ) );

		$_->getCallbacks->add( $sypertype->UNIVERSAL::can( $_->getName ) )
		  if $_->getAccessType == X3DConstants->inputOnly;

		$_->getCallbacks->add( $sypertype->UNIVERSAL::can( "set_" . $_->getName ) )
	}

	return;
}

sub createFieldClosures {
	my ( $this, $fieldDefinitions ) = @_;

	my $package = $this->X3DPackage::getName;

	foreach my $fieldDefinition (@$fieldDefinitions) {
		my $name = $fieldDefinition->getName;
		my $fieldClosure = $this->createFieldClosure( $package, $name );
		$package->X3DPackage::Glob($name) = $fieldClosure;

		$package->X3DPackage::Glob( "set_" . $name ) =
		  $package->X3DPackage::Glob( $name . "_changed" ) = $fieldClosure
		  if $fieldDefinition->getAccessType == X3DConstants->inputOutput;
	}

	return;
}

sub createFieldClosure {
	my ( $this, $package, $name ) = @_;

	return Sub::Name::subname $package . "::" . $name => sub  : lvalue {
		#X3DMessage->Debug( $_[0], caller(0) );
		my $this = shift;

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
	};
}

# Basenode
sub toString {
	my ($this) = @_;

	my $string = "";

	if ( $this->getName ) {
		$string .= X3DGenerator->DEF;
		$string .= X3DGenerator->space;
		$string .= $this->getName;
		$string .= X3DGenerator->space;
	}

	$string .= $this->getTypeName;
	$string .= X3DGenerator->tidy_space;

	if ( @{ $this->getComments } ) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach ( $this->getComments ) {
			$string .= X3DGenerator->indent;
			$string .= X3DGenerator->comment;
			$string .= $_;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}

	$string .= $this->getFields;

	return $string;
}

# sub DESTROY {
# 	X3DMessage->Debug( $_[0] );
# 	return;
# }

1;
__END__
	#printf "BaseNode::dispose: %s, %d\n", $node->getName, $node->{clones};
Scalar::Quote 

	print '';
	print 'wantref: ', Want::wantref() if Want::wantref();
	print 'VOID'      if Want::want('VOID');
	print 'SCALAR'    if Want::want('SCALAR');
	print 'REF'       if Want::want('REF');
	print 'REFSCALAR' if Want::want('REFSCALAR');
	print 'CODE'      if Want::want('CODE');
	print 'HASH'      if Want::want('HASH');
	print 'ARRAY'     if Want::want('ARRAY');
	print 'GLOB'      if Want::want('GLOB');
	print 'OBJECT'    if Want::want('OBJECT');
	print 'BOOL'      if Want::want('BOOL');
	print 'LIST'      if Want::want('LIST');
	print 'COUNT'     if Want::want('COUNT');
	print 'Infinity'  if Want::want('Infinity');
	print 'LVALUE'    if Want::want('LVALUE');
	print 'ASSIGN'    if Want::want('ASSIGN');
	print 'RVALUE'    if Want::want('RVALUE');

*{"${callpkg}::$sym"} =
	    $type eq '&' ? \&{"${pkg}::$sym"}
