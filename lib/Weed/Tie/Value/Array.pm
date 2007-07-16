package Weed::Tie::Value::Array;
use Weed;

our $VERSION = '0.0081';

use base 'Tie::Array';

#use Contextual::Return;
use Scalar::Util 'weaken';

sub new {
	tie my (@array), $_[0], $_[1];
	return \@array;
}

sub getValue  { $_[0]->{parent}->getValue }
sub getParent { $_[0]->{parent} }

sub storeValue {
	#UNIVERSAL::isa( $_[1], 'X3DField' ) ? $_[1]->getValue : $_[1];
	$_[0]->{fieldType}->new( $_[1] )->getValue;
}

sub fetchValue {
	my ( $this, $value ) = @_;

	$this->{fieldType}->new(
		defined $value ? $value : $this->{fieldType}->getDefaultValue
	);
}

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
		parent    => $_[1],
		fieldType => $_[1]->getFieldType,
	  },
	  $_[0];

	weaken $this->{parent};

	return $this;
}

sub STORE { $_[0]->getValue->[ $_[1] ] = $_[0]->storeValue( $_[2] ) }

sub FETCH {
	return if $_[1] > $#{ $_[0]->getValue };

	$_[0]->fetchValue( $_[0]->getValue->[ $_[1] ] );
}

sub FETCHSIZE { scalar @{ $_[0]->getValue } }
sub EXISTS    { exists $_[0]->getValue->[ $_[1] ] }

sub STORESIZE { $#{ $_[0]->getValue } = $_[1] - 1 }
sub CLEAR { @{ $_[0]->getValue } = () }
sub DELETE { delete $_[0]->getValue->[ $_[1] ] }

sub POP     { $_[0]->removeValues( pop( @{ $_[0]->getValue } ) ) }
sub PUSH    { my $this = shift; my $o = $this->getValue; push( @$o, $this->insertValues(@_) ) }
sub SHIFT   { $_[0]->removeValues( shift( @{ $_[0]->getValue } ) ) }
sub UNSHIFT { my $this = shift; my $o = $this->getValue; unshift( @$o, $this->insertValues(@_) ) }

sub SPLICE {
	my $this = shift;
	my $sz   = $this->FETCHSIZE;
	my $off  = @_ ? shift : 0;
	$off += $sz if $off < 0;
	my $len = @_ ? shift : $sz - $off;
	return $this->removeValues( splice( @{ $this->getValue }, $off, $len, @_ ) );
}

sub UNTIE { $_[0]->CLEAR }

1;
__END__
	my $args = do{ package DB; ()=CORE::caller(0); \@DB::args };
	print $_ foreach @$args;
	
	my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(0);
	print "package:    ", $package    || "";
	print "subroutine: ", $subroutine || "";
	print "hasargs:    ", $hasargs    || "";
	print "wantarray:  ", $wantarray  || "";
	print "evaltext:   ", $evaltext   || "";
	print "is_require: ", $is_require || "";
	print "hints:      ", $hints      || "";
	print "bitmask:    ", $bitmask    || "";


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

