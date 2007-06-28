package VRML2::Field::MFFloat;
use strict;

BEGIN {
	use Carp;
	
	use VRML2::MField;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::MField);
}

sub increaseSize  {
	my $this   = CORE::shift;
	my $length = CORE::shift;
	#print CONSOLE " VRML2::MFFloat::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFFloat();
	}
}

1;
__END__
