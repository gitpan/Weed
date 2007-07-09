#!/usr/bin/perl -w
#package array_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok !X3DArray::isArray(new SFBool);
ok !X3DArray::isArray(new SFColor);
ok !X3DArray::isArray(new SFColorRGBA);
ok !X3DArray::isArray(new SFDouble);
ok !X3DArray::isArray(new SFFloat);
ok !X3DArray::isArray(new SFImage);
ok !X3DArray::isArray(new SFInt32);
ok !X3DArray::isArray(new SFNode);
ok !X3DArray::isArray(new SFRotation);
ok !X3DArray::isArray(new SFString);
ok !X3DArray::isArray(new SFTime);
ok !X3DArray::isArray(new SFVec2d);
ok !X3DArray::isArray(new SFVec2f);
ok !X3DArray::isArray(new SFVec3d);
ok !X3DArray::isArray(new SFVec3f);
ok !X3DArray::isArray(new SFVec4d);
ok !X3DArray::isArray(new SFVec4f);

ok X3DArray::isArray(new MFBool);
ok X3DArray::isArray(new MFColor);
ok X3DArray::isArray(new MFColorRGBA);
ok X3DArray::isArray(new MFDouble);
ok X3DArray::isArray(new MFFloat);
ok X3DArray::isArray(new MFImage);
ok X3DArray::isArray(new MFInt32);
ok X3DArray::isArray(new MFNode);
ok X3DArray::isArray(new MFRotation);
ok X3DArray::isArray(new MFString);
ok X3DArray::isArray(new MFTime);
ok X3DArray::isArray(new MFVec2d);
ok X3DArray::isArray(new MFVec2f);
ok X3DArray::isArray(new MFVec3d);
ok X3DArray::isArray(new MFVec3f);
ok X3DArray::isArray(new MFVec4d);
ok X3DArray::isArray(new MFVec4f);

1;
__END__
