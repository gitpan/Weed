package VRML2::Array;
use strict;

BEGIN {
	use Carp;

	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(
		&binary_search
		&array_index
		&array_expand &array_pad &array_trim &array_fit
		&array_diff
		&array_ncmp
		&columns
	);
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

sub array_index {
    my ($array, $word) = @_;
	my $i = 0;
	for(; $i < @$array; ++$i) {
		return $i if $array->[$i] eq $word;
	}
	return 0;
}

#######################################################################

sub array_pad {
	my $array = shift;
	my $length = shift;
	my $fill = shift || '';
	for (my $i = @{$array}; $i < $length; ++$i) {
		$array->[$i] = $fill;
	}
	return $array;
}

sub array_expand {
	return array_pad(@_);
}

sub array_trim {
	my $array = shift;
	my $length = shift;
	for (my $i = @{$array}; $i > $length; --$i) {
		delete $array->[$i];
	}
	return $array;
}

sub array_fit {
	my $array = shift;
	my $length = shift;
	my $fill = shift || '';
	return @{$array} > $length ? array_trim($array, $length) : array_expand($array, $length, $fill);
}

#######################################################################

sub array_diff {
	my $array = shift;
	my $hash = { map { map { ("$_" => $_, ${$_} => $_) } @{$_} } @_ };

	my $result = [];
	foreach (@{$array}) {
		next if exists $hash->{"$_"} || exists $hash->{${$_}};
		push @{$result}, $_;
	}

	return $result;
}

sub array_ncmp {
	return $#{$_[1]} <=> $#{$_[0]}
		unless $#{$_[0]} == $#{$_[1]};
	for (my $i = 0; $i < $#{$_[0]} + 1; ++$i) {
		my $c = $_[0]->[$i] <=> $_[1]->[$i];
		return $c if $c;
	}
	return 0;
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

1;
__END__
