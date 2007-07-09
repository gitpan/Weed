package Weed::Tie::VectorValue;
use Weed::Perl;

use base 'Weed::Tie::ArrayFieldValue';

use Scalar::Util 'weaken';

sub storeValue {
	SFDouble->new( $_[1] )->getValue;
}

sub fetchValue { $_[1] }

sub TIEARRAY {
	my $this = bless {
		array  => $_[1]->getValue->getValue,
		parent => $_[1],
	  },
	  $_[0];

	weaken $this->{parent};

	return $this;
}

sub STORE { shift->SUPER::STORE(@_) }

sub STORESIZE { warn "STORESIZE" }
sub CLEAR     { warn "CLEAR	 " }
sub DELETE    { warn "DELETE   " }

sub POP     { warn "POP 	" }
sub PUSH    { warn "PUSH	" }
sub SHIFT   { warn "SHIFT  " }
sub UNSHIFT { warn "UNSHIFT" }

sub SPLICE { warn "SPLICE" }
 
1
__END__
