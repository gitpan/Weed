package Weed::Component::Grouping::BoundedObject;
use strict;
use warnings;

our $VERSION = '0.0011';

use Weed;

our $DESCRIPTION = '
X3DBoundedObject { 
  SFVec3f [] bboxCenter 0 0 0    (-\u221e,\u221e)
  SFVec3f [] bboxSize   -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121
}
';

1;
__END__
