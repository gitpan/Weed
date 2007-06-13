#!/usr/bin/perl -w
#package 00_concept
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Parse::Concept';
}

ok parse::concept('a{}');
is ref parse::concept('a{}'),   'HASH';
is ref parse::concept('a {}'),  'HASH';
is ref parse::concept('a { }'), 'HASH';
is ref parse::concept('a{ }'),  'HASH';

ok parse::concept('X3DNode {}')->{name},         'X3DNode';
ok parse::concept('X3DChildNode {}')->{name},    'X3DChildNode';
ok parse::concept('X3DCh::ildNode {}')->{name},  'X3DCh::ildNode';
ok parse::concept('_X3DCh::ildNode {}')->{name}, '_X3DCh::ildNode';

is parse::concept('X3DChildNode:X3DNode{}')->{name},   'X3DChildNode:X3DNode';
is parse::concept('X3DChildNode : X3DNode{}')->{name}, 'X3DChildNode';
is parse::concept('X3DChildNode : X3DNode{}')->{supertypes}->[0], 'X3DNode';
is parse::concept('A : B C {}')->{name}, 'A';
is parse::concept('A : B C {}')->{name}, 'A';
is parse::concept('A : B C {}')->{supertypes}->[0],  'B';
is parse::concept('A : B C {}')->{supertypes}->[1],  'C';
is parse::concept('A : B C D{}')->{supertypes}->[2], 'D';

ok !parse::concept('a :{}');
ok !parse::concept('a : {}');
ok !parse::concept('b :a {}');
ok parse::concept('b : a {}');

ok parse::concept('b : a {0}');
ok parse::concept('b : a { 0 }')->{body}->[0] eq '0';
is parse::concept('b : a {0}')->{body}->[0],   '0';
is parse::concept('b : a {0 }')->{body}->[0],  '0';
is parse::concept('b : a { 0 }')->{body}->[0], '0';
is parse::concept('b : a { 0}')->{body}->[0],  '0';

is parse::concept('b : a { 0 0}')->{body}->[0],  '0 0';
is parse::concept('b : a { 0 0 }')->{body}->[0], '0 0';
is parse::concept('b : a {0 0 }')->{body}->[0],  '0 0';
is parse::concept("b : a {0 0 }")->{body}->[0],  "0 0";
is parse::concept("b : a {0 0 0}")->{body}->[0], "0 0 0";
is parse::concept("b : a {1 2 3}")->{body}->[0], "1 2 3";

is parse::concept( "b : a {
0 0 0
}" )->{body}->[0], "0 0 0";

is parse::concept( "b : a {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}" )->{body}->[0],
  "SFNode [in,out] metadata NULL [X3DMetadataObject]";

is parse::concept( '
Anchor : X3DGroupingNode { 
  MFNode   [in]     addChildren
  MFNode   [in]     removeChildren
  MFNode   [in,out] children       []       [X3DChildNode]
  SFString [in,out] description    ""
  SFNode   [in,out] metadata       NULL     [X3DMetadataObject]
  MFString [in,out] parameter      []
  MFString [in,out] url            []       [url or urn]
  SFVec3f  []       bboxCenter     0 0 0    (-\u221e,\u221e)
  SFVec3f  []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121 
}
')->{body}->[8],
  'SFVec3f  []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121';

__END__

ok parse::concept 'X3DNode{}';
parse::concept 'X3DNode { }';

parse::concept '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';
