package SFImage;
use strict;

use rlib "../";

use Array;
use X3DGenerator;
use Attribute::Overload;

#  Comp.   byte[0]    byte[1]     byte[2]    byte[3]
#  ------- ---------- ---------- ----------- -----------
#     1    intensity1 intensity2  intensity3  intensity4
#     2    intensity1   alpha1    intensity2   alpha2
#     3       red1      green1      blue1       red2
#     4       red1      green1      blue1      alpha1

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $value = {};
	my $this  = bless \$value, $class;
	$this->setValue(@_);
	return $this;
}

use overload
  "<=>" => sub { Array::ncmp( $_[0]->pixels, $_[1]->pixels ) },
  "=="  => sub { !( $_[0] <=> $_[1] ) },
  "!=" => sub { ( $_[1] <=> $_[0] ) && 1 },
  ;

sub setValue {
	my $this = shift;

	if ( ref $_[0] ) {
		${$this}->{width}      = $_[0]->[0] || 0;
		${$this}->{height}     = $_[0]->[1] || 0;
		${$this}->{components} = $_[0]->[2] || 0;
		@{ ${$this}->{pixels} } = @{ $_[0]->[3] || [] };
	}
	else {
		${$this}->{width}      = $_[0] || 0;
		${$this}->{height}     = $_[1] || 0;
		${$this}->{components} = $_[2] || 0;
		@{ ${$this}->{pixels} } = @{ $_[3] || [] };
	}
}

sub getValue {
	my $this = shift;
	return ${$this}->{width}, ${$this}->{height}, ${$this}->{components},
	  [ @{ ${$this}->{pixels} } ];
}

sub setWidth      { return ${ $_[0] }->{width}      = shift || 0 }
sub setHeight     { return ${ $_[0] }->{height}     = shift || 0 }
sub setComponents { return ${ $_[0] }->{components} = shift || 0 }

sub setPixels {
	return ${ $_[0] }->{pixels} = @_ ? ref $_[0] ? shift: [@_] : [];
}

sub getWidth      { return ${ $_[0] }->{width} }
sub getHeight     { return ${ $_[0] }->{height} }
sub getComponents { return ${ $_[0] }->{components} }
sub getPixels     { return ${ $_[0] }->{pixels} }

sub width      { return ${ $_[0] }->{width} }
sub height     { return ${ $_[0] }->{height} }
sub components { return ${ $_[0] }->{components} }
sub pixels     { return ${ $_[0] }->{pixels} }

sub x {
	my $this = shift;
	${$this}->{width} = shift if @_;
	return ${$this}->{width};
}

sub y {
	my $this = shift;
	${$this}->{height} = shift if @_;
	return ${$this}->{height};
}

sub comp {
	my $this = shift;
	${$this}->{components} = shift if @_;
	return ${$this}->{components};
}

sub array {
	my $this = shift;
	${$this}->{pixels} = shift if @_;
	return ${$this}->{pixels};
}

sub size {
	return ${ $_[0] }->{width} * ${ $_[0] }->{height} *
	  ${ $_[0] }->{components};
}

sub toString : Overload("") {
	my $this = shift;

	my $format;

	X3DGenerator::INC_INDENT;
	$format = "0x%x " x $this->width;
	$format = substr $format, 0, -1;
	$format = $X3DGenerator::INDENT . $format . $X3DGenerator::BREAK;
	$format x= $this->height;
	$format = substr $format, 0, -length $X3DGenerator::BREAK;
	X3DGenerator::DEC_INDENT;

	$format = "%s %s %s" . $X3DGenerator::BREAK . $format;

	my $string .= sprintf $format, $this->width, $this->height,
	  $this->components, @{ $this->pixels };

	return $string;
}

1;
__END__
