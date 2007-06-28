#!/usr/bin/perl -w
#package 05_field_types
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

is new SFBool,      'FALSE';
is new SFColor,     '0 0 0';
is new SFColorRGBA, '0 0 0 0';
is new SFDouble,    '0';
is new SFFloat,     '0';
is new SFImage,     '0 0 0';
is new SFInt32,     '0';
is new SFNode,      'NULL';
is new SFRotation,  '0 0 1 0';
is new SFString,    '';
is new SFTime,      '0';
is new SFVec2d,     '0 0';
is new SFVec2f,     '0 0';
is new SFVec3d,     '0 0 0';
is new SFVec3f,     '0 0 0';

is new MFBool,      '[ ]';
is new MFColor,     '[ ]';
is new MFColorRGBA, '[ ]';
is new MFDouble,    '[ ]';
is new MFFloat,     '[ ]';
is new MFImage,     '[ ]';
is new MFInt32,     '[ ]';
is new MFNode,      '[ ]';
is new MFRotation,  '[ ]';
is new MFString,    '[ ]';
is new MFTime,      '[ ]';
is new MFVec2d,     '[ ]';
is new MFVec2f,     '[ ]';
is new MFVec3d,     '[ ]';
is new MFVec3f,     '[ ]';

__END__
