package Weed::Values::Vector;

use strict;
use warnings;

our $VERSION = '1.7287';

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

#use base 'Math::Object';

=head1 NAME

Math::Vector - Abstract base class for vector classes

=head1 TREE

-+- L<Math::Vector>

=head1 SEE ALSO

L<PDL> for scientific and bulk numeric data processing and display

L<Math>

L<Math::Vectors>

L<Math::Color>, L<Math::ColorRGBA>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>

=head1 SYNOPSIS
	
	package Math::VecX;
	use base 'Math::Vector';
	use constant getDefaultValue => [ 0, 0 ];
	1;

=head1 DESCRIPTION

=head1 OPERATORS

=head2 Summary
	
	'&'		=>   Performs a componentwise and.
	'|'		=>   Performs a componentwise or.
	'^'		=>   Performs a componentwise xor.

	'<<'		=>   Left shift.
	'>>'		=>   Right shift.

	'!'		=>   Returns true if the length of this vector is 0
	
	'<'		=>   Numerical gt. Compares the length of this vector with a vector or a scalar value.
	'<='		=>   Numerical le. Compares the length of this vector with a vector or a scalar value.
	'>'		=>   Numerical lt. Compares the length of this vector with a vector or a scalar value.
	'>='		=>   Numerical ge. Compares the length of this vector with a vector or a scalar value.
	'<=>'		=>   Numerical cmp. Compares the length of this vector with a vector or a scalar value.
	'=='		=>   Numerical eq. Performs a componentwise equation.
	'!='		=>   Numerical ne. Performs a componentwise equation.
	
	'lt'		=>   Stringwise lt
	'le'		=>   Stringwise le
	'gt'		=>   Stringwise gt
	'ge'		=>   Stringwise ge
	'cmp'		=>   Stringwise cmp
	'eq'		=>   Stringwise eq
	'ne'		=>   Stringwise ne
	
	'int'		=>   Performs a componentwise int.
	'abs'		=>   Performs a componentwise abs.
	
	'""'		=>   Returns a string representation of the vector.

=cut

=head1 METHODS

=head2 new

	my $b = new Math::VecX; 					  
	my $c = new Math::VecX(1,2, @a);
	my @d = @$c; 

=cut

=head2 copy

Makes a copy
	
	$c = $v->copy;

=cut

=head2 getValue

Returns the value of the vector as array.

	@v = $v1->getValue;

=cut

=head2 setValue(x,y,z)

Sets the value of the vector

	$v1->setValue(1,2);

=cut

=head2 rotate(steps)

Performs a componentwise rotation.
A positiv number performs a clockwise rotation.
A negativ number performs a counter-clockwise rotation.

	$v = $vec->rotate(1);
	$v = $vec->rotate(2);

=cut

=head2 sig

Performs a componentwise sig.

	$v = new Math::VecX(-4, 5);
	$v = $VecX->sig;
	printf $v;         # -1 1

=cut

=head2 sum

Returns the sum of the components.

	$v = new Math::VecX(-8, 2);
	$s = $VecX->sum;
	printf $s;         # -6

=cut

=head2 normalize

	$v = $v1->normalize;

=cut
=head2 toString

Returns a string representation of the vector. This is used
to overload the '""' operator, so that vector may be
freely interpolated in strings.

	my $q = new Math::VecX(1,2);
	print $q->toString;                # "1 2"
	print "$q";                        # "1 2"

=cut
=head1 BUGS & SUGGESTIONS

If you run into a miscalculation please drop the author a note.

=head1 ARRANGED BY

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

This is free software; you can redistribute it and/or modify it
under the same terms as L<Perl|perl> itself.

=cut
