package Weed;
use strict;
use warnings;

our $VERSION = '0.0012';

sub import {
	my ( $class, %args ) = @_;
	my $package = caller;
	#printf "import weed   *** %s\n", $package;

	return if $package eq "main";
	#return unless Weed::Universal::IS_IN($package, __PACKAGE__);

	unshift @{ Weed::Universal::ARRAY($package, 'ISA') }, 'X3DObject';

}

use Weed::Environment;

1;
__END__
