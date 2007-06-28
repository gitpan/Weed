#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
my $fd   = new X3DFieldDefinition (X3DField::inputOutput, 'metadata', 'new SFNode(NULL)', 'X3DMetadataObject');
my $f    = new X3DField (X3DField::inputOutput, 'metadata', 'new SFNode(NULL)', 'X3DMetadataObject');
my $node = new X3DNode;

printf "%s\n", $fd;
printf "%s\n", $f;
printf "%s\n", $node;

1;
__END__
