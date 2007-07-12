package Weed::Perl;
use strict;
use warnings;
#no warnings 'redefined';

our $VERSION = '0.0079';

use base 'Exporter';

use Time::HiRes 'time';
use Scalar::Util;

use constant NO  => defined;
use constant YES => not NO;

our @EXPORT    = qw.YES NO.;
our @EXPORT_OK = qw.time.;

#$, = " ";
$\ = "\n";

sub import {
	my $pkg = shift;

	strict::import;
	warnings::import;
	#warnings::unimport('redefine');

	Exporter::export( $pkg, 'CORE::GLOBAL', @EXPORT_OK );
	Exporter::export_to_level( $pkg, 1 );
}

sub unimport {
	strict->unimport;
	warnings->unimport;
}

1;
__END__

sub type { CORE::ref $_[0] }

*id = \&Scalar::Util::refaddr;

*stringify = \&overload::StrVal;

