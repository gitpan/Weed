package Weed::Tie::ArrayFieldValue;
use Weed::Perl;

use base 'Tie::Array';

use Scalar::Util 'weaken';

sub getArray  { $_[0]->{array} }
sub getParent { $_[0]->{parent} }

sub storeValue {
	$_[0]->{fieldType}->new( $_[1] )->getValue;
}

sub fetchValue { $_[0]->{fieldType}->new( $_[1] ) }

sub insertValues {
	my $this = shift;
	return map { $this->storeValue($_) } @_;
}

sub removeValues {
	my $this = shift;
	return map { $this->fetchValue($_) } @_;
}

sub TIEARRAY {
	my $this = bless {
		array     => $_[1]->getValue->getValue,
		parent    => $_[1],
		fieldType => $_[1]->getFieldType,
	  },
	  $_[0];

	weaken $this->{parent};

	return $this;
}

sub FETCHSIZE { scalar @{ $_[0]->{array} } }
sub EXISTS    { exists $_[0]->{array}->[ $_[1] ] }

sub STORESIZE { $#{ $_[0]->{array} } = $_[1] - 1 }
sub CLEAR { @{ $_[0]->{array} } = () }
sub DELETE { delete $_[0]->{array}->[ $_[1] ] }

sub STORE { $_[0]->{array}->[ $_[1] ] = $_[0]->storeValue( $_[2] ) }
sub FETCH   { $_[0]->fetchValue( $_[0]->{array}->[ $_[1] ] ) }
sub POP     { $_[0]->removeValues( pop( @{ $_[0]->{array} } ) ) }
sub PUSH    { my $this = shift; my $o = $this->{array}; push( @$o, $this->insertValues(@_) ) }
sub SHIFT   { $_[0]->removeValues( shift( @{ $_[0]->{array} } ) ) }
sub UNSHIFT { my $this = shift; my $o = $this->{array}; unshift( @$o, $this->insertValues(@_) ) }

sub SPLICE {
	my $this = shift;
	my $sz   = $this->FETCHSIZE;
	my $off  = @_ ? shift: 0;
	$off += $sz if $off < 0;
	my $len = @_ ? shift: $sz - $off;
	return $this->removeValues( splice( @{ $this->{array} }, $off, $len, @_ ) );
}

sub UNTIE { $_[0]->CLEAR }

1
__END__

package Tie::StdArray;
use vars qw(@ISA);
@ISA = 'Tie::Array';

sub TIEARRAY  { bless [], $_[0] }
sub FETCHSIZE { scalar @{$_[0]} }
sub STORESIZE { $#{$_[0]} = $_[1]-1 }
sub STORE     { $_[0]->[$_[1]] = $_[2] }
sub FETCH     { $_[0]->[$_[1]] }
sub CLEAR     { @{$_[0]} = () }
sub POP       { pop(@{$_[0]}) }
sub PUSH      { my $o = shift; push(@$o,@_) }
sub SHIFT     { shift(@{$_[0]}) }
sub UNSHIFT   { my $o = shift; unshift(@$o,@_) }
sub EXISTS    { exists $_[0]->[$_[1]] }
sub DELETE    { delete $_[0]->[$_[1]] }

sub SPLICE
{
 my $ob  = shift;
 my $sz  = $ob->FETCHSIZE;
 my $off = @_ ? shift : 0;
 $off   += $sz if $off < 0;
 my $len = @_ ? shift : $sz-$off;
 return splice(@$ob,$off,$len,@_);
}

