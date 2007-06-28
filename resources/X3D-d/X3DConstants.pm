package X3DConstants;
use strict;
use warnings;

#use Time::HiRes qw(time);

use base qw(Exporter);

our @EXPORT = qw(
  initializeOnly inputOnly outputOnly inputOutput
  TRUE FALSE NULL
);

use constant initializeOnly => 0;
use constant inputOnly      => 1;
use constant outputOnly     => 2;
use constant inputOutput    => 3;

use constant TRUE  => !0;
use constant FALSE => !TRUE;
use constant NULL  => 0;

use constant INITIALIZED_EVENT => 0;
use constant SHUTDOWN_EVENT    => 1;
use constant CONNECTION_ERROR  => 2;
use constant INITIALIZED_ERROR => 3;
use constant NOT_STARTED_STATE => 4;
use constant IN_PROGRESS_STATE => 5;
use constant COMPLETE_STATE    => 6;
use constant FAILED_STATE      => 7;

1;
__END__
use constant SFBool
use constant MFBool
use constant MFInt32
use constant SFInt32
use constant SFFloat
use constant MFFloat
use constant SFDouble
use constant MFDouble
use constant SFTime
use constant MFTime
use constant SFNode
use constant MFNode
use constant SFVec2f
use constant MFVec2f
use constant SFVec2d
use constant MFVec2d
use constant SFVec3f
use constant MFVec3f
use constant SFVec3d
use constant MFVec3d
use constant MFRotation
use constant SFRotation
use constant MFColor
use constant SFColor
use constant SFImage
use constant MFImage
use constant MFColorRGBA
use constant SFColorRGBA 
use constant SFString
use constant MFString

