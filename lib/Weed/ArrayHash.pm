package Weed::ArrayHash;

our $VERSION = '0.002';

use Weed 'X3DArrayHash : X3DArray X3DHash ()';

use overload
  'bool' => sub { $_[0]->getArray or $_[0]->getHash ? YES : NO },

  'int' => sub { int( $_[0]->getArray ) + int( $_[0]->getHash ) },
  '0+'  => sub { int( $_[0] ) },

  '<=>' => sub { warn },
  'cmp' => sub { warn },

  '@{}' => 'getArray',
  '%{}' => 'getHash',
  ;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	my $this = bless \{}, $type;
	$$this->{array} = new X3DArray $_[1];
	$$this->{hash}  = new X3DHash $_[2];
	return $this;
}

sub getClone {
	my $clone = $_[0]->new;
	@$clone = @{ $_[0] };
	%$clone = %{ $_[0] };
	return $clone;
}

sub getArray { ${ $_[0] }->{array} }
sub getHash  { ${ $_[0] }->{hash} }

sub clear { @{ $_[0] } = %{ $_[0] } = () }

sub toString {
	my $this = shift;

	return "( )" unless @$this or %$this;

	my $string = "";

	$string .= '(';

	if ( @$this or %$this ) {

		X3DGenerator->inc;
		$string .= X3DGenerator->tidy_break;
		$string .= X3DGenerator->indent;
		$string .= $this->X3DArray::toString;
		$string .= X3DGenerator->tidy_break;
		$string .= X3DGenerator->indent;
		$string .= $this->X3DHash::toString;
		X3DGenerator->dec;

		$string .= X3DGenerator->tidy_break;

	} else {
		$string .= X3DGenerator->tidy_space;
	}

	$string .= X3DGenerator->indent;
	$string .= ')';

	return $string;
}

1;
__END__
