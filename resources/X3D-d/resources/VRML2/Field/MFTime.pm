package VRML2::Field::MFTime;
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
	#print CONSOLE " VRML2::MFTime::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFTime();
	}
}

1;
__END__
