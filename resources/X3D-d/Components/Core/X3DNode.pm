package X3DNode;
use strict;
use warnings;

#use AutoSplit; autosplit('X3DNode', './auto/', 0, 1, 1);

use rlib "../../";

use base qw(X3DObject);

use X3DConstants;
use X3DFieldDefinition;

our $FieldDefinitions =
  [ new X3DFieldDefinition( inputOutput, 'metadata', NULL, 'X3DMetadataObject' ) ];

use AutoLoader;
our $AUTOLOAD;

sub AUTOLOAD {
	my $this = shift;
	my $name = substr $AUTOLOAD, rindex( $AUTOLOAD, ':' ) + 1;

	#X3DError::Debug $name;
	my $field = $this->getField($name);
	return unless ref $field;

	return $field->setValue(@_) if @_;
	return $field->getValue;
}

sub create {    #X3DError::Debug ref $_[0];
	my $this = shift;
	$this->{name}     = shift || "";
	$this->{comments} = shift || [];

	$this->{browser} = undef;    # X3DNode
	$this->{parents} = {};       # {X3DNode, ...}

	foreach ( $this->getFieldDefinitions ) {
		my $name  = $_->getName;
		my $field = $_->getField($this);
		$field->addFieldCallback( "_$name", $this ) if $this->can("_$name");
		$this->{fields}->{$name} = $field;
	}
}

sub copy { die "X3DNode::copy not implemented yet" }

sub setBrowser { $_[0]->{browser} = $_[1] }
sub getBrowser { $_[0]->{browser} }

sub addParent {    #*
	my ( $this, $parent ) = @_;
	my $id = $parent->getId;
	$this->{parents}->{$id} = $parent;
}

sub removeParent {    #*
	my ( $this, $parent ) = @_;
	my $id = $parent->getId;
	delete $this->{parents}->{$id};
}

sub getParents {      #*
	my ($this) = @_;
	my @parents = values %{ $this->{parents} };
	return wantarray ? @parents : [@parents];
}

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = $_[1] }    #*
sub getName { $_[0]->{name} }

sub setComment { $_[0]->{comment} = $_[1] }    #*
sub getComment { $_[0]->{comment} }            #*

sub getField {
	my ( $this, $name ) = @_;
	return X3DError::UnknownField $this, $name unless exists $this->{fields}->{$name};
	return $this->{fields}->{$name};
}

sub getFieldDefinitions { $_[0]->getData("FieldDefinitions") }

#sub setFields {
#	my ( $this, $fields ) = @_;
#	return;
#}

sub getFields {
	my ( $this, $all ) = @_;
	my $fields = [];

	foreach ( $this->getFieldDefinitions ) {
		push @$fields, $this->{fields}->{ $_->getName }
		  if ( $_->getAccessType == inputOutput || $_->getAccessType == initializeOnly )
		  && ( $_->getValue != $this->{fields}->{ $_->getName }->getValue || $all );
	}

	return wantarray ? @$fields : $fields;
}

sub processEvents {    #X3DError::Debug;
	my ($this) = @_;
	my $time = time;

	$this->call("prepareEvents");

	foreach ( map { $_->getName } $this->getFieldDefinitions ) {
		$this->{fields}->{$_}->processEvent($time);
	}

	$this->call("eventsProcessed");
	return;
}

sub toString {
	my $this   = shift;
	my $string = "";

	if ( $this->{name} ) {
		$string .= "DEF";
		$string .= $X3DGenerator::SPACE;
		$string .= $this->{name};
		$string .= $X3DGenerator::SPACE;
	}

	$string .= $this->getTypeName;
	$string .= $X3DGenerator::TSPACE;
	$string .= "{";

	if ( @{ $this->{comments} } ) {
		$string .= $X3DGenerator::TBREAK;
		X3DGenerator::INC_INDENT;
		foreach ( @{ $this->{comments} } ) {
			$string .= $X3DGenerator::INDENT;
			$string .= "#";
			$string .= $_;
			$string .= $X3DGenerator::TBREAK;
		}
		X3DGenerator::DEC_INDENT;
		$string .= $X3DGenerator::INDENT;
	}

	my $fields = $this->getFields($X3DGenerator::AllFields);
	if (@$fields) {
		$string .= $X3DGenerator::TBREAK;
		X3DGenerator::INC_INDENT;
		foreach (@$fields) {
			$string .= $X3DGenerator::INDENT;
			$string .= $_;
			$string .= $X3DGenerator::TBREAK;
		}
		X3DGenerator::DEC_INDENT;
		$string .= $X3DGenerator::INDENT;
	}

	$string .= "}";

	return $string;
}

1;
__END__
printf "%s\n", __PACKAGE__->new;

__DATA__
Creation phase
Setup phase
	setBrowser
	setFields
	initialize
Realized phase
	prepareEvents
	eventsProcessed
Disposed phase
	shutdown

