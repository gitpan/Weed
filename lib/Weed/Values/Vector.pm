package Weed::Values::Vector;
use Weed::Perl;

our $VERSION = '0.0083';

use Package::Alias X3DVector => __PACKAGE__;

use Carp       ();
use Math::Trig ();
use Weed::Math ();

use overload
  '=' => 'getClone',

  "bool" => 'length',
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
  'int' => sub { $_[0]->new( [ map { CORE::int($_) } @{ $_[0] } ] ) },

  'cos' => sub { $_[0]->new( [ map { CORE::cos($_) } @{ $_[0] } ] ) },
  'sin' => sub { $_[0]->new( [ map { CORE::sin($_) } @{ $_[0] } ] ) },

  'exp' => sub { $_[0]->new( [ map { CORE::exp($_) } @{ $_[0] } ] ) },
  'log' => sub { $_[0]->new( [ map { CORE::log($_) } @{ $_[0] } ] ) },

  'sqrt' => sub { $_[0]->new( [ map { CORE::sqrt($_) } @{ $_[0] } ] ) },

  #"atan2"

  #"<>"

  #'${}', '@{}', '%{}', '&{}', '*{}'.

  #"nomethod", "fallback",

  '""' => 'toString',
  ;

sub new {
	my $self  = $_[0];
	my $class = ref($self) || $self;
	return bless $_[1] || [ @{ $class->getDefaultValue } ], $class;
}

sub getClone { $_[0]->new( [ @{ $_[0] } ] ) }

sub getValue { [ @{ $_[0] } ] }

sub get1Value {
	return $_[0]->[ $_[1] ] if exists $_[0]->[ $_[1] ];
	return;
}

sub setValue {
	$_[0]->[$_] = $_[1]->[$_]
	  foreach 0 .. X3DMath::min( $_[0]->elementCount - 1, $#{ $_[1] } );
	return;
}

sub set1Value {
	return $_[0]->[ $_[1] ] = $_[2] if exists $_[0]->[ $_[1] ];
	return;
}

use overload "&" => sub {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] & $a->[$_] } ( 0 .. ( $b->elementCount - 1 ) ) ] )
		:
		  $b->new( [ map { $_ & $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] & $b->[$_] } ( 0 .. ( $a->elementCount - 1 ) ) ] )
		:
		  $a->new( [ map { $_ & $b } @$a ] )

	  )
};

use overload "|" => sub {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] | $a->[$_] } ( 0 .. ( $b->elementCount - 1 ) ) ] )
		:
		  $b->new( [ map { $_ | $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] | $b->[$_] } ( 0 .. ( $a->elementCount - 1 ) ) ] )
		:
		  $a->new( [ map { $_ | $b } @$a ] )

	  )
};

use overload "^" => sub {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] ^ $a->[$_] } ( 0 .. ( $b->elementCount - 1 ) ) ] )
		:
		  $b->new( [ map { $_ ^ $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] ^ $b->[$_] } ( 0 .. ( $a->elementCount - 1 ) ) ] )
		:
		  $a->new( [ map { $_ ^ $b } @$a ] )

	  )
};

use overload "<<" => sub {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] << $a->[$_] } ( 0 .. ( $b->elementCount - 1 ) ) ] )
		:
		  $b->new( [ map { $_ << $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] << $b->[$_] } ( 0 .. ( $a->elementCount - 1 ) ) ] )
		:
		  $a->new( [ map { $_ << $b } @$a ] )

	  )
};

use overload ">>" => sub {
	my ( $a, $b, $r ) = @_;
	$r ? (
		ref $b ?
		  $b->new( [ map { $b->[$_] >> $a->[$_] } ( 0 .. ( $b->elementCount - 1 ) ) ] )
		:
		  $b->new( [ map { $_ >> $a } @$b ] )
	  ) : (
		ref $b ?
		  $a->new( [ map { $a->[$_] >> $b->[$_] } ( 0 .. ( $a->elementCount - 1 ) ) ] )
		:
		  $a->new( [ map { $_ >> $b } @$a ] )

	  )
};

sub rotate {
	my $n = -$_[1] % $_[0]->elementCount;

	if ($n) {
		my $vec = $_[0]->getValue;
		splice @$vec, $_[0]->elementCount - $n, $n, splice( @$vec, 0, $n );
		return $_[0]->new($vec);
	}

	return $_[0]->getClone;
}

sub tan { $_[0]->new( [ map { Math::Trig::tan($_) } @{ $_[0] } ] ) }

#sub sig { $_[0]->new( [ map { X3DMath::sig($_) } @{ $_[0] } ] ) }
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

sub round { $_[0]->new( [ map { X3DMath::round( $_, $_[1] ) } @{ $_[0] } ] ) }

sub elementCount { scalar @{ $_[0]->getDefaultValue } }

sub clear { @{ $_[0] } = @{ $_[0]->getDefaultValue } }

sub toString { join " ", @{ $_[0]->getValue }[0 .. ( $_[0]->elementCount - 1 )] }

1;
__END__
