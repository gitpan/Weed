package Weed;
use Weed::Perl;

#use v5.6.1;
use 5.8.8;

our $VERSION = '0.0079';

use warnings::register;

sub import {
	shift;
	strict::import;
	warnings::import;
	#warnings::unimport('redefine');
	Weed::Perl->export_to_level(1);
	Weed::Package::createType( scalar caller, 'X3DUniversal', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - Don't use it. It's in development. For test purposes only!

=cut

Probs:
BaseNode createFields; have to do a ref() to the tied fields
ArrayFields; tied fields cannot fetch object or array ref ("bu_" in package Want)
