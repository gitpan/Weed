package Weed::Values::Tie::Rotation;
use strict;
use warnings;

our $VERSION = '0.001';

use base 'Tie::Array';

use Scalar::Util 'weaken';

sub TIEARRAY {
	my $this = bless [$_[1]], $_[0];
	weaken $this->[0];
	return $this;
}

sub STORE {
	return $_[0]->[0]->setAngle( $_[2] ) if 3 == $_[1];
	return $_[0]->[0]->setX( $_[2] )     if 0 == $_[1];
	return $_[0]->[0]->setY( $_[2] )     if 1 == $_[1];
	return $_[0]->[0]->setZ( $_[2] )     if 2 == $_[1];
}

sub FETCH {
	return $_[0]->[0]->getAngle if 3 == $_[1];
	return $_[0]->[0]->getX     if 0 == $_[1];
	return $_[0]->[0]->getY     if 1 == $_[1];
	return $_[0]->[0]->getZ     if 2 == $_[1];
}

sub FETCHSIZE { $_[0]->[0]->elementCount }
sub EXISTS    { exists ${ $_[0]->[0] }->{rotation}->[ $_[1] ] }

sub STORESIZE { warn "STORESIZE" }
sub CLEAR     { $_[0]->[0]->clear }
sub DELETE    { warn "DELETE   " }

sub POP     { warn "POP 	" }
sub PUSH    { warn "PUSH	" }
sub SHIFT   { warn "SHIFT  " }
sub UNSHIFT { warn "UNSHIFT" }

sub SPLICE { warn "SPLICE" }

1;
__END__
