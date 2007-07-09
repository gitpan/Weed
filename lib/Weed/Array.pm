package Weed::Array;

use Weed 'X3DArray [ ]', 'isArray';
#Array reference

use Algorithm::Numerical::Shuffle;
use Weed::Tie::Length;

use overload
  'bool' => 'getLength',

  'int' => 'getLength',
  '0+'  => 'getLength',
  ;

sub new {
	my $this = shift->NEW;
	$this->setValue(@_);
	return $this;
}

sub getClone { $_[0]->new( scalar $_[0]->getValue ) }

sub getValue { [ @{ $_[0] } ] }

sub setValue {
	my $this = shift;

	if ( 0 == @_ ) {
		@$this = ();
	}
	elsif ( 1 == @_ )
	{
		my $value = shift;

		if ( isArray($value) ) {
			@$this = @$value;
		}
		else {
			@$this = ($value);
		}
	}
	else {
		@$this = @_;
	}
}

sub isArray {
	UNIVERSAL::isa( $_[0], __PACKAGE__ )
	  or
	  ( ref $_[0] && Scalar::Util::reftype( $_[0] ) eq 'ARRAY' )
}

use overload '<=>' => sub {
	my ( $a, $b, $r, $c ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	return $a <=> @$b unless isArray($a);    # [] <=> scalar
	return @$a <=> $b unless isArray($b);    # [] <=> scalar

	return $c if $c = $#$a <=> $#$b;

	for ( my $i = 0 ; $i < @$a ; ++$i ) {
		return $c if $c = $a->[$i] <=> $b->[$i];
	}

	return 0;
};

use overload 'cmp' => sub {
	my ( $a, $b, $r, $c ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	return $a cmp "$b" unless isArray($a);    # [] <=> scalar
	return "$a" cmp $b unless isArray($b);    # [] <=> scalar

	return $c if $c = $#$a <=> $#$b;

	for ( my $i = 0 ; $i < @$a ; ++$i ) {
		return $c if $c = $a->[$i] cmp $b->[$i];
	}

	return 0;
};

sub clear { @{ $_[0] } = () }

sub getLength { scalar @{ $_[0] } }
sub setLength { $#{ $_[0] } = $_[1] - 1; return }

sub sort { $_[0]->new( [ sort { $a <=> $b } @{ $_[0] } ] ) }

sub shuffle { $_[0]->new( scalar Algorithm::Numerical::Shuffle::shuffle( $_[0]->getValue ) ) }

sub toString {
	my $this = shift;

	my $string = '';

	if (@$this) {
		if ($#$this) {
			$string .= X3DGenerator->open_bracket;
			$string .= X3DGenerator->tidy_space;
			$string .= join X3DGenerator->comma . X3DGenerator->tidy_space, @$this;
			$string .= X3DGenerator->tidy_space;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= $this->[0];
		}
	}
	else {
		$string .= X3DGenerator->open_bracket;
		$string .= X3DGenerator->tidy_space;
		$string .= X3DGenerator->close_bracket;
	}

	return $string;
}

1;
__END__
sub length : lvalue {
	my $this = shift;

	if ( Want::want('RVALUE') ) {
		Want::rreturn scalar @$this;
	}

	if ( Want::want('ASSIGN') ) {
		$#$this = Math::max( 0, Want::want('ASSIGN') ) - 1;
		Want::lnoreturn;
	}

	my $length = @$this;
	$length;
}


# $index = binary_search( \@array, $word )
#   @array is a list of lowercase strings in alphabetical order.
#   $word is the target word that might be in the list.
#   binary_search() returns the array index such that $array[$index]
#   is $word.

sub binary_search {
    my ($array, $word) = @_;
    my ($low, $high) = ( 0, @$array - 1 );

	return unless defined $word;

    while ( $low <= $high ) {              # While the window is open
        my $try = int( ($low+$high)/2 );      # Try the middle element
        $low  = $try+1, next if $array->[$try] lt $word; # Raise bottom
        $high = $try-1, next if $array->[$try] gt $word; # Lower top

        return $try;     # We've found the word!
    }
    return;              # The word isn't there.
}

sub index {
	my ($array, $word) = @_;
	my $i = 0;
	for(; $i < @$array; ++$i) {
		return $i if $array->[$i] eq $word;
	}
	return -1;
}

#######################################################################

sub expand ($$$) {
	my $array  = shift;
	my $length = shift;
	my $fill   = @_ ? shift : '';
	for (my $i = @$array; $i < $length; ++$i) {
		$array->[$i] = $fill;
	}
	return $array;
}

#sub pad { expand @_ }

sub trim {
	my $array  = shift;
	my $length = shift;
	for (my $i = @$array; $i > $length; --$i) {
		delete $array->[$i];
	}
	return $array;
}

sub fit {
	my $array  = shift;
	my $length = shift;
	my $fill   = @_ ? shift : '';
	return @$array > $length ? array_trim($array, $length) : array_expand($array, $length, $fill);
}

#######################################################################

sub diff {
	my $array = shift;
	my $hash = { map { map { ("$_" => $_, $$_ => $_) } @$_ } @_ };

	my $result = [];
	foreach (@$array) {
		next if exists $hash->{"$_"} || exists $hash->{$$_};
		push @$result, $_;
	}

	return $result;
}

#######################################################################

sub columns {
	my $columns = shift;
	my @array = @_;
	my @new_array;
	while (@array) {
		push @new_array, [ splice @array, 0, $columns ];
	}
	return @new_array;
}

