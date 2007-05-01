#!/usr/bin/perl -w
#package 04_fieldDescription
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed 'Weed : X3DNode {
  SFNode   [in,out] metadata    NULL    [X3DMetadataObject]
  MFString []       family      "SERIF"
  SFBool   []       horizontal  TRUE
  MFString []       justify     "BEGIN" ["BEGIN"|"END"|"FIRST"|"MIDDLE"|""]
  SFString []       language    ""
  SFBool   []       leftToRight TRUE
  SFFloat  []       size        1.0     (0,\u221e)
  SFFloat  []       spacing     1.0     [0,\u221e)
  SFString []       style       "PLAIN" ["PLAIN"|"BOLD"|"ITALIC"|"BOLDITALIC"|""]
  SFBool   []       topToBottom TRUE
}
';

ok my $weed = new Weed;
isa_ok $weed, $_ foreach $weed->PATH;
ok $weed ;
isa_ok $weed, $_ foreach $weed->getHierarchy;
ok $weed ;
printf "%s\n", $weed;

1;
__END__
