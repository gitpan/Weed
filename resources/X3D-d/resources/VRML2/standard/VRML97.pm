package VRML2::standard::VRML97;
use strict;

BEGIN {
	use Carp;

	use vars qw(@ISA @EXPORT);
	use Exporter;
	@ISA = qw(Exporter);
	@EXPORT = qw($VRML97);
}

use vars @EXPORT;
$VRML97 = join '', <DATA>;

1;
__DATA__
#VRML V2.0 utf8

# Anchor
PROTO Anchor [ 
  field        SFVec3f  bboxCenter      0 0 0
  field        SFVec3f  bboxSize        -1 -1 -1
  exposedField MFString url             []
  exposedField SFString description     "" 
  exposedField MFString parameter       []
  eventIn      MFNode   addChildren
  eventIn      MFNode   removeChildren
  exposedField MFNode   children        []
]
{
}

# Appearance
PROTO Appearance [ 
  exposedField SFNode material          NULL
  exposedField SFNode texture           NULL
  exposedField SFNode textureTransform  NULL
]
{
}

PROTO AudioClip [ 
  exposedField   SFString description      ""
  exposedField   SFBool   loop             FALSE
  exposedField   SFFloat  pitch            1.0
  exposedField   SFTime   startTime        0
  exposedField   SFTime   stopTime         0
  exposedField   MFString url              []
  eventOut       SFTime   duration_changed
  eventOut       SFBool   isActive
]
{
}

PROTO Background [ 
  eventIn      SFBool   set_bind
  exposedField MFFloat  groundAngle  []
  exposedField MFColor  groundColor  []
  exposedField MFString backUrl      []
  exposedField MFString bottomUrl    []
  exposedField MFString frontUrl     []
  exposedField MFString leftUrl      []
  exposedField MFString rightUrl     []
  exposedField MFString topUrl       []
  exposedField MFFloat  skyAngle     []
  exposedField MFColor  skyColor     0 0 0
  eventOut     SFBool   isBound
]
{
}

PROTO Billboard [ 
  field        SFVec3f  bboxCenter     0 0 0
  field        SFVec3f  bboxSize       -1 -1 -1
  exposedField SFVec3f  axisOfRotation 0 1 0
  eventIn      MFNode   addChildren
  eventIn      MFNode   removeChildren
  exposedField MFNode   children       []
]
{
}

PROTO Box [ 
  field    SFVec3f size  2 2 2
]
{
}

PROTO Collision [ 
  field        SFVec3f  bboxCenter      0 0 0
  field        SFVec3f  bboxSize        -1 -1 -1
  exposedField SFBool   collide         TRUE
  eventOut     SFTime   collideTime
  eventIn      MFNode   addChildren
  eventIn      MFNode   removeChildren
  field        SFNode   proxy           NULL
  exposedField MFNode   children        []
]
{
}

PROTO Color [ 
  exposedField MFColor color  []
]
{
}

PROTO ColorInterpolator [ 
  eventIn      SFFloat set_fraction
  exposedField MFFloat key           []
  exposedField MFColor keyValue      []
  eventOut     SFColor value_changed
]
{
}

PROTO Cone [ 
  field     SFFloat   bottomRadius 1
  field     SFFloat   height       2
  field     SFBool   side         TRUE
  field     SFBool    bottom       TRUE
]
{
}

PROTO Coordinate [ 
  exposedField MFVec3f point  []
]
{
}

PROTO CoordinateInterpolator [ 
  eventIn      SFFloat set_fraction
  exposedField MFFloat key           []
  exposedField MFVec3f keyValue     []
  eventOut     MFVec3f value_changed
]
{
}

PROTO Cylinder [ 
  field    SFFloat   radius  1
  field    SFFloat   height  2
  field    SFBool    side    TRUE
  field    SFBool    top     TRUE
  field    SFBool    bottom  TRUE
]
{
}

PROTO CylinderSensor [ 
  exposedField SFBool     autoOffset TRUE
  exposedField SFFloat    diskAngle  0.262
  exposedField SFBool    enabled    TRUE
  exposedField SFFloat    maxAngle   -1
  exposedField SFFloat    minAngle   0
  exposedField SFFloat    offset     0
  eventOut     SFBool     isActive
  eventOut     SFRotation rotation_changed
  eventOut     SFVec3f    trackPoint_changed
]
{
}

PROTO DirectionalLight [ 
  exposedField SFFloat ambientIntensity  0
  exposedField SFColor color             1 1 1
  exposedField SFVec3f direction         0 0 -1
  exposedField SFFloat intensity         1
  exposedField SFBool  on                TRUE 
]
{
}

PROTO ElevationGrid [ 
  eventIn      MFFloat  set_height
  exposedField SFNode   color             NULL
  exposedField SFNode  normal            NULL
  exposedField SFNode   texCoord          NULL
  field        MFFloat height            []
  field        SFBool   ccw               TRUE
  field        SFBool  colorPerVertex    TRUE
  field        SFFloat  creaseAngle       0
  field        SFBool  normalPerVertex   TRUE
  field        SFBool   solid             TRUE
  field        SFInt32  xDimension        0
  field        SFFloat  xSpacing          1.0
  field        SFInt32  zDimension        0
  field        SFFloat  zSpacing          1.0
]
{
}

PROTO Extrusion [ 
  eventIn MFVec2f    set_crossSection
  eventIn MFRotation set_orientation
  eventIn MFVec2f    set_scale
  eventIn MFVec3f    set_spine
  field   SFBool     beginCap         TRUE
  field   SFBool     ccw              TRUE
  field   SFBool     convex           TRUE
  field   SFFloat    creaseAngle      0
  field   MFVec2f    crossSection     [ 1 1, 1 -1, -1 -1,
                                       -1 1, 1  1 ]
  field   SFBool     endCap           TRUE
  field   MFRotation orientation      0 0 1 0
  field   MFVec2f    scale            1 1
  field   SFBool     solid            TRUE
  field   MFVec3f    spine            [ 0 0 0, 0 1 0 ]
]
{
}

PROTO Fog [ 
  exposedField SFColor  color            1 1 1
  exposedField SFString fogType          "LINEAR"
  exposedField SFFloat  visibilityRange  0
  eventIn      SFBool   set_bind
  eventOut     SFBool   isBound
]
{
}

PROTO FontStyle [ 
  field MFString family       "SERIF"
  field SFBool   horizontal   TRUE
  field MFString justify      "BEGIN"
  field SFString language     ""
  field SFBool   leftToRight  TRUE
  field SFFloat  size         1.0
  field SFFloat  spacing      1.0
  field SFString style        "PLAIN"
  field SFBool   topToBottom  TRUE
]
{
}

PROTO Group [ 
  field        SFVec3f bboxCenter    0 0 0
  field        SFVec3f bboxSize      -1 -1 -1
  eventIn      MFNode  addChildren
  eventIn      MFNode  removeChildren
  exposedField MFNode  children      []
]
{
}

PROTO ImageTexture [ 
  exposedField MFString url     []
  field        SFBool   repeatS TRUE
  field        SFBool   repeatT TRUE
]
{
}

PROTO IndexedFaceSet [ 
  field         MFInt32 coordIndex        []
  field         MFInt32 colorIndex        []
  eventIn       MFInt32 set_colorIndex
  eventIn       MFInt32 set_coordIndex
  field         SFBool  colorPerVertex    TRUE
  field         SFBool  normalPerVertex   TRUE
  field         MFInt32 normalIndex       []
  field         MFInt32 texCoordIndex     []
  field         SFBool  ccw               TRUE
  field         SFBool  solid             TRUE
  field         SFBool  convex            TRUE
  field         SFFloat creaseAngle       0
  eventIn       MFInt32 set_normalIndex
  eventIn       MFInt32 set_texCoordIndex
  exposedField  SFNode  coord             NULL
  exposedField  SFNode  color             NULL
  exposedField  SFNode  normal            NULL
  exposedField  SFNode  texCoord          NULL
]
{
}

PROTO IndexedLineSet [ 
  field         MFInt32 coordIndex        []
  field         MFInt32 colorIndex        []
  eventIn       MFInt32 set_colorIndex
  eventIn       MFInt32 set_coordIndex
  field         SFBool  colorPerVertex    TRUE
  exposedField  SFNode  coord             NULL
  exposedField  SFNode  color             NULL
]
{
}

PROTO Inline [ 
  exposedField MFString url        []
  field        SFVec3f  bboxCenter 0 0 0
  field        SFVec3f  bboxSize   -1 -1 -1
]
{
}

PROTO LOD [ 
  field        SFVec3f center   0 0 0
  field        MFFloat range    []
  exposedField MFNode  level    [] 
]
{
}

PROTO Material [ 
  exposedField SFFloat ambientIntensity  0.2
  exposedField SFColor diffuseColor      0.8 0.8 0.8
  exposedField SFColor specularColor     0 0 0
  exposedField SFColor emissiveColor     0 0 0
  exposedField SFFloat shininess         0.2
  exposedField SFFloat transparency      0
]
{
}

PROTO MovieTexture [ 
  exposedField MFString url              []
  exposedField SFBool   loop             FALSE
  exposedField SFFloat  speed            1.0
  exposedField SFTime   startTime        0
  exposedField SFTime   stopTime         0
  field        SFBool   repeatS          TRUE
  field        SFBool   repeatT          TRUE
  eventOut     SFTime   duration_changed
  eventOut     SFBool   isActive
]
{
}

PROTO NavigationInfo [ 
  eventIn      SFBool   set_bind
  exposedField MFFloat avatarSize      [0.25, 1.6, 0.75]
  exposedField SFBool   headlight       TRUE
  exposedField SFFloat  speed           1.0
  exposedField MFString type            ["WALK", "ANY"]
  exposedField SFFloat  visibilityLimit 0.0
  eventOut     SFBool   isBound
]
{
}

PROTO Normal [ 
  exposedField MFVec3f vector  []
]
{
}

PROTO NormalInterpolator [ 
  eventIn      SFFloat set_fraction
  exposedField MFFloat key           []
  exposedField MFVec3f keyValue     []
  eventOut     MFVec3f value_changed
]
{
}

PROTO OrientationInterpolator [ 
  eventIn      SFFloat    set_fraction
  exposedField MFFloat    key           []
  exposedField MFRotation keyValue      []
  eventOut     SFRotation value_changed
]
{
}

PROTO PixelTexture [ 
  exposedField SFImage  image      0 0 0
  field        SFBool   repeatS    TRUE
  field        SFBool   repeatT    TRUE
]
{
}

PROTO PlaneSensor [ 
  exposedField SFBool  autoOffset          TRUE
  exposedField SFBool  enabled             TRUE
  exposedField SFVec2f maxPosition         -1 -1
  exposedField SFVec2f minPosition         0 0
  exposedField SFVec3f offset              0 0 0
  eventOut     SFBool  isActive
  eventOut     SFVec3f trackPoint_changed
  eventOut     SFVec3f translation_changed
]
{
}

PROTO PointLight [ 
  exposedField SFFloat ambientIntensity  0
  exposedField SFVec3f attenuation       1 0 0
  exposedField SFColor color             1 1 1
  exposedField SFFloat intensity         1
  exposedField SFVec3f location          0 0 0
  exposedField SFBool  on                TRUE 
  exposedField SFFloat radius            100
]
{
}

PROTO PointSet [ 
  exposedField  SFNode  coord      NULL
  exposedField  SFNode  color      NULL
]
{
}

PROTO PositionInterpolator [ 
  eventIn      SFFloat set_fraction
  exposedField MFFloat key           []
  exposedField MFVec3f keyValue      []
  eventOut     SFVec3f value_changed
]
{
}

PROTO ProximitySensor [ 
  exposedField SFVec3f    center      0 0 0
  exposedField SFVec3f    size        0 0 0
  exposedField SFBool     enabled     TRUE
  eventOut     SFBool     isActive
  eventOut     SFVec3f    position_changed
  eventOut     SFRotation orientation_changed
  eventOut     SFTime     enterTime
  eventOut     SFTime     exitTime
]
{
}

PROTO ScalarInterpolator [ 
  eventIn      SFFloat set_fraction
  exposedField MFFloat key           []
  exposedField MFFloat keyValue      []
  eventOut     SFFloat value_changed
]
{
}

PROTO Script [ 
  exposedField MFString url           [] 
  field        SFBool   directOutput  FALSE
  field        SFBool   mustEvaluate  FALSE
]
{
}

PROTO Shape [
  exposedField SFNode appearance NULL
  exposedField SFNode geometry   NULL
]
{
}

PROTO Sound [ 
  exposedField SFVec3f  direction     0 0 1
  exposedField SFFloat intensity     1
  exposedField SFVec3f  location      0 0 0
  exposedField SFFloat  maxBack       10
  exposedField SFFloat  maxFront      10
  exposedField SFFloat  minBack       1
  exposedField SFFloat  minFront      1
  exposedField SFFloat priority      0
  exposedField SFNode   source        NULL
  field        SFBool   spatialize    TRUE
]
{
}

PROTO Sphere [ 
  field SFFloat radius  1
]
{
}

PROTO SphereSensor [ 
  exposedField SFBool     enabled           TRUE
  eventOut     SFBool     isActive
  exposedField SFRotation offset            0 1 0 0
  exposedField SFBool     autoOffset        TRUE
  eventOut     SFVec3f    trackPoint_changed
  eventOut     SFRotation rotation_changed
]
{
}

PROTO SpotLight [ 
  exposedField SFFloat ambientIntensity  0
  exposedField SFVec3f attenuation       1 0 0
  exposedField SFFloat beamWidth         1.570796
  exposedField SFColor color             1 1 1
  exposedField SFFloat cutOffAngle       0.785398
  exposedField SFVec3f direction         0 0 -1
  exposedField SFFloat intensity         1
  exposedField SFVec3f location          0 0 0
  exposedField SFBool  on                TRUE
  exposedField SFFloat radius            100
]
{
}

PROTO Switch [ 
  exposedField    SFInt32 whichChoice -1
  exposedField    MFNode  choice      []
]
{
}

PROTO Text [ 
  exposedField  MFString string    []
  exposedField  SFNode  fontStyle NULL
  exposedField  MFFloat  length    []
  exposedField  SFFloat  maxExtent 0.0
]
{
}

PROTO TextureCoordinate [ 
  exposedField MFVec2f point  []
]
{
}

PROTO TextureTransform [ 
  exposedField SFVec2f translation 0 0
  exposedField SFFloat rotation    0
  exposedField SFVec2f scale       1 1
  exposedField SFVec2f center      0 0
]
{
}

PROTO TimeSensor [ 
  exposedField SFTime   cycleInterval 1
  exposedField SFBool   enabled       TRUE
  exposedField SFBool   loop          FALSE
  exposedField SFTime   startTime     0
  exposedField SFTime   stopTime      0
  eventOut     SFTime   cycleTime
  eventOut     SFFloat  fraction_changed
  eventOut     SFBool   isActive
  eventOut     SFTime   time
]
{
}

PROTO TouchSensor [ 
  exposedField SFBool enabled TRUE
  eventOut     SFBool  isActive
  eventOut     SFBool  isOver
  eventOut     SFVec3f hitPoint_changed
  eventOut     SFVec3f hitNormal_changed
  eventOut     SFVec2f hitTexCoord_changed
  eventOut     SFTime  touchTime
]
{
}

PROTO Transform [ 
  exposedField SFVec3f     translation      0 0 0
  exposedField SFRotation  rotation         0 0 1 0
  exposedField SFVec3f     scale            1 1 1
  field        SFVec3f     bboxCenter       0 0 0
  field        SFVec3f     bboxSize         -1 -1 -1
  exposedField SFVec3f     center           0 0 0
  exposedField SFRotation  scaleOrientation 0 0 1 0
  eventIn      MFNode      addChildren
  eventIn      MFNode      removeChildren
  exposedField MFNode      children         []
]
{
}

PROTO Viewpoint [ 
  eventIn      SFBool     set_bind
  eventOut     SFBool     isBound
  exposedField SFVec3f    position       0 0 10
  exposedField SFRotation orientation    0 0 1 0
  exposedField SFFloat    fieldOfView    0.785398
  exposedField SFBool     jump           TRUE
  field        SFString  description    ""
  eventOut     SFTime     bindTime
]
{
}

PROTO VisibilitySensor [ 
  exposedField SFVec3f center   0 0 0
  exposedField SFVec3f size     0 0 0
  exposedField SFBool  enabled  TRUE
  eventOut     SFBool  isActive
  eventOut     SFTime  enterTime
  eventOut     SFTime  exitTime
]
{
}

PROTO WorldInfo [ 
  field MFString info  []
  field SFString title ""
]
{
}
