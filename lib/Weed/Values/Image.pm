package Weed::Values::Image;
use Weed::Perl;

#use PDL;

#use constant getDefaultValue => [ 0, 0, 0 ];

use overload
  #  '=' => 'copy',
  'eq' => sub { $_[1] eq "$_[0]" },
  'ne' => sub { $_[1] ne "$_[0]" },
  '""' => 'toString',
  ;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	if ( 0 == @_ ) {
		$this->setValue( 0, 0, 0, [] );
	}
	elsif ( 1 == @_ ) {
		my $arg = shift;
		if ( 'ARRAY' eq ref $arg ) {
			$this->setValue(@$arg);
		}
		elsif ( UNIVERSAL::isa( $arg, __PACKAGE__ ) ) {
			$this->setValue( @$arg{qw'width height components array'} );
		}
	}
	elsif ( 3 == @_ ) {
		$this->setValue( @_, [] );
	}
	elsif ( 4 == @_ ) {
		$this->setValue(@_);
	}
	else {
		warn("Don't understand arguments passed to new()");
		return;
	}

	return $this;
}

sub copy { $_[0]->new( $_[0]->getValue ) }

sub setValue {
	my ( $this, $width, $height, $components, $array ) = @_;

	$this->{width}      = $width;
	$this->{height}     = $height;
	$this->{components} = $components;
	$this->{array}      = $array || [];

	return;
}

sub getValue {
	my ($this) = @_;
	return (
		$this->{width},
		$this->{height},
		$this->{components},
		[ @{ $this->{array} } ] );
}

sub getWidth { $_[0]->{width} }

sub getHeight { $_[0]->{height} }

sub getComponents { $_[0]->{components} }

sub getArray { $_[0]->{array} }

sub toString {
	my $this = shift;

	return "0 0 0" unless $this->{width} * $this->{height};

	my $format;

	$format = "0x%x " x $this->{width};
	$format = substr $format, 0, -1;
	$format = $format . "\n";
	$format x= $this->{height};
	$format = substr $format, 0, -length "\n";

	$format = "%s %s %s" . "\n" . $format;

	my $string .= sprintf $format,
	  $this->{width},
	  $this->{height},
	  $this->{components},
	  @{ $this->{array} };

	return $string;
}

1;
