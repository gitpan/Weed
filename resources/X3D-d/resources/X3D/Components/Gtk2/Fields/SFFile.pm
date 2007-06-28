package SFFile;
use strict;
use warnings;

use X3D::FieldIndex;
use base 'SFString';



1;
package main;
use strict;
use warnings;

my $file = new SFFile("/xxx.xxx");
printf "%s\n", $file;

1;
__END__
