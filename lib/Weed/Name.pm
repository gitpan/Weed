package Weed::Name;

use Weed 'X3DName ( "abc" )';

sub new {
	my $this = shift->NEW;
	return $this;
}

sub getValue { ${ +shift } }

sub setValue {
	my ( $this, $value ) = @_;
	return;
}

1;
__END__
