package Weed::FieldDescription;

use Weed 'X3DFieldDescription { }';

sub create {
	my ( $this, $type, $in, $out, $name, @args ) = @_;

	$this->{type} = $type;
	$this->{name} = $name;

	$this->setInOut( $in, $out );
	@$this{qw'value range'} = @args;

	return;
}

sub isIn  { $_[0]->{in} }
sub isOut { $_[0]->{out} }

sub setInOut {
	my ( $this, $in, $out ) = @_;
	$this->{in}  = $in  ? X3DConstants->TRUE: X3DConstants->FALSE;
	$this->{out} = $out ? X3DConstants->TRUE: X3DConstants->FALSE;
	return;
}

sub getAccessType { ( $_[0]->{out} << 1 ) | $_[0]->{in} }

sub getName { $_[0]->{name} }

sub getValue { $_[0]->{value} }

sub getRange { $_[0]->{range} }

sub createFieldDefinition {
	my ($this) = @_;
}

#	MFNode   [in,out] children       []       [X3DChildNode]
sub toString {
	my ($this) = @_;

	my $string = '';
	$string .= $this->getType;
	$string .= X3DGenerator->space;

	$string .= X3DGenerator->open_bracket;
	$string .= join X3DGenerator->comma, grep { $_ }
	  $this->isIn  && X3DGenerator->in,
	  $this->isOut && X3DGenerator->out;
	$string .= X3DGenerator->close_bracket;

	$string .= X3DGenerator->nice_space if $this->getAccessType != X3DConstants->inputOutput;
	$string .= join '', map { X3DGenerator->nice_space x length $_ } grep { $_ }
	  !$this->isIn  && X3DGenerator->in,
	  !$this->isOut && X3DGenerator->out;

	$string .= X3DGenerator->space;
	$string .= $this->getName;

	$string .= X3DGenerator->space;
	$string .= $this->getValue;

	$string .= X3DGenerator->tab;
	$string .= $this->getRange;

	return $string;
}

1;
__END__
