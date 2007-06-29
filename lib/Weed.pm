package Weed;
use Weed::Perl;

our $VERSION = '0.0065';

sub import {
	shift;
	strict::import;
	warnings::import;
	Weed::Perl->export_to_level(1);
	Weed::Universal::createType( scalar caller, 'X3DObject', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - Don't use it. It's in development. Everything's gonna change.

=cut
