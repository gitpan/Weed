package Weed::Object;

use Weed 'X3DObject { }';

our $VERSION = '0.0079';

sub CREATE {
	my $self = $_[0];
	my $type = ref($self) || $self;
	my $this = bless {}, $type;
	$this->{comments} = [];
	$this->{parents}  = new X3DParentHash;
	return $this;
}

sub getComments { wantarray ? @{ $_[0]->{comments} } : $_[0]->{comments} }

sub getParents { $_[0]->{parents} }

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
