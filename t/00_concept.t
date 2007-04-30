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

ok parse::Concept('a{}');
is ref parse::Concept('a{}'),   'HASH';
is ref parse::Concept('a {}'),  'HASH';
is ref parse::Concept('a { }'), 'HASH';
is ref parse::Concept('a{ }'),  'HASH';

ok parse::Concept('X3DNode {}')->{name},         'X3DNode';
ok parse::Concept('X3DChildNode {}')->{name},    'X3DChildNode';
ok parse::Concept('X3DCh::ildNode {}')->{name},  'X3DCh::ildNode';
ok parse::Concept('_X3DCh::ildNode {}')->{name}, '_X3DCh::ildNode';

is parse::Concept('X3DChildNode:X3DNode{}')->{name},   'X3DChildNode:X3DNode';
is parse::Concept('X3DChildNode : X3DNode{}')->{name}, 'X3DChildNode';
is parse::Concept('X3DChildNode : X3DNode{}')->{supertypes}->[0], 'X3DNode';
is parse::Concept('A : B C {}')->{name}, 'A';
is parse::Concept('A : B C {}')->{name}, 'A';
is parse::Concept('A : B C {}')->{supertypes}->[0],  'B';
is parse::Concept('A : B C {}')->{supertypes}->[1],  'C';
is parse::Concept('A : B C D{}')->{supertypes}->[2], 'D';

ok !parse::Concept('a :{}');
ok !parse::Concept('a : {}');
ok !parse::Concept('b :a {}');
ok parse::Concept('b : a {}');

ok parse::Concept('b : a {0}');
ok parse::Concept('b : a { 0 }')->{body}->[0] eq '0';
is parse::Concept('b : a {0}')->{body}->[0],   '0';
is parse::Concept('b : a {0 }')->{body}->[0],  '0';
is parse::Concept('b : a { 0 }')->{body}->[0], '0';
is parse::Concept('b : a { 0}')->{body}->[0],  '0';

is parse::Concept('b : a { 0 0}')->{body}->[0],  '0 0';
is parse::Concept('b : a { 0 0 }')->{body}->[0], '0 0';
is parse::Concept('b : a {0 0 }')->{body}->[0],  '0 0';
is parse::Concept("b : a {0 0 }")->{body}->[0],  "0 0";
is parse::Concept("b : a {0 0 0}")->{body}->[0], "0 0 0";
is parse::Concept("b : a {1 2 3}")->{body}->[0], "1 2 3";

is parse::Concept( "b : a {
0 0 0
}" )->{body}->[0], "0 0 0";

is parse::Concept( "b : a {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}" )->{body}->[0],
  "SFNode [in,out] metadata NULL [X3DMetadataObject]";

is parse::Concept( '
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

ok parse::Concept 'X3DNode{}';
parse::Concept 'X3DNode { }';

parse::Concept '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';
