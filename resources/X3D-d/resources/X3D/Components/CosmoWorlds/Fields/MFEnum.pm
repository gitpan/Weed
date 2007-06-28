package VRML2::Field::MFEnum;
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
	#print CONSOLE " VRML2::MFEnum::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFEnum();
	}
}

1;
__END__
