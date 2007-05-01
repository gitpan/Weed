package Weed::Components::Grouping::GroupingNode;
use strict;
use warnings;

use Weed '
X3DGroupingNode : X3DChildNode, X3DBoundedObject { 
  MFNode  [in]     addChildren
  MFNode  [in]     removeChildren
  MFNode  [in,out] children       []       [X3DChildNode]
  SFNode  [in,out] metadata       NULL     [X3DMetadataObject]
  SFVec3f []       bboxCenter     0 0 0    (-\u221e,\u221e)
  SFVec3f []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121
}
';

1;
__END__
