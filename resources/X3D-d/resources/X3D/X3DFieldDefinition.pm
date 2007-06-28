package X3DFieldDefinition;
use strict;
use warnings;

use rlib "./";

use X3DField;
use base 'X3DField';

sub STRINGIFY {
	my ($this) = @_;
	my $string = "";
	
	$string .= $AccessType[$this->getAccessType];
	$string .= " ";
	$string .= $this->getType;
	$string .= " ";
	$string .= $this->getName;
	$string .= " ";
	$string .= $this->getValue;

	return $string;
}

1;
__END__
