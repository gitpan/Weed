package Weed::Array;

use Weed 'X3DArray [ ]';

use Algorithm::Numerical::Shuffle;

use overload
  'bool' => 'length',
  ;

sub new {
	my $this = shift->NEW;
	$this->setValue(@_);
	return $this;
}

sub copy { $_[0]->new( $_[0]->getValue ) }

sub getValue { @{ $_[0] } }

sub setValue {
	my $this = shift;
	@$this = @_;
	return;
}

use overload '<=>' => sub {
	my ( $a, $b, $r, $c ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	return @$a <=> $b unless ref $b;    # [] <=> scalar

	return $c if $c = $#$a <=> $#$b;

	for ( my $i = 0 ; $i < @$a ; ++$i ) {
		return $c if $c = $a->[$i] <=> $b->[$i];
	}

	return 0;
};

use overload 'cmp' => sub {
	my ( $a, $b, $r, $c ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	return $c if $c = $#$a <=> $#$b;

	for ( my $i = 0 ; $i < @$a ; ++$i ) {
		return $c if $c = $a->[$i] cmp $b->[$i];
	}

	return 0;
};

sub clear { @{ $_[0] } = () }

sub length { scalar @{ $_[0] } }

use Sort::ArbBiLex (
	'schmancy_sort' =>
	  "
	  0 1 2 3 4 5 6 7 8 9
     a A à À á Á â Â ã Ã ä Ä å Å æ Æ
     b B
     c C ç Ç
     d D ð Ð
     e E è È é É ê Ê ë Ë
     f F
     g G
     h H
     i I ì Ì í Í î Î ï Ï
     j J
     k K
     l L
     m M
     n N ñ Ñ
     o O ò Ò ó Ó ô Ô õ Õ ö Ö ø Ø
     p P
     q Q
     r R
     s S ß
     t T þ Þ
     u U ù Ù ú Ú û Û ü Ü
     v V
     w W
     x X
     y Y ý Ý ÿ
     z Z
    "
);

use overload 'neg' => sub {
	$_[0]->new( schmancy_sort( @{ $_[0] } ) )
};

use overload '~' => sub { $_[0]->new( Algorithm::Numerical::Shuffle::shuffle( @{ $_[0] } ) ) };

sub toString { join ', ', @{ $_[0] } }

1;
__END__

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

