package SFString;
use strict;

#use rlib '..';
#use X3DField;
#use base 'X3DField';

sub INITIALIZE {
	my $this = shift;
	return $this->setValue($this->getValue ? shift : "");
}

sub STRINGIFY {
	my $this = shift;
	return sprintf '"%s"', $this->getValue;
}

1;
__END__

