package Weed::Hash;

our $VERSION = '0.0081';

use Weed 'X3DHash { }', 'isHash';

use overload
  'bool' => 'getSize',

  'int' => 'getSize',
  '0+'  => 'getSize',

  #  '<=>' => sub { warn },
  #  'cmp' => sub { warn },
  ;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	return bless {}, $type;
}

sub getClone {
	my $clone = $_[0]->new;
	%$clone = %{ $_[0] };
	return $clone;
}

sub getKeys   { new X3DArray [ keys( %{ $_[0] } ) ] }
sub getValues { new X3DArray [ values( %{ $_[0] } ) ] }

sub getSize { scalar keys %{ $_[0] } }

sub isHash {
	UNIVERSAL::isa( $_[0], __PACKAGE__ )
	  or
	  UNIVERSAL::isa( $_[0], 'HASH' )
}

sub clear { %{ $_[0] } = () }

sub toString {
	my $this = shift;

	my $string = "";

	$string .= X3DGenerator->open_brace;

	if (%$this) {
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
