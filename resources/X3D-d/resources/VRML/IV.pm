package VRML::IV;
require 5.005;
use strict;
use Carp;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(vrml2iv);
}

use PML;

use constant header => "#Inventor V2.1 ascii\n";

my $fogType = {
	'LINEAR' 		=> 'HAZE',
	'EXPONENTIAL'	=> 'FOG',
};

my $justification = {
	'BEGIN' 	=> 'LEFT',
	'MIDDLE'	=> 'CENTER',
	'END'		=> 'RIGHT',
};

my $wrap = {
	'TRUE' 	=> 'REPEAT',
	'FALSE'	=> 'CLAMP',
};

my $vertexOrdering = {
	'TRUE' 	=> 'COUNTERCLOCKWISE',
	'FALSE'	=> 'CLOCKWISE',
};

my $shapeType = {
	'TRUE' 	=> 'SOLID',
	'FALSE'	=> 'UNKNOWN_SHAPE_TYPE',
};

my $faceType = {
	'TRUE' 	=> 'CONVEX',
	'FALSE'	=> 'UNKNOWN_FACE_TYPE',
};

my $normalBinding = {
	'TRUE' 	=> 'PER_VERTEX_INDEXED',
	'FALSE'	=> 'PER_FACE_INDEXED',
};

sub vrml2iv {
	my $vrml = shift;
	return header . Complexity() . Nodes($vrml);
}

sub Complexity {
	return "
Complexity {
	type OBJECT_SPACE
	value 1
	textureQuality 1
}
"
}


sub DirectionalLight {
	my $light = shift;
	return "
" . ($light->getName ? "DEF " . $light->getName . " " : "") . "
DirectionalLight {
	on					" . $light->on . "
	intensity			" . $light->intensity . "
	direction			" . $light->direction . "
	color				" . $light->color . "
}
"
}

sub SpotLight {
	my $light = shift;
	return "
" . ($light->getName ? "DEF " . $light->getName . " " : "") . "
SpotLight {
	on					" . $light->on . "
	intensity			" . $light->intensity . "
	location			" . $light->location . "
	direction			" . $light->direction . "
	color				" . $light->color . "
	cutOffAngle			" . $light->cutOffAngle . "
	dropOffRate			" . 1 / $light->radius . "
}
"
}

sub PointLight {
	my $light = shift;
	return "
" . ($light->getName ? "DEF " . $light->getName . " " : "") . "
PointLight {
	on					" . $light->on . "
	intensity			" . $light->intensity . "
	location			" . $light->location . "
	color				" . $light->color . "
}
"
}

sub Fog {
	my $fog = shift;
	return "
" . ($fog->getName ? "DEF " . $fog->getName . " " : "") . "
Environment {
    fogType 		" . ($fog->getName =~ /SQUARE/i ? "SMOKE" : $fogType->{$fog->fogType}) . "
    fogColor		" . $fog->color . "
	fogVisibility	" . $fog->visibilityRange . "
}
"
}

sub Viewpoint {
	my $viewpoint = shift;
	return "
" . ($viewpoint->getName ? "DEF " . $viewpoint->getName . " " : "") . "
PerspectiveCamera {
	viewportMapping ADJUST_CAMERA
	position		" . $viewpoint->position . "
	orientation 	" . $viewpoint->orientation . "
	aspectRatio 	1
	nearDistance	0
	farDistance 	0
	focalDistance	10
	heightAngle 	" . $viewpoint->fieldOfView . "
}
"
}

sub LOD {
	my $lod = shift;
	return "
" . ($lod->getName ? "DEF " . $lod->getName . " " : "") . "
LOD {
	center	" . $lod->center . "
	range	" . $lod->range . "
" . Nodes($lod->level) . "
}
"
}

sub Inline {
	my $inline = shift;
	my $file = new SFFile $inline->url->[0];

	
	return "
" . ($inline->getName ? "DEF " . $inline->getName . " " : "") . "
File {
	name \"" . $file . "\"
}
"
}

sub Nodes {
	my $vrml = shift;
	my @iv;

	foreach my $node (@{$vrml}) {
		my $type = $node->getType;
		print STDERR "$type\n";
		(push(@iv, Group($node)), 				next)	if $type eq "Group";
		(push(@iv, Transform($node)),			next)	if $type eq "Transform";
		(push(@iv, Switch($node)),				next)	if $type eq "Switch";
		(push(@iv, Shape($node)), 				next)	if $type eq "Shape";
		(push(@iv, DirectionalLight($node)),	next)	if $type eq "DirectionalLight";
		(push(@iv, SpotLight($node)),			next)	if $type eq "SpotLight";
		(push(@iv, PointLight($node)),			next)	if $type eq "PointLight";
		(push(@iv, Fog($node)),					next)	if $type eq "Fog";
		(push(@iv, Viewpoint($node)),			next)	if $type eq "Viewpoint";
		(push(@iv, LOD($node)),					next)	if $type eq "LOD";
		(push(@iv, Inline($node)),				next)	if $type eq "Inline";
		(push(@iv, Rotor($node)),				next)	if $type eq "Rotor";

		(push(@iv, CoKeyframeAnimation($node)), next)	if $type eq "CoKeyframeAnimation";
	}

	return join "\n", @iv;
}

sub Group {
	my $group = shift;
	my $iv    = Nodes($group->children);
	return $iv ? "
" . ($group->getName ? "DEF " . $group->getName . " " : "") . "
Group {
$iv
}
" : ""
}

sub Switch {
	my $switch = shift;
	return "
" . ($switch->getName ? "DEF " . $switch->getName . " " : "") . "
Switch {
	whichChild " . $switch->whichChoice  . "
" . Nodes($switch->choice) . "
}
"
}

sub Rotor {
	my $node = shift;

	return "
" . ($node->getName ? "DEF " . $node->getName . " " : "") . "
Rotor {
	rotation " . $node->rotation . "
	speed " . $node->speed . "
	on " . $node->on . "
}
"
}

sub Transform {
	my $transform = shift;

	if ($transform->children->length == 1) {
		return Rotor($transform->children->[0]) if $transform->children->[0]->getType eq "Rotor";
	}

    return "
Separator {
" . ($transform->getName ? "DEF " . $transform->getName . " " : "") . "
Transform {
	translation 		" . $transform->translation . "
	rotation			" . $transform->rotation . "
	scaleFactor			" . $transform->scale . "
	center				" . $transform->center . "
	scaleOrientation	" . $transform->scaleOrientation . "
}
" . Nodes($transform->children) . "
}
"
}

sub Shape {
	my $shape = shift;
	return "
" . ($shape->getName ? "DEF " . $shape->getName . " " : "") . "
Group {
" . Appearance($shape->appearance, $shape->geometry) . "
" . Geometry($shape->geometry) . "
}
"
}

sub Appearance {
	my $appearance = shift;
	my $geometry = shift;
	return "" unless $appearance;

	return "
" . ($appearance->getName ? "DEF " . $appearance->getName . " " : "") . "
Group {
" . Material($appearance->material) . "
" . Texture2Transform($appearance->textureTransform) . "
" . Texture($appearance->texture) . "
" . ($geometry && $geometry->getType eq "CoTextGraph" ? Font($geometry) : "") . "
}
"
}

sub Material {
	my $material = shift;
	return "" unless $material;
	return "
" . ($material->getName ? "DEF " . $material->getName . " " : "") . "
Material {
	ambientColor	" .
$material->ambientIntensity * $material->diffuseColor->r . " ".
$material->ambientIntensity * $material->diffuseColor->g . " ".
$material->ambientIntensity * $material->diffuseColor->b . "
	diffuseColor	" . $material->diffuseColor . "
	specularColor	" . $material->specularColor . "
	emissiveColor	" . $material->emissiveColor . "
	shininess		" . $material->shininess . "
	transparency	" . $material->transparency . "
}
MaterialBinding {
	value	OVERALL
}
"
}

sub Texture2Transform {
	my $textureTransform = shift;
	return "" unless $textureTransform;
	return "
" . ($textureTransform->getName ? "DEF " . $textureTransform->getName . " " : "") . "
Texture2Transform {
	translation " . $textureTransform->translation . "
	rotation	" . $textureTransform->rotation . "
	scaleFactor " . $textureTransform->scale . "
	center		" . $textureTransform->center . "
}
"
}

sub Texture {
	my $texture = shift;
	return "" unless $texture;
	
	return "
" . ($texture->getName ? "DEF " . $texture->getName . " " : "") . "
Texture2 {
	image	" . $texture->image . "
	wrapT	" . $wrap->{$texture->repeatS} . "
	wrapS	" . $wrap->{$texture->repeatT} . "
	model	MODULATE
}
" . ($texture->getName =~ /ENV/i ? "TextureCoordinateEnvironment {
}" : "") if $texture->getType eq "PixelTexture";


	return "" unless  $texture->url;
	my $image = new Image $texture->url->[0];
	return "
" . ($texture->getName ? "DEF " . $texture->getName . " " : "") . "
Texture2 {
	filename	\"" . $image->convert('sgi') . "\"
	wrapT		" . $wrap->{$texture->repeatS} . "
	wrapS		" . $wrap->{$texture->repeatT} . "
	model	MODULATE
}
" . ($texture->getName =~ /ENV/i ? "TextureCoordinateEnvironment {
}
" : "");
}

sub Font {
	my $geometry = shift;
	return "" unless $geometry && $geometry->getType eq "CoTextGraph";
	return "
Font {
    name	" . $geometry->fontName . "
    size	" . $geometry->fontStyle->size . "
}
"
}

sub Geometry {
	my $geometry = shift;
	return "" unless $geometry;
	print STDERR $geometry->getType, "\n";
	return (
		$geometry->getType =~ /Indexed/ 	? Indexed($geometry) :
		$geometry->getType eq "Box" 		? Box($geometry) :
		$geometry->getType eq "Sphere"		? Sphere($geometry) :
		$geometry->getType eq "Cylinder"	? Cylinder($geometry) :
		$geometry->getType eq "Cone"		? Cone($geometry) :
		$geometry->getType eq "CoTextGraph" ? CoTextGraph($geometry) : ""
	)
}

sub Indexed {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	" . $vertexOrdering->{$geometry->ccw} . "
	shapeType	" . $shapeType->{$geometry->solid} . "
	faceType	" . $faceType->{$geometry->convex} . "
	creaseAngle	" . $geometry->creaseAngle . "
}
" . ($geometry->normalIndex ? "
NormalBinding {
	value	" . $normalBinding->{$geometry->normalPerVertex} . "
}
Normal {
	vector	" . $geometry->normal->vector . "
}
" : "") . ($geometry->texCoordIndex ? "
TextureCoordinateBinding {
	value	PER_VERTEX_INDEXED
}
TextureCoordinate2 {
	point	" . $geometry->texCoord->point . "
}
" : "") . "
Coordinate3 {
    point	" . $geometry->coord->point . "
}
IndexedFaceSet {
    coordIndex			" . $geometry->coordIndex . "
" . ($geometry->normalIndex ? "
	normalIndex			" . $geometry->normalIndex . "
" : "") . ($geometry->texCoordIndex ? "
	textureCoordIndex	" . $geometry->texCoordIndex . "
" : "") . "
}
}
"

}

sub Box {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	COUNTERCLOCKWISE
	creaseAngle 	0.2865
}
Cube {
	width	" . $geometry->size->x . "
	height	" . $geometry->size->y . "
	depth	" . $geometry->size->z . "
}
}
"
}

sub Sphere {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	COUNTERCLOCKWISE
	creaseAngle 	0.2865
}
Sphere {
	radius	" . $geometry->radius . "
}
}
"
}

sub Cylinder {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	COUNTERCLOCKWISE
	creaseAngle 	0.2865
}
Cylinder {
	radius	" . $geometry->radius . "
	height	" . $geometry->height . "
}
}
"
}

sub Cone {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	COUNTERCLOCKWISE
	creaseAngle 	0.2865
}
Cone {
	bottomRadius	" . $geometry->bottomRadius . "
	height	" . $geometry->height . "
}
}
"
}

sub CoTextGraph {
	my $geometry = shift;
	return "
" . ($geometry->getName ? "DEF " . $geometry->getName . " " : "") . "
Group {
ShapeHints {
    vertexOrdering	COUNTERCLOCKWISE
	creaseAngle 	0.2865
}
ProfileCoordinate2 {
	point	" . $geometry->bevelCoords . "
}
LinearProfile {
	index	[ " . join("", map { "$_, " } (0..($geometry->bevelCoords->length-1))) . "]
}
Text3 {
	string			" . $geometry->string . "
	spacing			" . $geometry->fontStyle->spacing . "
	justification	" . $justification->{$geometry->fontStyle->justify->[0]} . "
	parts			ALL
}
}
"
}

############################################################
#
#         COSMO
#
############################################################

sub CoKeyframeAnimation {
	my $node = shift;
    return "
" . ($node->getName ? "DEF " . $node->getName . " " : "") . "
Separator {
" . Nodes($node->children) . "
}
"
}


__END__
