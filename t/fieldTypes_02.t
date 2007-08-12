#!/usr/bin/perl -w
#package fieldTypes_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

is new SFBool(),      'FALSE';
is new SFColor(),     '0 0 0';
is new SFColorRGBA(), '0 0 0 0';
is new SFDouble(),    '0';
is new SFFloat(),     '0';
is new SFImage(),     '0 0 0';
is new SFInt32(),     '0';
is new SFNode(),      'NULL';
is new SFRotation(),  '0 0 1 0';
is new SFString(),    '""';
is new SFTime(),      '0';
is new SFVec2d(),     '0 0';
is new SFVec2f(),     '0 0';
is new SFVec3d(),     '0 0 0';
is new SFVec3f(),     '0 0 0';
is new SFVec4d(),     '0 0 0 0';
is new SFVec4f(),     '0 0 0 0';

is new SFBool(YES), 'TRUE';
is new SFColor( 0.1, 0.2, 0.3 ), '0.1 0.2 0.3';
is new SFColorRGBA( 0.1, 0.2, 0.3, 0.4 ), '0.1 0.2 0.3 0.4';
is new SFDouble(X3DMath::PI), '3.14159265358979';
is new SFFloat(X3DMath::PI),  '3.1415927';
is new SFImage( 2, 2, 3, [ 0xffffff, 0, 0xffffff, 0 ] ), '2 2 3
0xffffff 0x0
0xffffff 0x0';
is new SFInt32(123.123), '123';
is new SFNode, 'NULL';
is new SFRotation( 0.267261241912424, 0.534522483824849, 0.801783725737273, 0.4 ), '0.267261241912424 0.534522483824849 0.801783725737273 0.4';
is new SFString("abcdefg"),      '"abcdefg"';
is new SFTime(123.123456789123), '123.123456789123';
is new SFVec2d( 1.23, 2.34 ), '1.23 2.34';
is new SFVec2f( 2.23, 3.34 ), '2.23 3.34';
is new SFVec3d( 3.4, 2.5, 6.7 ), '3.4 2.5 6.7';
is new SFVec3f( 13.4, 12.5, 16.7 ), '13.4 12.5 16.7';
is new SFVec4d( 3.4, 2.5, 6.7, 6.9 ), '3.4 2.5 6.7 6.9';
is new SFVec4f( 13.4, 12.5, 16.7, 7.8 ), '13.4 12.5 16.7 7.8';
is new SFDouble( new SFString(X3DMath::PI) ), '3.14159265358979';
is ref SFDouble->new( new SFString(X3DMath::PI) )->getValue, NO;

my $value;
is $value = new MFBool( new SFBool ), 'FALSE';
is scalar @$value, 1;
is $value = new MFColor( new SFColor ), '0 0 0';
is scalar @$value, 1;
is $value->[0], "0 0 0";
is $value = new MFColorRGBA( new SFColorRGBA ), '0 0 0 0';
is scalar @$value, 1;
is $value = new MFDouble( new SFDouble ), '0';
is scalar @$value, 1;
is $value = new MFFloat( new SFFloat ), '0';
is scalar @$value, 1;
is $value = new MFImage( new SFImage ), '0 0 0';
is scalar @$value, 1;
is $value = new MFInt32( new SFInt32 ), '0';
is scalar @$value, 1;
is $value = new MFNode( new SFNode ), '[ ]';
is scalar @$value, 1;
is $value = new MFRotation( new SFRotation ), '0 0 1 0';
is scalar @$value, 1;
is $value = new MFString( new SFString ), '""';
is scalar @$value, 1;
is $value = new MFTime( new SFTime ), '0';
is scalar @$value, 1;
is $value = new MFVec2d( new SFVec2d ), '0 0';
is scalar @$value, 1;
is $value = new MFVec2f( new SFVec2f ), '0 0';
is scalar @$value, 1;
is $value = new MFVec3d( new SFVec3d ), '0 0 0';
is scalar @$value, 1;
is $value = new MFVec3f( new SFVec3f ), '0 0 0';
is scalar @$value, 1;
is $value = new MFVec4d( new SFVec4d ), '0 0 0 0';
is scalar @$value, 1;
is $value = new MFVec4f( new SFVec4f ), '0 0 0 0';
is scalar @$value, 1;

is $value = new MFBool( new SFBool ), 'FALSE';
is scalar @$value, 1;
is $value = new MFColor( new SFColor( 0.1, 0.2, 0.3 ) ), '0.1 0.2 0.3';
is scalar @$value, 1;
is $value->[0], "0.1 0.2 0.3";
is $value = new MFColorRGBA( new SFColorRGBA( 0.1, 0.2, 0.3, 0.4 ) ), '0.1 0.2 0.3 0.4';
is scalar @$value, 1;
is $value->[0], "0.1 0.2 0.3 0.4";
is $value = new MFDouble( new SFDouble ), '0';
is scalar @$value, 1;
is $value = new MFFloat( new SFFloat ), '0';
is scalar @$value, 1;
is $value = new MFImage( new SFImage ), '0 0 0';
is scalar @$value, 1;
is $value = new MFInt32( new SFInt32 ), '0';
is scalar @$value, 1;
is $value = new MFNode( new SFNode ), '[ ]';
is scalar @$value, 1;
is $value = new MFRotation( new SFRotation ), '0 0 1 0';
is scalar @$value, 1;
is $value = new MFString( new SFString ), '""';
is scalar @$value, 1;
is $value = new MFTime( new SFTime ), '0';
is scalar @$value, 1;
is $value = new MFVec2d( new SFVec2d ), '0 0';
is scalar @$value, 1;
is $value = new MFVec2f( new SFVec2f ), '0 0';
is scalar @$value, 1;
is $value = new MFVec3d( new SFVec3d ), '0 0 0';
is scalar @$value, 1;
is $value = new MFVec3f( new SFVec3f ), '0 0 0';
is scalar @$value, 1;
is $value = new MFVec4d( new SFVec4d ), '0 0 0 0';
is scalar @$value, 1;
is $value = new MFVec4f( new SFVec4f ), '0 0 0 0';
is scalar @$value, 1;

X3DGenerator->setOutputStyle("COMPACT");

is new MFBool( new SFBool, new SFBool ), '[ FALSE, FALSE ]';
is new MFColor( new SFColor, new SFColor ), '[ 0 0 0, 0 0 0 ]';
is new MFColorRGBA( new SFColorRGBA, new SFColorRGBA ), '[ 0 0 0 0, 0 0 0 0 ]';
is new MFDouble( new SFDouble, new SFDouble ), '[ 0, 0 ]';
is new MFFloat( new SFFloat, new SFFloat ), '[ 0, 0 ]';
is new MFImage( new SFImage, new SFImage ), '[ 0 0 0, 0 0 0 ]';
is new MFInt32( new SFInt32, new SFInt32 ), '[ 0, 0 ]';
is new MFNode( new SFNode, new SFNode ), '[ ]';
is new MFRotation( new SFRotation, new SFRotation ), '[ 0 0 1 0, 0 0 1 0 ]';
is new MFString( new SFString, new SFString ), '[ "", "" ]';
is new MFTime( new SFTime, new SFTime ), '[ 0, 0 ]';
is new MFVec2d( new SFVec2d, new SFVec2d ), '[ 0 0, 0 0 ]';
is new MFVec2f( new SFVec2f, new SFVec2f ), '[ 0 0, 0 0 ]';
is new MFVec3d( new SFVec3d, new SFVec3d ), '[ 0 0 0, 0 0 0 ]';
is new MFVec3f( new SFVec3f, new SFVec3f ), '[ 0 0 0, 0 0 0 ]';
is new MFVec4d( new SFVec4d, new SFVec4d ), '[ 0 0 0 0, 0 0 0 0 ]';
is new MFVec4f( new SFVec4f, new SFVec4f ), '[ 0 0 0 0, 0 0 0 0 ]';

is new MFBool(),      '[ ]';
is new MFColor(),     '[ ]';
is new MFColorRGBA(), '[ ]';
is new MFDouble(),    '[ ]';
is new MFFloat(),     '[ ]';
is new MFImage(),     '[ ]';
is new MFInt32(),     '[ ]';
is new MFNode(),      '[ ]';
is new MFRotation(),  '[ ]';
is new MFString(),    '[ ]';
is new MFTime(),      '[ ]';
is new MFVec2d(),     '[ ]';
is new MFVec2f(),     '[ ]';
is new MFVec3d(),     '[ ]';
is new MFVec3f(),     '[ ]';
is new MFVec4d(),     '[ ]';
is new MFVec4f(),     '[ ]';

1;
__END__
