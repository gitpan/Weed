package Weed;
use Weed::Perl;

#use v5.6.1;
use v5.8.8;

our $VERSION = '0.0077';

sub import {
	shift;
	strict::import;
	warnings::import;
	Weed::Perl->export_to_level(1);
	Weed::Package::createType( scalar caller, 'X3DUniversal', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - Don't use it. It's in development. For test purposes only!

=cut
