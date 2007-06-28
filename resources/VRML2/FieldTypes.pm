package VRML2::FieldTypes;
use strict;

BEGIN {
	use Carp;
}

# This class should never need to be instantiated

1;
# SFields

#package ;
#use vars qw(@ISA);
#use VRML2::Field::;
#@ISA = qw(VRML2::Field::);
#1;

package SFBool;
use vars qw(@ISA);
use VRML2::Field::SFBool;
@ISA = qw(VRML2::Field::SFBool);
1;

package SFColor;
use vars qw(@ISA);
use VRML2::Field::SFColor;
@ISA = qw(VRML2::Field::SFColor);
1;

package SFFloat;
use vars qw(@ISA);
use VRML2::Field::SFFloat;
@ISA = qw(VRML2::Field::SFFloat);
1;

package SFImage;
use vars qw(@ISA);
use VRML2::Field::SFImage;
@ISA = qw(VRML2::Field::SFImage);
1;

package SFInt32;
use vars qw(@ISA);
use VRML2::Field::SFInt32;
@ISA = qw(VRML2::Field::SFInt32);
1;

package SFNode;
use vars qw(@ISA);
use VRML2::Field::SFNode;
@ISA = qw(VRML2::Field::SFNode);
1;

package SFTime;
use vars qw(@ISA);
use VRML2::Field::SFTime;
@ISA = qw(VRML2::Field::SFTime);
1;

package SFRotation;
use vars qw(@ISA);
use VRML2::Field::SFRotation;
@ISA = qw(VRML2::Field::SFRotation);
1;

package SFString;
use vars qw(@ISA);
use VRML2::Field::SFString;
@ISA = qw(VRML2::Field::SFString);
1;

package SFVec2f;
use vars qw(@ISA);
use VRML2::Field::SFVec2f;
@ISA = qw(VRML2::Field::SFVec2f);
1;

package SFVec3f;
use vars qw(@ISA);
use VRML2::Field::SFVec3f;
@ISA = qw(VRML2::Field::SFVec3f);
1;



# MFields

package MFColor;
use vars qw(@ISA);
use VRML2::Field::MFColor;
@ISA = qw(VRML2::Field::MFColor);
1;

package MFEnum;
use vars qw(@ISA);
use VRML2::Field::MFEnum;
@ISA = qw(VRML2::Field::MFEnum);
1;

package MFFloat;
use vars qw(@ISA);
use VRML2::Field::MFFloat;
@ISA = qw(VRML2::Field::MFFloat);
1;

package MFInt32;
use vars qw(@ISA);
use VRML2::Field::MFInt32;
@ISA = qw(VRML2::Field::MFInt32);
1;

package MFNode;
use vars qw(@ISA);
use VRML2::Field::MFNode;
@ISA = qw(VRML2::Field::MFNode);
1;

package MFRotation;
use vars qw(@ISA);
use VRML2::Field::MFRotation;
@ISA = qw(VRML2::Field::MFRotation);
1;

package MFString;
use vars qw(@ISA);
use VRML2::Field::MFString;
@ISA = qw(VRML2::Field::MFString);
1;

package MFTime;
use vars qw(@ISA);
use VRML2::Field::MFTime;
@ISA = qw(VRML2::Field::MFTime);
1;

package MFVec2f;
use vars qw(@ISA);
use VRML2::Field::MFVec2f;
@ISA = qw(VRML2::Field::MFVec2f);
1;

package MFVec3f;
use vars qw(@ISA);
use VRML2::Field::MFVec3f;
@ISA = qw(VRML2::Field::MFVec3f);
1;




# CosmoWorlds
package SFEnum;
use vars qw(@ISA);
use VRML2::Field::SFEnum;
@ISA = qw(VRML2::Field::SFEnum);
1;

package MFEnum;
use vars qw(@ISA);
use VRML2::Field::MFEnum;
@ISA = qw(VRML2::Field::MFEnum);
1;





########## additional types ########## ########## 

package SFFile;
use vars qw(@ISA);
use VRML2::Field::Extra::SFFile;
@ISA = qw(VRML2::Field::Extra::SFFile);
1;

package SFDirectory;
use vars qw(@ISA);
use VRML2::Field::Extra::SFDirectory;
@ISA = qw(VRML2::Field::Extra::SFDirectory);
1;


__END__
