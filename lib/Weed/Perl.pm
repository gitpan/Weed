package Weed::Perl;
use strict;
use warnings;

use base 'Exporter';

use Perl6::Say;
use Time::HiRes 'time';

use constant NO  => defined;
use constant YES => not NO;

our $VERSION = '0.0004';
our @EXPORT  = qw.YES NO say time.;

sub import {
	my $package = caller;
	strict->import;
	warnings->import;
	__PACKAGE__->export_to_level( 1, $package, @EXPORT );
}

sub unimport {
	strict->unimport;
	warnings->unimport;
}

1;
__END__
