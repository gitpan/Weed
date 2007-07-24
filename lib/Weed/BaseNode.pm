package Weed::BaseNode;
use Weed;

our $VERSION = '0.009';

use Weed::Parse::FieldDescription;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	my $fieldDescriptions = Weed::Parse::FieldDescription::parse @{ $description->{body} };
	my $fieldDefinitions = [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ];
	$this->X3DPackage::Scalar("FieldDefinitions") = $fieldDefinitions;
}

use Weed 'X3DBaseNode : X3DObject { }';

our $Notify = YES;

use overload
  '@{}' => sub { ${ $_[0] }->{fields}->getArray },
  '%{}' => sub { ${ $_[0] }->{fields}->getHash },
  ;

sub new {
	my $this = shift->CREATE;
	my $name = shift;

	$this->setName($name);

	$this->setFields( new X3DFieldSet( scalar $this->getFieldDefinitions, $this ) );

	return $this;
}

sub getClone {
	my $this = shift;
	my $copy = $this->new( $this->getName );

	$$copy->{fields}->{$_}->setValue( $this->getField($_) )
	  foreach map { $_->getName } $this->getFieldDefinitions;

	return $copy;
}

sub getCopy { $_[0]->getClone }    # should make a deep copy

sub getTypeName { $_[0]->getType }

sub setName { ${ $_[0] }->{name} = new X3DName( $_[1] ) }
sub getName { ${ $_[0] }->{name}->toString }

# Fields
sub setFields { ${ $_[0] }->{fields} = $_[1] }
sub getFields { ${ $_[0] }->{fields} }

sub getField { ${ $_[0] }->{fields}->getField( $_[1], $_[0] ) }

sub getFieldDefinitions {
	wantarray ?
	  @{ $_[0]->X3DPackage::Scalar("FieldDefinitions") } :
	  $_[0]->X3DPackage::Scalar("FieldDefinitions")
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

	$string .= $$this->{fields};

	return $string;
}

sub dispose {
	my $this = shift;
	return;
}

#sub DESTROY {
#	my $this = shift;
#print "BaseNode::DESTROY";
#print "BaseNode::DESTROY ", $this->getName;
#printf "BaseNode::DESTROY: %d\n", $this->getReferenceCount;
#print  "BaseNode::Clones:  ", $this->{clones};
#}

1;
__END__
	#printf "BaseNode::dispose: %s, %d\n", $node->getName, $node->{clones};
Scalar::Quote 
