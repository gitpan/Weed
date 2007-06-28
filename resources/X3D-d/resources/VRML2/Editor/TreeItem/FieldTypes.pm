package VRML2::Editor::TreeItem::FieldTypes;
use strict;

BEGIN {
	use Carp;

	# Field
	use VRML2::Editor::TreeItem::Field::SFBool;
	use VRML2::Editor::TreeItem::Field::SFColor;
	use VRML2::Editor::TreeItem::Field::SFFloat;
	use VRML2::Editor::TreeItem::Field::SFImage;
	use VRML2::Editor::TreeItem::Field::SFInt32;
	use VRML2::Editor::TreeItem::Field::SFNode;
	use VRML2::Editor::TreeItem::Field::SFTime;
	use VRML2::Editor::TreeItem::Field::SFRotation;
	use VRML2::Editor::TreeItem::Field::SFString;
	use VRML2::Editor::TreeItem::Field::SFVec2f;
	use VRML2::Editor::TreeItem::Field::SFVec3f;
	
	# MField
	use VRML2::Editor::TreeItem::Field::MFColor;
	use VRML2::Editor::TreeItem::Field::MFEnum;
	use VRML2::Editor::TreeItem::Field::MFFloat;
	use VRML2::Editor::TreeItem::Field::MFInt32;
	use VRML2::Editor::TreeItem::Field::MFNode;
	use VRML2::Editor::TreeItem::Field::MFRotation;
	use VRML2::Editor::TreeItem::Field::MFString;
	use VRML2::Editor::TreeItem::Field::MFTime;
	use VRML2::Editor::TreeItem::Field::MFVec2f;
	use VRML2::Editor::TreeItem::Field::MFVec3f;
	
	# CosmoWorlds
	use VRML2::Editor::TreeItem::Field::SFEnum;
	use VRML2::Editor::TreeItem::Field::MFEnum;
	
}

1;
__END__
