package X3DNode;
use strict;
use warnings;
use rlib "./";
#use AutoSplit; autosplit('../X3D/X3DNode', './auto/', 0, 1, 1);

=X3DMetadataObject { 
  SFString [in,out] name      ""
  SFString [in,out] reference "" 
}
=cut

use X3DFieldDefinition;
use X3DField;

use base 'X3DObject';

our $FieldDefinitions = [
	new X3DFieldDefinition (inputOutput, 'metadata', 'new SFNode(NULL)', 'X3DMetadataObject'),
];

use AutoLoader;
our $AUTOLOAD;

sub AUTOLOAD {
	my $this = shift;
	my $name = substr $AUTOLOAD, rindex($AUTOLOAD, ':') +1;

	printf "AUTOLOAD: %s\n", $name;

	return $this->getField($name)->setValue if @_;
	return $this->getField($name)->getValue;
}

sub CREATE {
	my $this = shift;
	$this->{fields} = {};
	$this->{fields}->{$_->getName} = $_->copy foreach $this->getFieldDefinitions;
}

sub getTypeName {
	my $this = shift;
	return ref $this;
}

sub getField {
	my ($this, $name) = @_;
	return unless exists $this->{$name};
	return $this->{$name};
}

sub getFieldDefinitions {
	my $this = shift;
	return wantarray ? @$FieldDefinitions : $FieldDefinitions;
}

sub setBody {
	my ($this, $body) = @_;
	return;
}

sub STRINGIFY {
	my $this = shift;
	return sprintf "%s {}", $this->getTypeName;
}

1;
__END__
