package Weed::Object;
use Weed::Perl;

use Weed::Universal 'X3DObject { }';

sub new { shift->CREATE }

sub CREATE {
	my $this = shift->NEW;
	$this->{comments} = [];
	return $this;
}

sub getComments { wantarray ? @{ $_[0]->{comments} } : $_[0]->{comments} }

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

sub DESTROY {
	my $this = shift;
	%$this = ();
	0;
}

1;
__END__
\$
\@ []
\% {}
\&
\*
