package SFFloat;
use strict;
use warnings;

BEGIN {
 	use rlib "../../";

	use base qw(X3D::Field::SFValue);
	our $VERSION = '0.00';
	__PACKAGE__ -> bootstrap($VERSION);
}

use X3DGenerator qw($FLOAT);

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return sprintf $FLOAT, $this->getValue;
}

1;
__END__
