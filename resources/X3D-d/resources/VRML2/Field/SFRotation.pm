package VRML2::Field::SFRotation;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;
	use VRML2::Array qw(array_ncmp);

	use VRML2::Math;
	
	use VRML2::Generator;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	"<=>" => \&ncmp,
	"=="  => \&neq,
	"!="  => \&nne,
	'""' => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = [];

	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub ncmp {
	return array_ncmp($_[0], $_[1]);
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { ($_[0] <=> $_[1]) && 1 }


sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0]) {
			$this->[0] = $_[0]->[0] || 0;
			$this->[1] = $_[0]->[1] || 0;
			$this->[2] = $_[0]->[2] || 0;
			$this->[3] = $_[0]->[3] || 0;
		} else {
			$this->[0] = $_[0] || 0;
			$this->[1] = $_[1] || 0;
			$this->[2] = $_[2] || 0;
			$this->[3] = $_[3] || 0;
		}
	} else {
		$this->[0] = 0;
		$this->[1] = 0;
		$this->[2] = 1;
		$this->[3] = 0;
	}
}

sub getValue { [ @{$_[0]} ] }


sub _normalize {
	my $this = shift;
	return;

#	my $length = sqrt(
#		$this->[0] * $this->[0] +
#		$this->[1] * $this->[1] +
#		$this->[2] * $this->[2]
#	);
#
#	return @{$this} = (0, 0, 1, 0) unless $length;
#	
#	$this->[0] /= $length;
#	$this->[1] /= $length;
#	$this->[2] /= $length;
#
#
##	if ($this->[3] < 0) {
##		$this->[0] = -$this->[0];
##		$this->[1] = -$this->[1];
##		$this->[2] = -$this->[2];	  
##	}
##
##	$this->[3] = cos($this->[3]);
##	$this->[3] = VRML2::Math::acos($this->[3]);

}

sub toString {
	my $this = shift;
	return sprintf "%s %s %s %s", map {(sprintf $FLOAT, $_) +0} @{$this};
}

1;
__END__
# Copyright (C) 1998 Tuomas J. Lukka
# DISTRIBUTED WITH NO WARRANTY, EXPRESS OR IMPLIED.
# See the GNU Library General Public License (file COPYING in the distribution)
# for conditions of use and redistribution.

##############################################
#
# Quaternions... inefficiently.
#
# Should probably use PDL and C... ?
#
# Stored as [c,x,y,z].

package VRML::Quaternion;

sub new {
	my($type,$c,$x,$y,$z) = @_;
	my $this = bless [$c,$x,$y,$z],$type;
	return $this;
}

sub as_str {
	sprintf("[%4.4f %4.4f %4.4f %4.4f]", @{$_[0]});
}

sub copy {
	return new VRML::Quaternion(@{$_[0]});
}

sub new_vrmlrot {
	my($type,$x,$y,$z,$a) = @_;
	my $l = sqrt($x**2+$y**2+$z**2);
	if(abs($l) < 0.000001) {return bless [0,0,1,0],$type}
	# print "NEWQ: $type $x $y $z $a\n";
	my $this = bless [cos($a/2),map {sin($a/2)*$_/$l} $x,$y,$z],$type;
	$this->normalize_this();
	return $this;
}

sub to_vrmlrot {
	my($this) = @_;
	my $d = POSIX::acos($this->[0]);
	if(abs($d) < 0.0000001) {
		return [0,0,1,0];
	}
	return [(map {$_/sin($d)} @{$this}[1..3]),2*$d];
}

# Yuck
sub multiply {
	my($this,$with) = @_;
	return VRML::Quaternion->new(
		$this->[0] * $with->[0] -
		$this->[1] * $with->[1] -
		$this->[2] * $with->[2] -
		$this->[3] * $with->[3],
			$this->[2] * $with->[3] -
			$this->[3] * $with->[2] +
			$this->[0] * $with->[1] +
			$this->[1] * $with->[0],
		$this->[3] * $with->[1] -
		$this->[1] * $with->[3] +
		$this->[0] * $with->[2] +
		$this->[2] * $with->[0],
			$this->[1] * $with->[2] -
			$this->[2] * $with->[1] +
			$this->[0] * $with->[3] +
			$this->[3] * $with->[0],
	);
}

sub multiply_scalar {
	my($this,$scalar) = @_;
	my $ang = POSIX::acos($this->[0]);
	my $d = sin($ang);
	if(abs($d) < 0.0000001) {
		return new VRML::Quaternion(1,0,0,0);
	}
	$ang *= $scalar;
	my $d2 = sin($ang);
	return new VRML::Quaternion(
		cos($ang), map {$_*$d2/$d} @{$this}[1..3]
	);
}

sub set {
	my($this,$new) = @_;
	@$this = @$new;
}

sub add {
	my($this,$with) = @_;
	return VRML::Quaternion->new(
		$this->[0] * $with->[0],
		$this->[1] * $with->[1],
		$this->[2] * $with->[2],
		$this->[3] * $with->[3]);
}

sub abssq {
	my($this) = @_;
	return  $this->[0] ** 2 + 
		$this->[1] ** 2 +
		$this->[2] ** 2 +
		$this->[3] ** 2 ;
}

sub invert {
	my($this) = @_;
	my $abssq = $this->abssq();
	return VRML::Quaternion->new(
		 1/$abssq * $this->[0] ,
		-1/$abssq * $this->[1] ,
		-1/$abssq * $this->[2] ,
		-1/$abssq * $this->[3] );
}

sub invert_rotation_this {
	my($this) = @_;
	$this->[0] = - $this->[0];
}

sub normalize_this {
	my($this) = @_;
	my $abs = sqrt($this->abssq());
	@$this = map {$_/$abs} @$this;
}

sub rotate {
  my($this,$vec) = @_;
  my $q = (VRML::Quaternion)->new(0,@$vec);
  my $m = $this->multiply($q->multiply($this->invert));
  return [@$m[1..3]];
}

sub rotate_foo {
  my ($this,$vec) = @_;
#  print "CP: ",(join ',',@$this)," and ",(join ',',@$vec),"\n";
  return $vec if $this->[0] == 1 or $this->[0] == -1;
# 1. cross product of my vector and rotated vector
# XXX I'm not sure of any signs!
  my @u = @$this[1..3];
  my @v = @$vec;
  my $tl = sqrt($u[0]**2 + $u[1]**2 + $u[2]**2);
  my $up = sqrt($v[0]**2 + $v[1]**2 + $v[2]**2);
  my @cp = (
  	$u[1] * $v[2] - $u[2] * $v[1],
  	$u[0] * $v[2] - $u[2] * $v[0],
  	$u[0] * $v[1] - $u[1] * $v[0],
  );
# Cross product of this and my vector
  my @cp2 = (
  	$u[1] * $cp[2] - $u[2] * $cp[1],
  	$u[0] * $cp[2] - $u[2] * $cp[0],
  	$u[0] * $cp[1] - $u[1] * $cp[0],
  );
  my $cpl = 0.00000001 + sqrt($cp[0]**2 + $cp[1]**2 + $cp[2]**2);
  my $cp2l = 0.0000001 + sqrt($cp2[0]**2 + $cp2[1]**2 + $cp2[2]**2);
  for(@cp) {$_ /= $cpl}
  for(@cp2) {$_ /= $cp2l}
  my $mult1 = $up * sqrt(1-$this->[0]**2);
  # my $mult1 = $up * sqrt(1-$this->[0]**2);
  my $mult2 = $up * $this->[0];
  print "ME: ",(join '    ',@u),"\n";
  print "VEC: ",(join '    ',@v),"\n";
  print "CP: ",(join '    ',@cp),"\n";
  print "CP2: ",(join '    ',@cp2),"\n";
  print "MULT1: $mult1, MULT2: $mult2\n";
  print "CPL: ",$cpl, " TL: $tl  CPLTL: ",$cpl/$tl,"\n";
  my $res = [map {
  	$v[$_] + $mult1 * $cp[$_] + ($mult2 - $cpl/$tl)* $cp2[$_]
  } 0..2];
#  print "RES: ",(join ',',@$res),"\n";
  return $res;
}

sub togl {
	my($this) = @_;
	if(abs($this->[0]) == 1) {return}
	if(abs($this->[0]) >= 1) {$this->normalize_this()}
	VRML::OpenGL::glRotatef(2*POSIX::acos($this->[0])/3.14*180, @{$this}[1..3]);
}

1;
