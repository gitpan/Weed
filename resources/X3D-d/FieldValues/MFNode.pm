package MFNode;
use strict;
use warnings;

use rlib "../";

use ArrayValue;
use base qw(ArrayValue);

use SFNode;
our $SField = new SFNode;

sub index {
	my ( $this, $sfnode ) = @_;
	for ( my $i = 0 ; $i < @$this ; ++$i ) {
		return $i if $this->[$i] == $sfnode;
	}
	return -1;
}

sub toString {
	my $this = shift;

	return "[${X3DGenerator::TSPACE}]" unless @$this;

	my $string = '';
	if ($#$this) {
		$string .= "[${X3DGenerator::TBREAK}";
		X3DGenerator::INC_INDENT;
		$string .= $X3DGenerator::INDENT;
		$string .= join $X3DGenerator::TBREAK.$X3DGenerator::INDENT, @$this;
		X3DGenerator::DEC_INDENT;
		$string .= "${X3DGenerator::TBREAK}${X3DGenerator::INDENT}]";
	} else {
		$string .= $this->[0];
	}

	return $string;
}

1;
__END__
