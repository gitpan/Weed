package Weed::Tie::Value::Vector;
use Weed;

our $VERSION = '0.0083';

use base 'Tie::Array';

use Scalar::Util 'weaken';

use Weed::Parse::Double 'double';

sub new {
	tie my (@array), $_[0], $_[1];
	return \@array;
}

#sub getParent { $_[0]->{parent} }
sub getValue { $_[0]->{parent}->getValue }

sub TIEARRAY {
	my $this = bless {
		parent => $_[1],
		fields => {},
	  },
	  $_[0];

	weaken $this->{parent};

	return $this;
}

sub STORE {
	$_[0]->getValue->[ $_[1] ] = double( \"$_[2]" ) || 0;
}

sub FETCH {
	return X3DMessage->IndexOutOfRange( 3, @_ ) unless $_[0]->EXISTS( $_[1] );
	$_[0]->getValue->[ $_[1] ]
}

sub FETCHSIZE { $_[0]->getValue->elementCount }
sub EXISTS    { exists $_[0]->getValue->[ $_[1] ] }

sub STORESIZE { warn "STORESIZE" }
sub CLEAR     { $_[0]->getValue->clear }
sub DELETE    { warn "DELETE   " }

sub POP     { warn "POP 	" }
sub PUSH    { warn "PUSH	" }
sub SHIFT   { warn "SHIFT  " }
sub UNSHIFT { warn "UNSHIFT" }

sub SPLICE { warn "SPLICE" }

1;
__END__
