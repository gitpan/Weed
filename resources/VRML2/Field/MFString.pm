package VRML2::Field::MFString;
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

sub increaseSize  {
	my $this   = CORE::shift;
	my $length = CORE::shift;
	#print CONSOLE " VRML2::MFString::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFString();
	}
}

sub toString {
	my $this = shift;
	#print CONSOLE " VRML2::Field::MFString::toString\n";

	return '['.$TSPACE.']' unless @{ $this };

	my $string = '';
	if ($#{ $this }) {
		$string .= '[';
		$string .= $TBREAK;
		INC_INDENT;
		$string .= $INDENT;
		$string .= join ",$TBREAK$INDENT", @{$this};
		$string .= $TBREAK;
		DEC_INDENT;
		$string .= $INDENT;
		$string .= ']';
	} else {
		$string .= "@{$this}";
	}

	return $string;
}
1;
__END__
