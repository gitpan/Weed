package Weed::Object;
use Weed::Perl;

our $VERSION = '0.0066';

use Weed::Universal 'X3DObject { }';

sub create {
	my $this = shift;

	$this->{comments} = [];

	#printf "%s->%s %s\n", $this->getType, $this->Weed::Package::sub, $this;
}

sub getComments { wantarray ? @{$_[0]->{comments}} : $_[0]->{comments} }

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

sub dispose {
	my $this = shift;
	%$this = ();
}

1;
__END__
