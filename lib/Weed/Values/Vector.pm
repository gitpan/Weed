package Weed::Values::Vector;

use strict;
use warnings;

our $VERSION = '1.7292';

use Carp       ();
use Weed::Math ();
use Scalar::Util qw(reftype);

use overload
  '=' => 'copy',

  "bool" => 'length',
  'int'  => sub { $_[0]->new( [ map { CORE::int($_) } @{ $_[0] } ] ) },
  "0+"   => 'length',

  '~' => sub { $_[0]->new( [ map { ~$_ } @{ $_[0] } ] ) },

  "&" => \&_and,
  "|" => \&_or,
  "^" => \&_xor,

  '==' => sub { "$_[0]" eq $_[1] },
  '!=' => sub { "$_[0]" ne $_[1] },
  '<=>' => sub { $_[2] ? $_[1] <=> $_[0]->length : $_[0]->length <=> $_[1] },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },
  'cmp' => sub { $_[2] ? $_[1] cmp $_[0]->length : $_[0]->length cmp $_[1] },

  'neg' => 'negate',

  '<<' => \&_lshift,
  '>>' => \&_rshift,

  'abs' => sub { $_[0]->new( [ map { CORE::abs($_) } @{ $_[0] } ] ) },

  '""' => 'toString',
  ;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless [ @{ $self->getDefaultValue } ], $class;

	if ( 0 == @_ ) {
		# No arguments, default to standard
		return $this;
	}
	elsif ( 1 == @_ && ref $_[0] && Scalar::Util::reftype( $_[0] ) eq 'ARRAY' ) {
		$this->setValue( @{ $_[0] } );
		return $this;
	}
	elsif ( @_ > 0 ) {    # x,y
		$this->setValue(@_);
		return $this;
	}
	else {
		warn("Don't understand arguments passed to new()");
	}

	return;
}

sub copy { $_[0]->new( $_[0]->getValue ) }

sub getValue { @{ $_[0] } }

sub setValue {
	my $this = shift;

	$this->[$_] = $_[$_] foreach 0 .. Math::min( $#{ $this->getDefaultValue }, $#_ );

	return;
}

sub _lshift {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] << $a->[$_] } ( 0 .. $#{ $b->getDefaultValue } ) ] )
		:
		  $b->new( [ map { $_ << $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] << $b->[$_] } ( 0 .. $#{ $a->getDefaultValue } ) ] )
		:
		  $a->new( [ map { $_ << $b } @$a ] )

	  )
}

sub _rshift {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] >> $a->[$_] } ( 0 .. $#{ $b->getDefaultValue } ) ] )
		:
		  $b->new( [ map { $_ >> $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] >> $b->[$_] } ( 0 .. $#{ $a->getDefaultValue } ) ] )
		:
		  $a->new( [ map { $_ >> $b } @$a ] )

	  )
}

sub _and {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] & $a->[$_] } ( 0 .. $#{ $b->getDefaultValue } ) ] )
		:
		  $b->new( [ map { $_ & $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] & $b->[$_] } ( 0 .. $#{ $a->getDefaultValue } ) ] )
		:
		  $a->new( [ map { $_ & $b } @$a ] )

	  )
}

sub _or {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] | $a->[$_] } ( 0 .. $#{ $b->getDefaultValue } ) ] )
		:
		  $b->new( [ map { $_ | $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] | $b->[$_] } ( 0 .. $#{ $a->getDefaultValue } ) ] )
		:
		  $a->new( [ map { $_ | $b } @$a ] )

	  )
}

sub _xor {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] ^ $a->[$_] } ( 0 .. $#{ $b->getDefaultValue } ) ] )
		:
		  $b->new( [ map { $_ ^ $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] ^ $b->[$_] } ( 0 .. $#{ $a->getDefaultValue } ) ] )
		:
		  $a->new( [ map { $_ ^ $b } @$a ] )

	  )
}

sub rotate {
	my $n = -$_[1] % @{ $_[0]->getDefaultValue };

	if ($n) {
		my $vec = [ $_[0]->getValue ];
		splice @$vec, @{ $_[0]->getDefaultValue } - $n, $n, splice( @$vec, 0, $n );
		return $_[0]->new($vec);
	}

	return $_[0]->copy;
}

#sub sig { $_[0]->new( [ map { Math::sig($_) } @{ $_[0] } ] ) }
sub sig { $_[0]->new( [ map { $_ ? ( $_ < 0 ? -1 : 1 ) : 0 } @{ $_[0] } ] ) }

sub sum {
	my $sum = 0;
	$sum += $_ foreach @{ $_[0] };
	return $sum;
}

sub normalize { $_[0] / $_[0]->length }

sub toString {
	return join " ", $_[0]->getValue;
}

1;
__END__
