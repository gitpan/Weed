package TestNodeCallback1;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use X3D 'TestNode : X3DNode {
  SFString  [in,out]      set_sfstring1 ""
  SFString  [in,out]      set_sfstring2 ""
  SFString  [in,out]      set_sfstring3 ""
  SFString  [in,out]      set_sfstring4 ""
  
  MFString  [in,out]      set_mfstring  []
}
';

sub initialize {
	print "initialize";
}

sub prepareEvents {
	print "prepareEvents";
}

sub set_sfstring1 {
	my ( $this, $value, $time ) = @_;
	print "set_sfstring1 @_",;
	$this->set_sfstring3 = "magic";
	$this->set_sfstring3 = "set 3 von 1";
}

sub set_sfstring2 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring2 @_",;
	set_sfstring1( $this, "DIRECT", $time );
	$this->set_sfstring3 = "set 3 von 2";
	$this->set_sfstring4 = "set 4 von 2";

	$this->set_sfstring1 = "IN1";
	$this->set_sfstring1 = "IN2";
	$this->set_sfstring1 = "IN3";
}

sub set_sfstring3 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring3 @_",;
	$this->set_sfstring4 = $value;
}

sub set_sfstring4 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring4 @_",;
}

sub set_mfstring {
	my ( $this, $value, $time ) = @_;

	print "set_mfstring @_",;
}

sub eventsProcessed {
	print "eventsProcessed";
}

sub shutdown {
	print "shutdown";
}

1;
__END__

  ONE initialize
  TWO initialize
  ONE prepareEvents
  TWO prepareEvents
  ONE set_sfstring2 two
  ONE set_sfstring1 DIRECT 1185290050.0810003
  ONE set_sfstring3 set 3 von 2 1185290050.0810003
  ONE set_sfstring1 IN3 1185290050.0810003
  TWO set_sfstring2 two
  TWO set_sfstring1 DIRECT 1185290050.0810003
  TWO set_sfstring3 set 3 von 2 1185290050.0810003
  TWO set_sfstring1 IN3 1185290050.0810003
  ONE eventsProcessed
  TWO eventsProcessed
