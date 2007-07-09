package Weed::Tie::MFNodeValue;
use Weed;

use base 'Weed::Tie::ArrayFieldValue';

sub storeValue {
	my ( $this, $value ) = @_;
	my $node = $this->{fieldType}->new($value)->getValue;

	if ($node) {
		my $id = $node->getId;
		if ( exists $this->{nodes}->{$id} ) {
			$this->{nodes}->{$id}++;
		} else {
			$this->{nodes}->{$id} = 1;
			$node->getParents->add( $this->getParent );
		}
		$node->addClone;
	}

	return $node;
}

sub removeValues {
	my $this = shift;
	$this->removeParents(@_);
	return $this->SUPER::removeValues(@_);
}

sub removeParents {
	my $this = shift;
	
	foreach my $node ( grep { $_ } @_ ) {
		my $id = $node->getId;
		unless ( --$this->{nodes}->{$id} ) {
			delete $this->{nodes}->{$id};
			$node->getParents->remove( $this->getParent );
			$node->removeClone;
			$node->dispose;
		}
	}
}

sub TIEARRAY {
	my $this = shift->SUPER::TIEARRAY(@_);
	$this->{nodes} = new X3DHash;
	return $this;
}

sub STORE {
	$_[0]->removeParents( $_[0]->getArray->[ $_[1] ] );
	$_[0]->SUPER::STORE( $_[1], $_[2] );
}

sub STORESIZE {

	return $_[0]->removeParents(
		splice @{ $_[0]->getArray }, Math::max( 0, $_[1] )
	) if $_[1] < $_[0]->FETCHSIZE;

	$_[0]->SUPER::STORESIZE( $_[1] );
}

sub CLEAR {
	$_[0]->removeParents( @{ $_[0]->getArray } );
	return $_[0]->SUPER::CLEAR;

}

sub DELETE {
	$_[0]->removeParents(
		delete $_[0]->getArray->[ $_[1] ]
	);
}

sub DESTROY {
	#printf "Weed::Tie::MFNodeValue::DESTROY %s\n", join ", ", map { $_->getReferenceCount } @{ $_[0]->getArray };
	0;
}

1
__END__
