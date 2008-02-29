package Weed::Callbacks;

our $VERSION = '0.006';

use Weed 'X3DCallbacks : X3DArrayHash ()';

sub add {
	my ( $this, $callback ) = @_;

	return unless UNIVERSAL::isa( $callback, 'CODE' );

	my $callbackId = X3DUniversal::getId($callback);

	return if exists $this->{$callbackId};

	my $id = X3DUniversal::getId($callback);

	push @$this, $this->{$callbackId} = $callback;

	return $id;

}

sub remove {
	my ( $this, $id ) = @_;

	my $index = $this->index($id);
	return if $index < 0;

	my $value = splice @$this, $this->getIndex($id), 1;

	my $objectId   = X3DUniversal::getId( $value->[0] );
	my $callbackId = X3DUniversal::getId( $value->[1] );

	delete $this->{$objectId}->{$callbackId};

	return;
}

sub processEvents {
	my ( $this, @values ) = @_;
	$_->( @values ) foreach @$this;
	return;
}

sub getIndex {
	my ( $this, $id ) = @_;
	my $i = 0;
	for ( my $count = $#$this ; $i > -1 ; --$i ) {
		return $i if $this->[$i]->getId == $id;
	}
	return -1;
}

1;
__END__
