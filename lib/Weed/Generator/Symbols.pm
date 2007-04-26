package Weed::Generator::Symbols;
use strict;
use warnings;

our $VERSION = '0.0003';

use Weed::Symbols;

use base 'Exporter';

our @EXPORT = qw(
  $seed_
);

# Terminal symbols
our $period        = '.';
our $open_brace    = '{';
our $close_brace   = '}';
our $open_bracket  = '[';
our $close_bracket = ']';
our $colon         = ':';


our $seed_ = "%s$open_brace$close_brace";

1;
__END__
