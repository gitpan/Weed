package Weed::Generator::Symbols;
use strict;
use warnings;

use Weed::Symbols;

use base 'Exporter';

our @EXPORT = qw(
  $string_
  $seed_
);

our $space  = ' ';
our $tspace = $space;

# Terminal symbols
our $period        = '.';
our $open_brace    = '{';
our $close_brace   = '}';
our $open_bracket  = '[';
our $close_bracket = ']';
our $colon         = ':';

our $string_ = "%s";
our $seed_   = "%s$tspace$open_brace$tspace$close_brace";

1;
__END__
