package VRML2::Field::MFVec3f;
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
	#print CONSOLE " VRML2::MFVec3f::increaseSize\n";

	for (my $i = @{$this}; $i < $length; ++$i) {
		$this->[$i] = new SFVec3f();
	}
}

sub avg  {
	my $this  = CORE::shift;
	my $value = new SFVec3f(0,0,0);

	foreach (@$this) {
		$value->[0] += $_->[0];
		$value->[1] += $_->[1];
		$value->[2] += $_->[2];
	}
	
	return $this->length ? $value->divide($this->length) : new SFVec3f(0,0,0);
}

1;
__END__
