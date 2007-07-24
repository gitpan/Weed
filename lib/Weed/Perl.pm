package Weed::Perl;
use strict;
use warnings;
#no warnings 'redefined';

our $VERSION = '0.009';

use base 'Exporter';

use Weed::Time;

use constant NO  => defined;
use constant YES => not NO;

our @EXPORT = qw.YES NO.;

$, = " ";
$\ = "\n";

sub import {
	my $pkg = shift;

	strict::import;
	warnings::import;
	#warnings::unimport('redefine');

	Exporter::export_to_level( $pkg, 1 );
}

sub unimport {
	strict->unimport;
	warnings->unimport;
}

1;
__END__
