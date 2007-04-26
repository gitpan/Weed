package FooBah;
use strict;
use warnings;

our $VERSION = '0.0003';

use Weed;

use base 'Exporter';

our @EXPORT = qw{
  createBrowser
  getBrowser
};

my $Universum = new X3DUniversum(__PACKAGE__);

sub createBrowser { $Universum->createBrowser }
sub getBrowser    { $Universum->getBrowser }

1;
__END__
