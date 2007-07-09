package TestNodeFields;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use Weed 'TestNode : X3DBaseNode {
	MFBool		[in,out] mfbool	   []
	MFColor		[in,out] mfcolor	   []
	MFColorRGBA	[in,out] mfcolorrgba []
	MFDouble		[in,out] mfdouble    []
	MFFloat		[in,out] mffloat	   []
	MFImage		[in,out] mfimage	   []
	MFInt32		[in,out] mfint32	   []
	MFNode		[in,out] mfnode	   []
	MFRotation	[in,out] mfrotation  []
	MFString		[in,out] mfstring    []
	MFTime		[in,out] mftime	   []
	MFVec2d		[in,out] mfvec2d	   []
	MFVec2f		[in,out] mfvec2f	   []
	MFVec3d		[in,out] mfvec3d	   []
	MFVec3f		[in,out] mfvec3f	   []
	MFVec4d		[in,out] mfvec4d	   []
	MFVec4f		[in,out] mfvec4f	   []
	SFBool		[in,out] sfbool	   FALSE
	SFColor		[in,out] sfcolor	   0 0 0
	SFColorRGBA [in,out] sfcolorrgba 0 0 0 0
	SFDouble 	[in,out] sfdouble    0
	SFFloat		[in,out] sffloat	   0
	SFImage		[in,out] sfimage	   0 0 0
	SFInt32		[in,out] sfint32	   0
	SFNode		[in,out] sfnode	   NULL
	SFRotation	[in,out] sfrotation  0 0 1 0
	SFString 	[in,out] sfstring    ""
	SFTime		[in,out] sftime	   0
	SFVec2d		[in,out] sfvec2d	   0 0
	SFVec2f		[in,out] sfvec2f	   0 0
	SFVec3d		[in,out] sfvec3d	   0 0 0
	SFVec3f		[in,out] sfvec3f	   0 0 0
	SFVec4d		[in,out] sfvec4d	   0 0 0 0
	SFVec4f		[in,out] sfvec4f	   0 0 0 0
	
	MFBool		[in,out] want	      []
	MFString		[in,out] say	      []
	SFTime		[in,out] time	      0
	SFFloat		[in,out] parseFloat  0
	SFInt32		[in,out] parseInt    0
	
	SFString 	[in,out] übelst      ""
	SFString 	[in,out] übe::lst    ""
	SFString 	[in,out] 3übe::lst   ""
	SFString 	[in,out] isa         ""
	
	MFDouble		[in,out] doubles     [1.2, 3.4, 5.6]
	MFDouble		[in,out] doubles2    []

	SFNode		[in,out] sfnode2	   NULL
	MFNode		[in,out] mfnode2	   []

#	MFNode		[in,out] mfnull	   [ NULL ]
}
';

1;
__END__
