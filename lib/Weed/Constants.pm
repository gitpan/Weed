package Weed::Constants;

use Weed 'X3DConstants { }';

use constant initializeOnly => 0;
use constant inputOnly      => 1;
use constant outputOnly     => 2;
use constant inputOutput    => 3;

sub NULL ()  { new SFNode(undef) }
sub FALSE () { new SFBool(NO) }
sub TRUE ()  { new SFBool(YES) }

1;
__END__

use enum qw(
  SFBool
  MFBool
  MFInt32
  SFInt32
  SFFloat
  MFFloat
  SFDouble
  MFDouble
  SFTime
  MFTime
  SFNode
  MFNode
  SFVec2f
  MFVec2f
  SFVec2d
  MFVec2d
  SFVec3f
  MFVec3f
  SFVec3d
  MFVec3d
  MFRotation
  SFRotation
  MFColor
  SFColor
  SFImage
  MFImage
  MFColorRGBA
  SFColorRGBA
  SFString
  MFString
);

use enum qw(
  INITIALIZED_EVENT
  SHUTDOWN_EVENT
  CONNECTION_ERROR
  INITIALIZED_ERROR
  NOT_STARTED_STATE
  IN_PROGRESS_STATE
  COMPLETE_STATE
  FAILED_STATE
);

use Benchmark;
my $v;
timethis( 8_000_000, sub { $v = MFBool } );
timethis( 8_000_000, sub { $v = MFBool } );
timethis( 8_000_000, sub { $v = TRUE } );
timethis( 8_000_000, sub { $v = TRUE } );

use Benchmark;
my $v;
timethis( 8_000_000, sub { $v = inputOnly } );
timethis( 8_000_000, sub { $v = inputOnly } );
timethis( 8_000_000, sub { $v = TRUE } );
timethis( 8_000_000, sub { $v = TRUE } );

timethis( 8_000_000, sub { $v = inputOnly } );
timethis( 8_000_000, sub { $v = inputOnly } );
timethis( 8_000_000, sub { $v = TRUE } );
timethis( 8_000_000, sub { $v = TRUE } );

