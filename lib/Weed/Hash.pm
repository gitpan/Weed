package Weed::Hash;

our $VERSION = '0.0079';

use Weed 'X3DHash { }';

use overload
  'bool' => 'getSize',

  'int' => 'getSize',
  '0+'  => 'getSize',
  ;

sub new { shift->NEW }

#sub getClone { $_[0]->new( $_[0]->getValue ) }

sub getKeys   { new X3DArray [ keys( %{ $_[0] } ) ] }
sub getValues { new X3DArray [ values( %{ $_[0] } ) ] }

sub exists { exists $_[0]->{ $_[1] } }

sub clear { %{ $_[0] } = () }

sub getSize { scalar keys %{ $_[0] } }

sub toString {
	my $this = shift;

	my $string = "";

	$string .= X3DGenerator->indent;
	$string .= X3DGenerator->open_brace;

	if ( keys %$this ) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		while ( my ( $key, $value ) = each %$this ) {
			$string .= X3DGenerator->indent;
			$string .= $key;
			$string .= X3DGenerator->space;
			$string .= '=>';
			$string .= X3DGenerator->space;
			$string .= $value;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	} else {
		$string .= X3DGenerator->tidy_space;
	}

	$string .= X3DGenerator->close_brace;

	return $string;
}

#sub DESTROY {
#	my $this = shift;
#	%$this = ();
#	0;
#}

1;
__END__
