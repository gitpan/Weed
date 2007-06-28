package VRML::Field::SFImage;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	"<=>" => \&ncmp,
	"==" => \&neq,
	"!=" => \&nne,
	'""' => \&toString;

use Array;

use PML::File::Image;

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
	my $this  = \$value;
	bless $this, $class;
	if (-f $_[0]) {
		$this->setValue(PML::File::Image->new($_[0])->data);
	} else {
		$this->setValue(@_);
	}
	return $this;
}

sub setValue {
	my $this = shift;
	
	if (ref $_[0]) {
		${$this}->{width}      = $_[0]->{width};
		${$this}->{height}     = $_[0]->{height};
		${$this}->{components} = $_[0]->{components};
		${$this}->{pixels}     = $_[0]->{pixels};
	} else {
		${$this}->{width}      = shift || 0;
		${$this}->{height}     = shift || 0;
		${$this}->{components} = shift || 0;
		${$this}->{pixels}     = @_ ? ref $_[0] ? shift : [ @_ ] : [];
	}
}

sub getValue {
	my $this = shift;
	return {
		width      => ${$this}->{width},
		height     => ${$this}->{height},
		components => ${$this}->{components},
		pixels     => [@{${$this}->{pixels}}]
	};
}

sub setWidth      { return ${$_[0]}->{width} = shift || 0 }
sub setHeight     { return ${$_[0]}->{height} = shift || 0 }
sub setComponents { return ${$_[0]}->{components} = shift || 0 }
sub setPixels     { return ${$_[0]}->{pixels} = @_ ? ref $_[0] ? shift : [ @_ ] : [] }

sub getWidth      { return ${$_[0]}->{width} }
sub getHeight     { return ${$_[0]}->{height} }
sub getComponents { return ${$_[0]}->{components} }
sub getPixels     { return ${$_[0]}->{pixels} }

sub width      { return ${$_[0]}->{width} }
sub height     { return ${$_[0]}->{height} }
sub components { return ${$_[0]}->{components} }
sub pixels     { return ${$_[0]}->{pixels} }

sub size       { return ${$_[0]}->{width} * ${$_[0]}->{height} * ${$_[0]}->{components} }

sub ncmp {
	return $_[1] <=> $_[0]->size unless ref $_[1];
	return $_[1] <=> $_[0]->size unless ref $_[1] eq ref $_[0];
	return array_ncmp($_[0]->pixels, $_[1]->pixels);
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { $_[1] <=> $_[0] }

sub toString {
	my $this = shift;
	my $string = '';

	my $format;
	$format .= "0x%x " x $this->width;
	$format = "$format\n";
	$format x= $this->height;

	$format = "%s %s %s\n".$format;
	
	$string = sprintf $format, 
		$this->width,
		$this->height,
		$this->components,
		@{ $this->pixels };

	return $string;
}

1;
__END__
