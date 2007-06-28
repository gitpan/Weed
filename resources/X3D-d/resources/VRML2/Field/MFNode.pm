package VRML2::Field::MFNode;
use strict;

BEGIN {
	use Carp;

	use VRML2::MField;

	use VRML2::Generator;

	use VRML2::Console;

	use vars qw(@ISA);
	@ISA = qw(VRML2::MField);
}

use overload
	'""' => \&toString;

sub setValue  {
	my $this = shift;
	
	if (ref $_[0] eq 'ARRAY') {
		@{$this} = @{$_[0]};
	} elsif (@_) {
		@{$this} = @_;
	} else {
		@{$this} = ();
	}
}

sub increaseSize  {
	my $this   = CORE::shift;
	my $length = CORE::shift;
	#print CONSOLE " VRML2::MFNode::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFNode();
	}
}

sub push {
	my $this  = shift;
	CORE::push @{$this}, @{$_[0]};
}

sub splice {
	my $this  = shift;
	CORE::splice @{$this}, @_;
}

sub remove {
	my $this  = shift;
	my $node  = shift;

	my $index = $this->getIndex($node);
	CORE::splice @{$this}, $index, 1;
}

sub getIndex {
	my $this = shift;
	my $node  = shift;

	my $length = $this->length;
	my $nodeId = $node->getId;

	my $index;
	for (my $i = 0; $i < $length; ++$i) {
		if ($nodeId eq $this->[$i]->getId) {
			$index = $i;
			last;
		}
	}

	return $index;
}

sub toString {
	my $this = CORE::shift;
	#print CONSOLE " VRML2::Field::MFNode::toString\n";

	return "[$TSPACE]" unless @{ $this };

	my $string = '';
	if ($#{ $this }) {
		$string .= "[";
		INC_INDENT;
		$string .= $TBREAK;
		$string .= $INDENT;
		$string .= join "$TBREAK$INDENT", @{$this};
		$string .= $TBREAK;
		DEC_INDENT;
		$string .= $INDENT;
		$string .= "]";
	} else {
		$string .= $this->[0];
	}
	
	return $string;
}

1;
__END__
use overload
	'""' => \&toString;

sub toString {
	my $this   = shift;
	return "[ ]";
}

