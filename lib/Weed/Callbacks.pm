package Weed::Callbacks;

our $VERSION = '0.005';

use Weed 'X3DCallbacks : X3DArrayHash ()';

use Scalar::Util ();

sub add {
	my ( $this, $object, $callback ) = @_;

	return unless UNIVERSAL::isa( $callback, 'CODE' );

	my $objectId   = X3DUniversal::getId($object);
	my $callbackId = X3DUniversal::getId($callback);

	return if exists $this->{$objectId}->{$callbackId};

	my $value = [ $object, $callback ];
	my $id = X3DUniversal::getId($value);

	push @$this, $this->{$objectId}->{$callbackId} = $value;
	
	Scalar::Util::weaken($value->[0]);

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
	my ( $this, $value, $time ) = @_;

	while ( $value->getTainted ) {
		$value->setTainted(NO);
		$_->[1]->( $_->[0], $value, $time ) foreach @$this;
	}

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
