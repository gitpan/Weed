package Weed::Tie::Value::Vector;
use Weed;

our $VERSION = '0.0081';

use base 'Tie::Array';

use Scalar::Util 'weaken';

use Weed::Parse::Double 'double';

sub getParent { $_[0]->{parent} }
sub getValue  { $_[0]->{value} }

sub TIEARRAY {
	my $this = bless {
		value  => $_[1]->getValue,
		parent => $_[1],
		fields => {},
	  },
	  $_[0];

	weaken $this->{parent};

	return $this;
}

sub STORE {
	return X3DMessage->IndexOutOfRange( 3, @_ )
	  unless defined $_[0]->{value}->set1Value( $_[1], double( \"$_[2]" ) || 0 );
}

sub FETCH {
	return X3DMessage->IndexOutOfRange( 3, @_ ) unless $_[0]->EXISTS( $_[1] );
	$_[0]->{value}->[ $_[1] ]
}

sub FETCHSIZE { $_[0]->{value}->elementCount }
sub EXISTS    { exists $_[0]->{value}->[ $_[1] ] }

sub STORESIZE { warn "STORESIZE" }
sub CLEAR     { $_[0]->{value}->clear }
sub DELETE    { warn "DELETE   " }

sub POP     { warn "POP 	" }
sub PUSH    { warn "PUSH	" }
sub SHIFT   { warn "SHIFT  " }
sub UNSHIFT { warn "UNSHIFT" }

sub SPLICE { warn "SPLICE" }

1;
__END__
