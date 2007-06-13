package Weed::Object;
use Weed::Perl;

our $VERSION = '0.0031';

use Scalar::Util;

sub type { CORE::ref $_[0] }

*id = \&Scalar::Util::refaddr;

*stringify = \&overload::StrVal;

1;
__END__

=head1 NAME

object - minimum object

=head1 SYNOPSIS

	use base 'object';

=head1 FUNCTIONS

=head2 say

from L<Perl6::Say>

=head2 time

from L<Time::HiRes>

=head1 COPYRIGHT

This is free software; you can redistribute it and/or modify it
under the same terms as L<Perl|perl> itself.

=cut
