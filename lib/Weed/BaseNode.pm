package Weed::BaseNode;
use Weed;

our $VERSION = '0.0081';

use Weed::Parse::FieldDescription;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	my $fieldDescriptions = Weed::Parse::FieldDescription::parse @{ $description->{body} };
	my $fieldDefinitions = [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ];
	$this->X3DPackage::Scalar("FieldDefinitions") = $fieldDefinitions;
}

use Weed 'X3DBaseNode : X3DObject { }';

sub new {
	my $this = shift->CREATE;
	my $name = shift;

	$this->setName($name);

	$this->setCloneCount(0);

	tie $this->{fields}->{ $_->getName }, 'Weed::Tie::Field', $_->createField($this)
	  foreach $this->getFieldDefinitions;

	# $this->{fields}->{sf[color|colorrgba|...]} *= 2 needs ref
	map { ref $this->{fields}->{ $_->getName } } $this->getFieldDefinitions;

	return $this;
}

sub getCopy {
	my $this = shift;
	my $copy = $this->new( $this->getName );

	$copy->getTiedField($_) = $this->getField($_)
	  foreach map { $_->getName } $this->getFieldDefinitions;

	return $copy;
}

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = new X3DName( $_[1] ) }
sub getName { $_[0]->{name}->toString }

# Clones
sub addClone      { $_[0]->{clones}++ }
sub removeClone   { $_[0]->{clones}-- }
sub getCloneCount { $_[0]->{clones} }
sub setCloneCount { $_[0]->{clones} = $_[1] }

# Fields
sub existsField { exists $_[0]->{fields}->{ $_[1] } }

sub getTiedField : lvalue {
	my ( $this, $name ) = @_;

	X3DMessage->UnknownField( 2, @_ ), return unless exists $this->{fields}->{$name};

	return ${ tied $this->{fields}->{$name} }
	  if Want::want('CODE') || Want::want('OBJECT') || Want::want('ARRAY');

	$this->{fields}->{$name};
}

sub getField {
	my ( $this, $name ) = @_;
	return ${ tied $this->getTiedField($name) };
}

sub getFields {
	my ( $this, $tidy ) = @_;
	my $fields = [];

	foreach ( $this->getFieldDefinitions ) {
		my $field = $this->getField( $_->getName );

		push @$fields, $field
		  unless
		  ( $_->isIn ^ $_->isOut ) ||
		  ( $tidy && ( $_ eq $field ) );
	}

	return wantarray ? @$fields : $fields;
}

sub getFieldDefinitions {
	wantarray ?
	  @{ $_[0]->X3DPackage::Scalar("FieldDefinitions") } :
	  $_[0]->X3DPackage::Scalar("FieldDefinitions")
}

# Basenode
sub toString {
	my $this   = shift;
	my $string = "";

	if ( $this->getName ) {
		$string .= X3DGenerator->DEF;
		$string .= X3DGenerator->space;
		$string .= $this->getName;
		$string .= X3DGenerator->space;
	}

	$string .= $this->getTypeName;
	$string .= X3DGenerator->tidy_space;
	$string .= X3DGenerator->open_brace;

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

	my $fields = $this->getFields( X3DGenerator->tidy_fields );
	if (@$fields) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach (@$fields) {
			$string .= X3DGenerator->indent;
			$string .= $_->getName;
			$string .= X3DGenerator->space;
			$string .= $_->isa('SFString') ? sprintf X3DGenerator->STRING, $_ : $_;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}
	else {
		$string .= X3DGenerator->tidy_space;
	}

	$string .= X3DGenerator->close_brace;

	return $string;
}

sub canDispose {
	my $this = shift;
	my $node = shift || $this;

	my $parents = $this->getParents->getValues;

	my @parentNodes = grep { $node != $_ } map { $_->getParent } @$parents;

	if (@parentNodes) {
		foreach my $parentNode (@parentNodes) {
			return YES if $parentNode->canDispose($node);
		}
	} else {
		return YES;
	}

	return;
}

sub dispose {    #print " BaseNode::dispose ", $_[0]->getName;
	my $this = shift;
	my $node = shift || $this;

	return;

	# 	return unless $node->getCloneCount;
	# 	return unless $node->canDispose;
	#
	# 	my $parents = $this->getParents->getValues;
	#
	# 	foreach my $field (@$parents) {
	# 		$field->dispose($node);
	# 	}

}

sub DESTROY {
	my $this = shift;
	#print "BaseNode::DESTROY";
	#print "BaseNode::DESTROY ", $this->getName;
	#printf "BaseNode::DESTROY: %d\n", $this->getReferenceCount;
	#print  "BaseNode::Clones:  ", $this->{clones};
}

1;
__END__
	#printf "BaseNode::dispose: %s, %d\n", $node->getName, $node->{clones};

