package Weed::FieldDefinition;

use Weed 'X3DFieldDefinition { }';

use overload
  'eq' => sub {
	return YES unless defined( $_[0]->getValue ) && defined( $_[1]->getValue );
	return $_[0]->getValue eq $_[1]->getValue;
  },
  ;

sub create {
	my $this = shift;
	@$this{qw'type in out name value range'} = @_;
}

sub getType { $_[0]->{type} }

sub isIn { $_[0]->{in} }

sub isOut { $_[0]->{out} }

sub getAccessType { ( $_[0]->{out} << 1 ) | $_[0]->{in} }

sub getName { $_[0]->{name} }

sub getValue { $_[0]->{value} }

sub getRange { $_[0]->{range} }

sub createField {
	my ( $this, $node ) = @_;

	my $field = $this->{type}->new( $this->getValue );
	$field->setDefinition($this);
	#$field->setParents( $node );

	return $field;
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

	$string .= X3DGenerator->tidy_space if $this->getAccessType != X3DConstants->inputOutput;
	$string .= join '', map { X3DGenerator->tidy_space x length $_ } grep { $_ }
	  !$this->isIn  && X3DGenerator->in,
	  !$this->isOut && X3DGenerator->out;

	$string .= X3DGenerator->space;
	$string .= $this->getName;

	$string .= X3DGenerator->space;

	my $value = $this->getValue;
	if ( 'ARRAY' eq ref $value ) {
		$string .= @$value ? join X3DGenerator->space, @$value : X3DGenerator->open_bracket . X3DGenerator->close_bracket;
	} else {
		$string .= $value || X3DGenerator->NULL;
	}

	$string .= X3DGenerator->tab;
	$string .= $this->getRange;

	return $string;
}

1;
__END__
