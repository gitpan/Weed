#!/usr/bin/perl -w
#package 00_concept
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::ConceptParser';
}

ok Weed::ConceptParser::parse('a{}');
is ref Weed::ConceptParser::parse('a{}'),   'HASH';
is ref Weed::ConceptParser::parse('a {}'),  'HASH';
is ref Weed::ConceptParser::parse('a { }'), 'HASH';
is ref Weed::ConceptParser::parse('a{ }'),  'HASH';

ok Weed::ConceptParser::parse('X3DNode {}')->{name},         'X3DNode';
ok Weed::ConceptParser::parse('X3DChildNode {}')->{name},    'X3DChildNode';
ok Weed::ConceptParser::parse('X3DCh::ildNode {}')->{name},  'X3DCh::ildNode';
ok Weed::ConceptParser::parse('_X3DCh::ildNode {}')->{name}, '_X3DCh::ildNode';

is Weed::ConceptParser::parse('X3DChildNode:X3DNode{}')->{name},   'X3DChildNode:X3DNode';
is Weed::ConceptParser::parse('X3DChildNode : X3DNode{}')->{name}, 'X3DChildNode';
is Weed::ConceptParser::parse('X3DChildNode : X3DNode{}')->{supertypes}->[0], 'X3DNode';
is Weed::ConceptParser::parse('A : B C {}')->{name}, 'A';
is Weed::ConceptParser::parse('A : B C {}')->{name}, 'A';
is Weed::ConceptParser::parse('A : B C {}')->{supertypes}->[0],  'B';
is Weed::ConceptParser::parse('A : B C {}')->{supertypes}->[1],  'C';
is Weed::ConceptParser::parse('A : B C D{}')->{supertypes}->[2], 'D';

ok !Weed::ConceptParser::parse('a :{}');
ok !Weed::ConceptParser::parse('a : {}');
ok !Weed::ConceptParser::parse('b :a {}');
ok Weed::ConceptParser::parse('b : a {}');

ok Weed::ConceptParser::parse('b : a {0}');
ok Weed::ConceptParser::parse('b : a { 0 }')->{body}->[0] eq '0';
is Weed::ConceptParser::parse('b : a {0}')->{body}->[0],   '0';
is Weed::ConceptParser::parse('b : a {0 }')->{body}->[0],  '0';
is Weed::ConceptParser::parse('b : a { 0 }')->{body}->[0], '0';
is Weed::ConceptParser::parse('b : a { 0}')->{body}->[0],  '0';

is Weed::ConceptParser::parse('b : a { 0 0}')->{body}->[0],  '0 0';
is Weed::ConceptParser::parse('b : a { 0 0 }')->{body}->[0], '0 0';
is Weed::ConceptParser::parse('b : a {0 0 }')->{body}->[0],  '0 0';
is Weed::ConceptParser::parse("b : a {0 0 }")->{body}->[0],  "0 0";
is Weed::ConceptParser::parse("b : a {0 0 0}")->{body}->[0], "0 0 0";
is Weed::ConceptParser::parse("b : a {1 2 3}")->{body}->[0], "1 2 3";

is Weed::ConceptParser::parse( "b : a {
0 0 0
}" )->{body}->[0], "0 0 0";

is Weed::ConceptParser::parse( "b : a {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}" )->{body}->[0],
  "SFNode [in,out] metadata NULL [X3DMetadataObject]";

is Weed::ConceptParser::parse( '
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

ok Weed::ConceptParser::parse 'X3DNode{}';
Weed::ConceptParser::parse 'X3DNode { }';

Weed::ConceptParser::parse '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';
