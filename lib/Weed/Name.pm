package Weed::Name;

our $VERSION = '0.0079';

use Weed 'X3DName ()';

my $Hash = {};

my $_NameExtension = qr._\d+$.so;

use overload
  'bool' => sub { ${ $_[0] }->{string} ? YES: NO },

  'int' => sub { ${ $_[0] }->{count} },

  '<=>' => sub {
	$_[2] ?
	  int( ${ $_[1] } ) <=> int( ${ $_[0] } )
	  :
	  int( ${ $_[0] } ) <=> int( ${ $_[1] } )
  }
  ;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	my $this = bless do { my $scalar; \$scalar }, $type;
	$this->setValue($_[1]);
	return $this;
}

sub setValue {
	my ( $this, $string ) = ( $_[0], $_[1] ? "$_[1]" : "" );

	$string =~ s/$_NameExtension//;

	if ($$this) {
		return if $$this->{string} eq $string;
		$this->clear;
	}

	if ( exists $Hash->{$string} ) {
		$Hash->{$string}->{count}++;
	} else {
		$Hash->{$string} = {
			string => $string,
			count  => 1,
		};
	}

	$$this = $Hash->{$string};

	return;
}

sub getValue { ${ $_[0] }->{string} }

sub toString {
	my $this = shift;
	return sprintf "%s_%d", $$this->{string}, $this->getId;
}

sub clear {
	my $this = shift;

	my $value = $$this;

	delete $Hash->{ $value->{string} } unless --$value->{count};

	$$this = undef;

	return;
}

sub DESTROY {
	my $this = shift;
	$this->clear;
}

#use Data::Dumper ();

#sub DumpHash { Data::Dumper::Dumper $Hash }

1;
__END__
