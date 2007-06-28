package VRML2::Field::MFColor;
use strict;

BEGIN {
	use Carp;
	
	use VRML2::MField;
	
	use VRML2::Console;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::MField);
}

sub increaseSize  {
	my $this   = CORE::shift;
	my $length = CORE::shift;
	#print CONSOLE " VRML2::MFColor::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFColor();
	}
}

1;
__END__
