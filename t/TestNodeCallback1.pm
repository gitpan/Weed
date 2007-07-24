package TestNodeCallback1;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use Weed;
use X3D::Components::Core::Node;
	
use Weed 'TestNode : X3DNode {
  SFString  [in]      set_sfstring1
  SFString  [in]      set_sfstring2
  SFString  [in]      set_sfstring3
  SFString  [in]      set_sfstring4
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
	$this->set_sfstring3 = "set 3 von 1";
}

sub set_sfstring2 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring2 @_",;
	set_sfstring1( $this, "DIRECT", $time );
	$this->set_sfstring3 = "set 3 von 2";

	$this->set_sfstring1 = "IN1";
	$this->set_sfstring1 = "IN2";
	$this->set_sfstring1 = "IN3";
}

sub set_sfstring3 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring3 @_",;
}

sub set_sfstring4 {
	my ( $this, $value, $time ) = @_;

	print "set_sfstring4 @_",;
}

sub eventsProcessed {
	print "eventsProcessed";
}

sub shutdown {
	print "shutdown";
}

1;
__END__
