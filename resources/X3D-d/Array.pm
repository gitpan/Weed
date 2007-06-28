package Array;
use strict;
use warnings;

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

sub ncmp {
	return $_[1] <=> @{$_[0]} unless ref $_[1];
	return $#{$_[1]} <=> $#{$_[0]}
		unless $#{$_[0]} == $#{$_[1]};
	for (my $c, my $i = 0; $i < $#{$_[0]} + 1; ++$i) {
		return $c if $c = $_[0]->[$i] <=> $_[1]->[$i];
	}
	return 0;
}

1;
__END__
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

