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
	
	MFBool		[] fmfbool  	 []
	MFColor		[] fmfcolor 	 []
	MFColorRGBA	[] fmfcolorrgba []
	MFDouble		[] fmfdouble	 []
	MFFloat		[] fmffloat 	 []
	MFImage		[] fmfimage 	 []
	MFInt32		[] fmfint32 	 []
	MFNode		[] fmfnode  	 []
	MFRotation	[] fmfrotation  []
	MFString		[] fmfstring	 []
	MFTime		[] fmftime  	 []
	MFVec2d		[] fmfvec2d 	 []
	MFVec2f		[] fmfvec2f 	 []
	MFVec3d		[] fmfvec3d 	 []
	MFVec3f		[] fmfvec3f 	 []
	MFVec4d		[] fmfvec4d 	 []
	MFVec4f		[] fmfvec4f 	 []
	SFBool		[] fsfbool  	 FALSE
	SFColor		[] fsfcolor 	 0 0 0
	SFColorRGBA [] fsfcolorrgba 0 0 0 0
	SFDouble 	[] fsfdouble	 0
	SFFloat		[] fsffloat 	 0
	SFImage		[] fsfimage 	 0 0 0
	SFInt32		[] fsfint32 	 0
	SFNode		[] fsfnode  	 NULL
	SFRotation	[] fsfrotation  0 0 1 0
	SFString 	[] fsfstring	 ""
	SFTime		[] fsftime  	 0
	SFVec2d		[] fsfvec2d 	 0 0
	SFVec2f		[] fsfvec2f 	 0 0
	SFVec3d		[] fsfvec3d 	 0 0 0
	SFVec3f		[] fsfvec3f 	 0 0 0
	SFVec4d		[] fsfvec4d 	 0 0 0 0
	SFVec4f		[] fsfvec4f 	 0 0 0 0
	
	MFBool		[in] inmfbool  	 
	MFColor		[in] inmfcolor 	 
	MFColorRGBA	[in] inmfcolorrgba 
	MFDouble		[in] inmfdouble	 
	MFFloat		[in] inmffloat 	 
	MFImage		[in] inmfimage 	 
	MFInt32		[in] inmfint32 	 
	MFNode		[in] inmfnode  	 
	MFRotation	[in] inmfrotation  
	MFString		[in] inmfstring	 
	MFTime		[in] inmftime  	 
	MFVec2d		[in] inmfvec2d 	 
	MFVec2f		[in] inmfvec2f 	 
	MFVec3d		[in] inmfvec3d 	 
	MFVec3f		[in] inmfvec3f 	 
	MFVec4d		[in] inmfvec4d 	 
	MFVec4f		[in] inmfvec4f 	 
	SFBool		[in] insfbool  	 
	SFColor		[in] insfcolor 	 
	SFColorRGBA [in] insfcolorrgba 
	SFDouble 	[in] insfdouble	 
	SFFloat		[in] insffloat 	 
	SFImage		[in] insfimage 	 
	SFInt32		[in] insfint32 	 
	SFNode		[in] insfnode  	 
	SFRotation	[in] insfrotation  
	SFString 	[in] insfstring	 
	SFTime		[in] insftime  	 
	SFVec2d		[in] insfvec2d 	 
	SFVec2f		[in] insfvec2f 	 
	SFVec3d		[in] insfvec3d 	 
	SFVec3f		[in] insfvec3f 	 
	SFVec4d		[in] insfvec4d 	 
	SFVec4f		[in] insfvec4f 	 
	
	MFBool		[out] outmfbool	   
	MFColor		[out] outmfcolor	   
	MFColorRGBA	[out] outmfcolorrgba 
	MFDouble		[out] outmfdouble    
	MFFloat		[out] outmffloat	   
	MFImage		[out] outmfimage	   
	MFInt32		[out] outmfint32	   
	MFNode		[out] outmfnode	   
	MFRotation	[out] outmfrotation  
	MFString		[out] outmfstring    
	MFTime		[out] outmftime	   
	MFVec2d		[out] outmfvec2d	   
	MFVec2f		[out] outmfvec2f	   
	MFVec3d		[out] outmfvec3d	   
	MFVec3f		[out] outmfvec3f	   
	MFVec4d		[out] outmfvec4d	   
	MFVec4f		[out] outmfvec4f	   
	SFBool		[out] outsfbool	   
	SFColor		[out] outsfcolor	   
	SFColorRGBA [out] outsfcolorrgba 
	SFDouble 	[out] outsfdouble    
	SFFloat		[out] outsffloat	   
	SFImage		[out] outsfimage	   
	SFInt32		[out] outsfint32	   
	SFNode		[out] outsfnode	   
	SFRotation	[out] outsfrotation  
	SFString 	[out] outsfstring    
	SFTime		[out] outsftime	   
	SFVec2d		[out] outsfvec2d	   
	SFVec2f		[out] outsfvec2f	   
	SFVec3d		[out] outsfvec3d	   
	SFVec3f		[out] outsfvec3f	   
	SFVec4d		[out] outsfvec4d	   
	SFVec4f		[out] outsfvec4f	   
	
	MFBool		[in,out] want	      []
	MFString		[in,out] say	      []
	SFTime		[in,out] time	      0
	SFFloat		[in,out] parseFloat  0
	SFInt32		[in,out] parseInt    0
	
#	comment

	SFString 	[in,out] übelst      ""
	SFString 	[in,out] übe::lst    ""
#	SFString 	[in,out] 3übe::lst   ""
	SFVec2d  	[in,out] isa         1 2
	
	MFDouble		[in,out] doubles     [1.2, 3.4, 5.6]
	MFDouble		[in,out] doubles2    []

	SFNode		[in,out] sfnode2	   NULL
	MFNode		[in,out] mfnode2	   []	
	
	SFVec4d		[in,out] sfvec4d2	   0 0 0 0
	MFVec4d		[in,out] mfvec4d2	   []


#	MFNode		[in,out] mfnull	   [ NULL ]
}
';

1;
__END__
