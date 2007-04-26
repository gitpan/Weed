package Weed;
use strict;
use warnings;

our $VERSION = '0.0006';

sub import {
	my ( $class, %args ) = @_;
	my $package = caller;

	return unless Weed::Universal::IS_IN($package, __PACKAGE__);

	unshift @{ Weed::Universal::ARRAY($package, 'ISA') }, 'X3DObject';

	#printf "import weed   *** %s\n", $package;
}

use Weed::Environment;

1;
__END__
*setGreen = \&Math::Vec3::setY;
