package VRML::Field::FieldTypes;
require 5.005;
use strict;
use Carp;

# This class should never need to be instantiated

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT_OK);
	@ISA = qw(Exporter);
	@EXPORT_OK = qw(
		@StandardFieldTypes
		@CosmoFieldTypes
		@ScriptFieldTypes
		@FieldTypes
		@VrmlScriptFieldTypes
		$vrmlScriptFieldType
		$fieldType
	);
}

use vars @EXPORT_OK;

@StandardFieldTypes   = qw(SFBool SFImage SFTime MFTime SFColor MFColor SFFloat MFFloat SFInt32 MFInt32 SFNode MFNode SFRotation MFRotation SFString MFString SFVec2f MFVec2f SFVec3f MFVec3f);
@CosmoFieldTypes      = qw(SFEnum MFEnum);
@ScriptFieldTypes     = qw(VrmlMatrix);
@FieldTypes           = (@StandardFieldTypes, @CosmoFieldTypes);
@VrmlScriptFieldTypes = (@StandardFieldTypes, @CosmoFieldTypes, @ScriptFieldTypes);
$vrmlScriptFieldType  = join '|', @VrmlScriptFieldTypes;
$fieldType            = join '|', @FieldTypes;
1;

package SFBool;
use vars qw(@ISA);
use VRML::Field::SFBool;
@ISA = qw(VRML::Field::SFBool);
1;
package SFImage;
use vars qw(@ISA);
use VRML::Field::SFImage;
@ISA = qw(VRML::Field::SFImage);
1;
package SFTime;
use vars qw(@ISA);
use VRML::Field::SFTime;
@ISA = qw(VRML::Field::SFTime);
1;
package MFTime;
use vars qw(@ISA);
use VRML::Field::MFTime;
@ISA = qw(VRML::Field::MFTime);
1;
package SFColor;
use vars qw(@ISA);
use VRML::Field::SFColor;
@ISA = qw(VRML::Field::SFColor);
1;
package MFColor;
use vars qw(@ISA);
use VRML::Field::MFColor;
@ISA = qw(VRML::Field::MFColor);
1;
package SFFloat;
use vars qw(@ISA);
use VRML::Field::SFFloat;
@ISA = qw(VRML::Field::SFFloat);
1;
package MFFloat;
use vars qw(@ISA);
use VRML::Field::MFFloat;
@ISA = qw(VRML::Field::MFFloat);
1;
package SFInt32;
use vars qw(@ISA);
use VRML::Field::SFInt32;
@ISA = qw(VRML::Field::SFInt32);
1;
package MFInt32;
use vars qw(@ISA);
use VRML::Field::MFInt32;
@ISA = qw(VRML::Field::MFInt32);
1;
package SFNode;
use vars qw(@ISA);
use VRML::Field::SFNode;
@ISA = qw(VRML::Field::SFNode);
1;
package MFNode;
use vars qw(@ISA);
use VRML::Field::MFNode;
@ISA = qw(VRML::Field::MFNode);
1;
package SFRotation;
use vars qw(@ISA);
use VRML::Field::SFRotation;
@ISA = qw(VRML::Field::SFRotation);
1;
package MFRotation;
use vars qw(@ISA);
use VRML::Field::MFRotation;
@ISA = qw(VRML::Field::MFRotation);
1;
package SFString;
use vars qw(@ISA);
use VRML::Field::SFString;
@ISA = qw(VRML::Field::SFString);
1;
package MFString;
use vars qw(@ISA);
use VRML::Field::MFString;
@ISA = qw(VRML::Field::MFString);
1;
package SFVec2f;
use vars qw(@ISA);
use VRML::Field::SFVec2f;
@ISA = qw(VRML::Field::SFVec2f);
1;
package MFVec2f;
use vars qw(@ISA);
use VRML::Field::MFVec2f;
@ISA = qw(VRML::Field::MFVec2f);
1;
package SFVec3f;
use vars qw(@ISA);
use VRML::Field::SFVec3f;
@ISA = qw(VRML::Field::SFVec3f);
1;
package MFVec3f;
use vars qw(@ISA);
use VRML::Field::MFVec3f;
@ISA = qw(VRML::Field::MFVec3f);
1;

# Cosmo
package SFEnum;
use vars qw(@ISA);
use VRML::Field::SFEnum;
@ISA = qw(VRML::Field::SFEnum);
1;
package MFEnum;
use vars qw(@ISA);
use VRML::Field::MFEnum;
@ISA = qw(VRML::Field::MFEnum);
1;

# VrmlScript
#package VrmlMatrix;
#use vars qw(@ISA);
#use VRML::Field::VrmlMatrix;
#@ISA = qw(VRML::Field::VrmlMatrix);
1;
__END__
