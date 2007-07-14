package Weed::FieldTypes::MFNode;

our $VERSION = '0.008';

use Weed 'MFNode : X3DArrayField { [] }';

use Weed::Tie::Value::BaseNodeArray;

sub new_from_definition {
	my $this = shift->X3DField::new_from_definition(@_);
	tie @{ $this->getValue }, 'Weed::Tie::Value::BaseNodeArray', $this;
	tie $this->length, 'Weed::Tie::ArrayLength', $this->getValue;
	return $this;
}

sub toString {
	my $this = shift;

	my $string = '';

	my $value = [ grep { $_ } @{ $this->getValue } ];

	if (@$value) {
		if ($#$value) {
			$string .= X3DGenerator->open_bracket;
			X3DGenerator->inc;
			$string .= X3DGenerator->tidy_break;
			$string .= X3DGenerator->indent;
			$string .= join X3DGenerator->tidy_break . X3DGenerator->indent, @$value;
			X3DGenerator->dec;
			$string .= X3DGenerator->tidy_break;
			$string .= X3DGenerator->indent;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= $value->[0];
		}
	}
	else {
		$string .= X3DGenerator->open_bracket;
		$string .= X3DGenerator->tidy_space;
		$string .= X3DGenerator->close_bracket;
	}

	return $string;
}

sub dispose {
	my ( $this, $node ) = @_;
	return;

# 	for ( my $i = $#$this ; $i > -1 ; $i-- ) {
# 		delete $this->[$i] if $this->[$i] == $node;
# 	}
# 
# 	print "MFNode::dispose";
# 	foreach my $parent ( @{ $this->getParents->getValues } ) {
# 		#		printf "MFNode::dispose: %s\n", ref $parent;
# 		unless ( $parent == $node ) {
# 			$parent->dispose($node);
# 		}
# 
# 	}
}

sub DESTROY {
	my $this = shift;
	$this->setValue( [] );
}

1;
__END__
