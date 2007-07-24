package Weed::Callbacks;

our $VERSION = '0.002';

use Weed 'X3DCallbacks : X3DArrayHash ()';

sub add {
	my ( $this, $object, $callback ) = @_;

	return unless UNIVERSAL::isa( $callback, 'CODE' );

	my $value = new X3DArray [ $object, $callback ];

	my $id = $value->getId;
	push @$this, $this->{$id} = $value;

	return $id;

}

sub remove {
	my ( $this, $id ) = @_;

	return unless delete $this->{$id};
	splice @$this, $this->index($id), 1;

	return;
}

sub index {
	my ( $this, $id ) = @_;
	my $i = 0;
	for ( my $count = $#$this ; $i > -1 ; --$i ) {
		return $i if $this->[$i]->getId eq $id;
	}
	return -1;
}

sub process {
	my ( $this, $object, $time ) = @_;
	$object->setTainted(NO);
	$_->[1]->( $_->[0], $object, $time ) foreach @$this;
}

1;
__END__
