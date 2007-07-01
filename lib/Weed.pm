package Weed;
use Weed::Perl;

our $VERSION = '0.0072';

sub import {
	shift;
	strict::import;
	warnings::import;
	Weed::Perl->export_to_level(1);
	Weed::Universal::createType( scalar caller, 'X3DUniversal', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - Don't use it. It's in development. For test purposes only!

=cut
