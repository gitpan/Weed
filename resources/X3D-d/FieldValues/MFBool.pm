package MFBool;
use strict;
use warnings;

use rlib "../";

use ArrayValue;
use base qw(ArrayValue);

use SFBool;
our $SField = new SFBool;

1;
__END__

my $mfbool = __PACKAGE__->new( 1, 2, 3, 0, 3, 0, 1, 0, 1, 0 );
$mfbool->[0] = 0;
$mfbool->length(20);

my @a = $mfbool->getValue;
$a[0] = 1;

printf "%s\n", __PACKAGE__->new();
printf "%s\n", $mfbool->length;
printf "%s\n", $mfbool;
