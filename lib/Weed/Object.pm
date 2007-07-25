package Weed::Object;

use Weed 'X3DObject ()';

our $VERSION = '0.011';

use Weed::Callbacks;

use overload
  '%{}' => sub { ${ $_[0] } };

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	my $this = bless \{}, $type;

	$$this->{tainted}   = NO;
	$$this->{callbacks} = new X3DCallbacks;

	$$this->{parents}  = new X3DParentHash;
	$$this->{comments} = new X3DArray;

	return $this;
}

sub getTainted { ${ $_[0] }->{tainted} }

sub setTainted {    #X3DMessage->Debug(@_);
	my ( $this, $value ) = @_;
	return if $$this->{tainted} == $value;

	$$this->{tainted} = $value;

	if ($value) {
		if ( $this->getParents ) {
			$_->setTainted($value) foreach @{ $this->getParents };
		}
	}
}

sub processEvents {
	my ( $this, $time ) = @_;

	$$this->{callbacks}->process( $this, defined $time ? $time : time )
	  while $this->getTainted
	  ;

	return;
}

#
sub addCallback {
	my ( $this, $object, $callback ) = @_;
	return $$this->{callbacks}->add( $object, $callback );
}

sub removeCallback {
	my ( $this, $object, $callback ) = @_;
	return $$this->{callbacks}->remove( $object, $callback );
}

#
sub getParents { ${ $_[0] }->{parents} }

sub getComments { wantarray ? @{ ${ $_[0] }->{comments} } : ${ $_[0] }->{comments} }

sub toString {
	my ($this) = @_;

	my $string = '';
	$string .= $this->getType;
	$string .= X3DGenerator->tidy_space;
	$string .= X3DGenerator->open_brace;
	$string .= X3DGenerator->tidy_space;
	$string .= X3DGenerator->close_brace;

	return $string;
}

#sub DESTROY {
#	my $this = shift;
#	print "Object::DESTROY ", ref $this;
#	%$this = ();
#	0;
#}

1;
__END__
