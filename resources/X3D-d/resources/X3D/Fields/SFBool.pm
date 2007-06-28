package SFBool;
use strict;
use warnings;

use rlib "../";

use base 'X3DField';

our $FALSE = "FALSE";
our $TRUE  = "TRUE";

sub stringify {
	my $this = shift;
	return $this->getValue ? $TRUE: $FALSE;
}

1;
__END__
