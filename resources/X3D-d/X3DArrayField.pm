package X3DArrayField;
use strict;
use warnings;

use base qw(X3DField);

sub getValue {
	[ map { $_->copy } @{ $_[0]->{value} } ];
}
sub get1Value { $_[0]->{value}->[ $_[1] ]->copy }

sub setValue {
	my ( $this, $value ) = @_;
	#X3DError::Debug ref $value;

	$this->{update} = 1;

	for ( my $i = 0 ; $i < @$value ; ++$i ) {
		$this->set1Value( $i, $value->[$i] );
	}

	return;
}

sub set1Value { $_[0]->{value}->[ $_[1] ] = $_[2]->copy }

sub length { scalar @{ $_[0]->{value} } }

1;
__END__
