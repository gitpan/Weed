package Weed::Values::Vector;
use Weed::Perl;

use Carp         ();
use Weed::Math   ();
use Scalar::Util ();

use overload
  '=' => 'copy',

  "bool" => 'length',
  'int'  => sub { $_[0]->new( [ map { CORE::int($_) } @{ $_[0] } ] ) },
  "0+"   => 'length',

  '==' => sub { "$_[0]" eq $_[1] },
  '!=' => sub { "$_[0]" ne $_[1] },
  '<=>' => sub { $_[2] ? $_[1] <=> $_[0]->length : $_[0]->length <=> $_[1] },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },
  'cmp' => sub { $_[2] ? $_[1] cmp $_[0]->length : $_[0]->length cmp $_[1] },

  '~' => sub { $_[0]->new( [ map { ~$_ } @{ $_[0] } ] ) },

  'neg' => 'negate',

  '+'  => 'add',
  '-'  => 'subtract',
  '*'  => 'multiply',
  '/'  => 'divide',
  '%'  => 'mod',
  '**' => 'pow',
  '.'  => 'dot',

  'abs' => sub { $_[0]->new( [ map { CORE::abs($_) } @{ $_[0] } ] ) },

  #"atan2", "cos", "sin", "exp", "log", "sqrt"

  #"<>"

  #'${}', '@{}', '%{}', '&{}', '*{}'.

  #"nomethod", "fallback",

  '""' => 'toString',
  ;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless [ @{ $self->getDefaultValue } ], $class;

	if ( @_ == 1 && ref $_[0] ) {
		if ( Scalar::Util::reftype( $_[0] ) eq 'ARRAY' ) {
			$this->setValue( @{ $_[0] } );
		}
		else {
			$this->setValue(@_);
		}
	}
	elsif (@_) {
		$this->setValue(@_);
	}

	return $this;
}

sub copy { $_[0]->new( $_[0]->getValue ) }

sub getValue { @{ $_[0] } }

sub setValue {
	my $this = shift;

	$this->[$_] = $_[$_] foreach 0 .. Math::min( $#{ $this->getDefaultValue }, $#_ );

	return;
}

use overload "&" => sub {
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
};

use overload "|" => sub {
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
};

use overload "^" => sub {
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
};

use overload "<<" => sub {
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
};

use overload ">>" => sub {
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
};

sub rotate {
	my $n = -$_[1] % $_[0]->size;

	if ($n) {
		my $vec = [ $_[0]->getValue ];
		splice @$vec, $_[0]->size - $n, $n, splice( @$vec, 0, $n );
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

sub squarednorm {
	my $squarednorm = 0;
	$squarednorm += $_ * $_ foreach @{ $_[0] };
	return $squarednorm;
}

sub normalize { $_[0] / $_[0]->length }

sub length { CORE::sqrt( $_[0]->squarednorm ) }

sub size { scalar @{ $_[0]->getDefaultValue } }

sub toString { join " ", $_[0]->getValue }

1;
__END__
