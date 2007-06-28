#include "SFVec3f.cpp"

class Quaternion {
	public:
		double a;
		double x;
		double y;
		double z;
	
	private:
		Quaternion (const SFVec3f* axis) {
			setValue (0, axis->x, axis->y, axis->z);
		}

		Quaternion (const double a, const double x, const double y, const double z) {
			setValue (a, x, y, z);
		}

	public:
		Quaternion () { a = 1; x = y = z = 0; }
		
		Quaternion (const SFVec3f* axis, const double angle) { setRotation (axis, angle); }
		
		Quaternion (const SFVec3f* fromVector, const SFVec3f* toVector) {
			// Both args references to vectors
			double ax = fromVector->x; double ay = fromVector->y; double az = fromVector->z;
			double bx = toVector->x; double by = toVector->y; double bz = toVector->z;
			// Find cross product. This is a vector
			// perpendicular to both argument vectors,
			// and is therefore the axis of rotation.
			double x = ay*bz-az*by;
			double y = az*bx-ax*bz;
			double z = ax*by-ay*bx;
			// find the dot product.
			double dotprod = ax*bx+ay*by+az*bz;
			double mod1 = sqrt(ax*ax+ay*ay+az*az);
			double mod2 = sqrt(bx*bx+by*by+bz*bz);
			// Find the angle of rotation.
			double angle = acos(dotprod/(mod1*mod2));

			setRotation (x, y, z, angle);
		}

		inline void setValue (const double a, const double x, const double y, const double z) {
			this->a = a;
			this->x = x;
			this->y = y;
			this->z = z;
		}

		inline void setRotation (const SFVec3f* axis, const double angle) {
			setRotation (axis->x, axis->y, axis->z, angle);
		}

		void setRotation (double x, double y, double z, const double angle) {
			double modulus = sqrt(x*x+y*y+z*z); // Make it a unit vector
			x /= modulus;
			y /= modulus;
			z /= modulus;
		
			double st = sin(0.5 * angle);
			double ct = cos(0.5 * angle);
		
			setValue(ct, x * st, y * st, z * st);
		}

		void getAxisAngle (SFVec3f* axis, double& angle) {
			double theta = acos(a);
			double st = sin(theta);
			if (0==st) { // Rotation of angle zero about Z axis
				axis->setValue( 0,0,1 );
				angle = 0;
			} else {
				axis->setValue( x/st, y/st, z/st );
				angle = 2.0 * theta;
			}
		}
		
		inline Quaternion conjugate () {
			return Quaternion(a, -x,-y,-z);
		}

		inline double squarednorm () {
			return a*a + x*x + y*y + z*z;
		}

		inline Quaternion* scale (const double s) {
			return new Quaternion ( a*s, x*s, y*s, z*s);
		}
	
		inline Quaternion* inverse () {
			return conjugate().scale(1.0/squarednorm());
		}

		inline Quaternion* multiply (const Quaternion* q) {
			return new Quaternion (
				a * q->a
					- x*q->x
					- y*q->y
					- z*q->z,
				
				a * q->x
					+ q->a * x
					+ y * q->z - z * q->y,
				
				a * q->y
					+ q->a * y
					+ z * q->x - x * q->z,
				
				a * q->z
					+ q->a * z
					+ x * q->y - y * q->x
			);
		}

		inline const SFVec3f* multVec(const SFVec3f* vec) {
			Quaternion* i = inverse();
			Quaternion* p = Quaternion(vec).multiply(i);
			Quaternion* qq = multiply(p);
			SFVec3f* rvec = new SFVec3f(qq->x, qq->y, qq->z);
			delete i;
			delete p;
			delete qq;
			return rvec; 
		}
		
		inline double dot (const Quaternion* q) {
			return a*q->a + x*q->x + y*q->y + z*q->z;
		}
	
		inline void negate () {
			a = -a;
			x = -x;
			y = -y;
			z = -z;
		}
	
		inline Quaternion* plus (const Quaternion* q) {
			return new Quaternion (
				a + q->a,
				x + q->x,
				y + q->y,
				z + q->z
			);
		}

		inline Quaternion* normalize () {
			return scale(1.0/sqrt(squarednorm()));
		}

		inline Quaternion* slerp (Quaternion* q, const double t) {
			double dotprod = dot(q);
			if (dotprod<0) {
				// Reverse signs so we travel the short way round
				dotprod = -dotprod;
				q->negate();
			}

			double theta = acos(dotprod);

			if (abs(theta) < 1e-5) {
				// In the limit theta->0 , spherical interpolation is
				// approximated by linear interpolation, which also
				// avoids division-by-zero problems.
				Quaternion* q1 = scale(1-t);
				Quaternion* q2 = q->scale(t);
				Quaternion* q3 = q1->plus(q2);
				delete q1;
				delete q2;
				return q3;
			}
		
			double st = sin(theta);
			double ist = 1.0/st;
		
			Quaternion* q1 = scale(ist * sin( (1-t)*theta ));
			Quaternion* q2 = q->scale(ist*sin(t*theta));
			Quaternion* q3 = q1->plus(q2);
			Quaternion* q4 = q3->normalize();
			delete q1;
			delete q2;
			delete q3;
			return q4;
		}
};


/*
sub new {
	my $class = shift;

	my $arr=undef;

	if (0==@_) {
		# No arguments, default to unit quaternion.
		$arr = [ 1,0,0,0];
	} elsif (1==@_) {
		# One argument: if it's not a reference, construct
		# a "scalar quaternion" (x 0 0 0).
		my $arg = $_[0];
		my $reftype = ref($arg);

		if (!$reftype) {
			$arr = [ $arg,0,0,0];
		} else {
			# We've been passed a reference. If it's an array
			# ref, then construct a quaternion out of the
			# corresponding array.
			if ("ARRAY" eq $reftype) {
				return Math::Quaternion->new(@$arg);
			} elsif ("Math::Quaternion" eq $reftype) {
				# If it's a reference to another quaternion,
				# copy it.
				return Math::Quaternion->new(@$arg);
			} elsif ("HASH" eq $reftype) {
				# Hashref.
				my %hash = %$arg;
				if (defined($hash{'axis'})) {
					# Construct a rotation.
					return rotation(
						$hash{'angle'},
						@{$hash{'axis'}}
					);
				} elsif (defined($hash{'v2'})) {
					return rotation(
						$hash{'v1'},$hash{'v2'}
					);
				}
			}
			croak("Don't understand arguments to new()");

		}
	} elsif (3==@_) {
		# Three arguments: construct a quaternion to represent
		# the corresponding vector.
		$arr = [ 0, @_[0,1,2] ];
	} elsif (4==@_) {
		# Four arguments: just slot the numbers right in.
		$arr = [ @_[0,1,2,3] ];
	} else {
		croak("Don't understand arguments passed to new()");
	}
		

	bless $arr, $class;

}

=item B<unit>

Returns a unit quaternion.

 my $u = Math::Quaternion->unit; # Returns the quaternion (1,0,0,0).

=cut

sub unit {
	my $class = shift;

	bless [ 1,0,0,0 ], $class;
}

=item B<conjugate>

Returns the conjugate of its argument.

 my $q = Math::Quaternion->new(1,2,3,4);
 my $p = $q->conjugate;              # (1,-2,-3,-4)

=cut

sub conjugate {
	my $q=shift;

	return Math::Quaternion->new(
		  $q->[0],
		- $q->[1],
		- $q->[2],
		- $q->[3],
	);
}

=item B<inverse>

Returns the inverse of its argument.

 my $q = Math::Quaternion->new(1,2,3,4);
 my $qi = $q->inverse;

=cut

sub inverse {
	my $q = shift;

	return scale(conjugate($q),1.0/squarednorm($q));

}


=item B<normalize>

Returns its argument, normalized to unit norm.

  my $q = Math::Quaternion->new(1,2,3,4);
  my $qn = $q->normalize;

=cut

sub normalize {
	my $q = shift;
	return scale($q,1.0/sqrt(squarednorm($q)));
}

=item B<modulus>

Returns the modulus of its argument, defined as the 
square root of the scalar obtained by multiplying the quaternion
by its conjugate.

 my $q = Math::Quaternion->new(1,2,3,4);
 print $q->modulus;

=cut

sub modulus {
	my $q = shift;
	return sqrt(squarednorm($q));
}

=item B<isreal>

Returns 1 if the given quaternion is real ,ie has no quaternion
part, or else 0.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $q2 = Math::Quaternion->new(5,0,0,0);
 print $q1->isreal; # 1;
 print $q2->isreal; # 0;

=cut

sub isreal {
	my $q = shift;
	my ($q0,$q1,$q2,$q3)=@$q;

	if ( (0.0==$q1) && (0.0==$q2) && (0.0==$q3) ) {
		return 1;
	} else {
		return 0;
	}
}

=item B<multiply>

Performs a quaternion multiplication of its two arguments.
If one of the arguments is a scalar, then performs a scalar
multiplication instead.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $q2 = Math::Quaternion->new(5,6,7,8);
 my $q3 = Math::Quaternion::multiply($q1,$q2);         # (-60 12 30 24)
 my $q4 = Math::Quaternion::multiply($q1,$q1->inverse); # (1 0 0 0) 

=cut

sub multiply {
	my ($a,$b,$reversed) = @_;
	($a,$b) = ($b,$a) if $reversed;

	if (!ref $a) { return scale($b,$a); }
	if (!ref $b) { return scale($a,$b); }

	my $q = new Math::Quaternion;

	$q->[0] = $a->[0] * $b->[0] 
		- $a->[1]*$b->[1]
		- $a->[2]*$b->[2]
		- $a->[3]*$b->[3];
	
	$q->[1] = $a->[0] * $b->[1]
		+ $b->[0] * $a->[1]
		+ $a->[2] * $b->[3] - $a->[3] * $b->[2];

	$q->[2] = $a->[0] * $b->[2]
		+ $b->[0] * $a->[2]
		+ $a->[3] * $b->[1] - $a->[1] * $b->[3];

	$q->[3] = $a->[0] * $b->[3]
		+ $b->[0] * $a->[3]
		+ $a->[1] * $b->[2] - $a->[2] * $b->[1];
	return $q;
}

=item B<dot>

Returns the dot product of two quaternions.

 my $q1=Math::Quaternion->new(1,2,3,4);
 my $q2=Math::Quaternion->new(2,4,5,6);
 my $q3 = Math::Quaternion::dot($q1,$q2);

=cut

sub dot {
	my ($q1,$q2) = @_;
	my ($a0,$a1,$a2,$a3) = @$q1;
	my ($b0,$b1,$b2,$b3) = @$q2;
	return $a0*$b0 + $a1*$b1 + $a2*$b2 + $a3*$b3 ;
}

=item B<plus>

Performs a quaternion addition of its two arguments.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $q2 = Math::Quaternion->new(5,6,7,8);
 my $q3 = Math::Quaternion::plus($q1,$q2);         # (6 8 10 12)

=cut


sub plus {
	my ($a,$b,$reversed)=@_;
	my $q = Math::Quaternion->new(
		$a->[0] + $b->[0],
		$a->[1] + $b->[1],
		$a->[2] + $b->[2],
		$a->[3] + $b->[3],
	);

	return $q;

}

=item B<minus>

Performs a quaternion subtraction of its two arguments.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $q2 = Math::Quaternion->new(5,6,7,8);
 my $q3 = Math::Quaternion::minus($q1,$q2);         # (-4 -4 -4 -4)

=cut

sub minus {
	my ($a,$b,$reversed)=@_;
	($a,$b) = ($b,$a) if $reversed;
	my $q = Math::Quaternion->new(
		$a->[0] - $b->[0],
		$a->[1] - $b->[1],
		$a->[2] - $b->[2],
		$a->[3] - $b->[3],
	);

	return $q;

}

=item B<power>

Raise a quaternion to a scalar or quaternion power.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $q2 = Math::Quaternion::power($q1,4);     # ( 668 -224 -336 -448 )
 my $q3 = $q1->power(4);                # ( 668 -224 -336 -448 )
 my $q4 = $q1**(-1);			 # Same as $q1->inverse

 use Math::Trig;
 my $q5 = exp(1)**( Math::Quaternion->new(pi,0,0) ); # approx (-1 0 0 0)

=cut

sub power {
	my ($a,$b,$reversed)=@_;
	($a,$b) = ($b,$a) if $reversed;

	if (ref $a) {
		$a = Math::Quaternion->new($a);
	}

	if (ref $b) {
		# For quaternion^quaternion, use exp and log.
		return Math::Quaternion::exp(Math::Quaternion::multiply($b,Math::Quaternion::log($a)));
	}

	# For quat raised to a scalar power, do it manually.

	my ($a0,$a1,$a2,$a3) = @$a;

	my $s = sqrt($a->squarednorm);
	my $theta = Math::Trig::acos($a0/$s);
	my $vecmod = sqrt($a1*$a1+$a2*$a2+$a3*$a3);
	my $stob = ($s**$b);
	my $coeff = $stob/$vecmod*sin($b*$theta);
	
	my $u1 = $a1*$coeff;
	my $u2 = $a2*$coeff;
	my $u3 = $a3*$coeff;


	return Math::Quaternion->new(
		$stob * cos($b*$theta), $u1,$u2,$u3
	);
	

}

=item B<negate>

Negates the given quaternion.

 my $q = Math::Quaternion->new(1,2,3,4);
 my $q1 = $q->negate;             # (-1,-2,-3,-4)

=cut

sub negate {

	my $q = shift;
	return  Math::Quaternion->new(
		-($q->[0]),
		-($q->[1]),
		-($q->[2]),
		-($q->[3]),
	);

}


=item B<squarednorm>

Returns the squared norm of its argument.

 my $q1 = Math::Quaternion->new(1,2,3,4);
 my $sn = $q1->squarednorm;             # 30

=cut

sub squarednorm {
	my $q = shift;
	return    $q->[0]*$q->[0] 
		+ $q->[1]*$q->[1] 
		+ $q->[2]*$q->[2] 
		+ $q->[3]*$q->[3];

}

=item B<scale>

Performs a scalar multiplication of its two arguments.

 my $q = Math::Quaternion->new(1,2,3,4);
 my $qq = Math::Quaternion::scale($q,2);   # ( 2 4 6 8)
 my $qqq= $q->scale(3);                    # ( 3 6 9 12 )

=cut

sub scale {
	my ($q,$s)=@_;
	return Math::Quaternion->new(
		$q->[0] * $s,
		$q->[1] * $s,
		$q->[2] * $s,
		$q->[3] * $s
	);
}

=item B<rotation>


Generates a quaternion corresponding to a rotation.

If given three arguments, interprets them as an angle and the
three components of an axis vector.

 use Math::Trig;            # Define pi.  my $theta = pi/2;
 # Angle of rotation my $rotquat =
 Math::Quaternion::rotation($theta,0,0,1);
 
 # $rotquat now represents a rotation of 90 degrees about Z axis.
 
 my ($x,$y,$z) = (1,0,0);	# Unit vector in the X direction.
 my ($xx,$yy,$zz) = $rotquat->rotate_vector($x,$y,$z);
 
 # ($xx,$yy,$zz) is now ( 0, 1, 0), to within floating-point error.


rotation() can also be passed a scalar angle and a reference to
a vector (in either order), and will generate the corresponding
rotation quaternion.

 my @axis = (0,0,1);    # Rotate about Z axis
 $theta = pi/2;
 $rotquat = Math::Quaternion::rotation($theta,\@axis);


If the arguments to rotation() are both references, they are
interpreted as two vectors, and a quaternion is returned which
rotates the first vector onto the second.

 my @startvec = (0,1,0);  # Vector pointing north
 my @endvec   = (-1,0,0); # Vector pointing west
 $rotquat = Math::Quaternion::rotation(\@startvec,\@endvec);
 
 my @newvec = $rotquat->rotate_vector(@startvec); # Same as @endvec

=cut

sub rotation {
	my ($theta,$x,$y,$z);
	if (2==@_) {
		if (ref($_[0])) {
			if (ref($_[1])) {
				# Both args references to vectors
				my ($ax,$ay,$az)=@{$_[0]};
				my ($bx,$by,$bz)=@{$_[1]};
				# Find cross product. This is a vector
				# perpendicular to both argument vectors,
				# and is therefore the axis of rotation.
				$x = $ay*$bz-$az*$by;
				$y = $az*$bx-$ax*$bz;
				$z = $ax*$by-$ay*$bx;
				# find the dot product.
				my $dotprod = $ax*$bx+$ay*$by+$az*$bz;
				my $mod1 = sqrt($ax*$ax+$ay*$ay+$az*$az);
				my $mod2 = sqrt($bx*$bx+$by*$by+$bz*$bz);
				# Find the angle of rotation.
				$theta=Math::Trig::acos($dotprod/($mod1*$mod2));
			} else {
				# 0 is a ref, 1 is not.
				$theta = $_[1];
				($x,$y,$z)=@{$_[0]};
			}
		} else {
			if (ref($_[1])) {
				# 1 is a ref, 0 is not
				$theta = $_[0];
				($x,$y,$z)=@{$_[1]};
			} else {
			 croak("Math::Quaternion::rotation() passed 2 nonref args");
			}

		}
		
	} elsif (4==@_) {
		($theta,$x,$y,$z) = @_;
	} else {
		croak("Math::Quaternion::rotation() passed wrong no of arguments");
	}

	my $modulus = sqrt($x*$x+$y*$y+$z*$z); # Make it a unit vector
	$x /= $modulus;
	$y /= $modulus;
	$z /= $modulus;

	my $st = sin(0.5 * $theta);
	my $ct = cos(0.5 * $theta);

	return Math::Quaternion->new(
		$ct, $x * $st, $y * $st, $z * $st
	);
}

=item B<rotation_angle>

Returns the angle of rotation represented by the quaternion
argument.

 my $q = Math::Quaternion::rotation(0.1,2,3,4);
 my $theta = $q->rotation_angle; # Returns 0.1 .

=cut

sub rotation_angle {
	my $q = shift;
	return 2.0 * Math::Trig::acos($q->[0]);
}

=item B<rotation_axis>

Returns the unit vector representing the axis about which
rotations will be performed, for the rotation represented by the
quaternion argument.

 my $q = Math::Quaternion::rotation(0.1,1,1,0);
 my @v = $q->rotation_axis; # Returns (0.5*sqrt(2),0.5*sqrt(2),0)

=cut

sub rotation_axis {
	my $q = shift;
	my $theta = Math::Trig::acos($q->[0]);
	my $st = sin($theta);
	if (0==$st) { return (0,0,1); } # Rotation of angle zero about Z axis
	my ($x,$y,$z) = @{$q}[1,2,3];

	return ( $x/$st, $y/$st, $z/$st );
}




=item B<rotate_vector>

When called as a method on a rotation quaternion, uses this
quaternion to perform the corresponding rotation on the vector
argument.

 use Math::Trig;                     # Define pi.
 
 my $theta = pi/2;                   # Rotate 90 degrees
 
 my $rotquat = Math::Quaternion::rotation($theta,0,0,1); # about Z axis
 
 my ($x,$y,$z) = (1,0,0);	# Unit vector in the X direction.
 my ($xx,$yy,$zz) = $rotquat->rotate_vector($x,$y,$z)
 
 # ($xx,$yy,$zz) is now ( 0, 1, 0), to within floating-point error.

=cut


sub rotate_vector {
	my ($q,$x,$y,$z) = @_;

	my $p = Math::Quaternion->new($x,$y,$z);
	my $qq = multiply($q,multiply($p,inverse($q)));
	return  @{$qq}[1,2,3];
}


=item B<matrix4x4>

Takes one argument: a rotation quaternion.
Returns a 16-element array, equal to the OpenGL
matrix which represents the corresponding rotation.

 my $rotquat = Math::Quaternion::rotation($theta,@axis); # My rotation.
 my @m = $rotquat->matrix4x4;

=cut

sub matrix4x4 {
	my $q = shift;
	my ($w,$x,$y,$z) = @{$q};

	return (
		1 - 2*$y*$y - 2*$z*$z,
		2*$x*$y + 2*$w*$z,
		2*$x*$z - 2*$w*$y,
		0,

		2*$x*$y - 2*$w*$z,
		1 - 2*$x*$x - 2*$z*$z,
		2*$y*$z + 2*$w*$x,
		0,

		2*$x*$z + 2*$w*$y,
		2*$y*$z - 2*$w*$x,
		1 - 2*$x*$x - 2*$y*$y,
		0,

		0,
		0,
		0,
		1
	);
}

=item B<matrix3x3>

Takes one argument: a rotation quaternion.
Returns a 9-element array, equal to the 3x3
matrix which represents the corresponding rotation.

 my $rotquat = Math::Quaternion::rotation($theta,@axis); # My rotation.
 my @m = $rotquat->matrix3x3;

=cut

sub matrix3x3 {
	my $q = shift;
	my ($w,$x,$y,$z) = @{$q};

	return (
		1 - 2*$y*$y - 2*$z*$z,
		2*$x*$y + 2*$w*$z,
		2*$x*$z - 2*$w*$y,

		2*$x*$y - 2*$w*$z,
		1 - 2*$x*$x - 2*$z*$z,
		2*$y*$z + 2*$w*$x,

		2*$x*$z + 2*$w*$y,
		2*$y*$z - 2*$w*$x,
		1 - 2*$x*$x - 2*$y*$y,
	);
}

=item B<matrix4x4andinverse>

Similar to matrix4x4, but returnes a list of two array
references.  The first is a reference to the rotation matrix;
the second is a reference to its inverse.  This may be useful
when rendering sprites, since you can multiply by the rotation
matrix for the viewer position, perform some translations, and
then multiply by the inverse: any resulting rectangles drawn
will always face the viewer.


 my $rotquat = Math::Quaternion::rotation($theta,@axis); # My rotation.
 my ($matref,$invref) = $rotquat->matrix4x4andinverse;

=cut


sub matrix4x4andinverse {
	my $q = shift;
	my ($w,$x,$y,$z) = @{$q};
	my (@m,@mi);

	$mi[ 0] = $m[ 0] = 1 - 2*$y*$y - 2*$z*$z;
	$mi[ 4] = $m[ 1] = 2*$x*$y + 2*$w*$z;
	$mi[ 8] = $m[ 2] = 2*$x*$z - 2*$w*$y;
	$mi[12] = $m[ 3] = 0;

	$mi[ 1] = $m[ 4] = 2*$x*$y - 2*$w*$z;
	$mi[ 5] = $m[ 5] = 1 - 2*$x*$x - 2*$z*$z;
	$mi[ 9] = $m[ 6] = 2*$y*$z + 2*$w*$x;
	$mi[13] = $m[ 7] = 0;

	$mi[ 2] = $m[ 8] = 2*$x*$z + 2*$w*$y;
	$mi[ 6] = $m[ 9] = 2*$y*$z - 2*$w*$x;
	$mi[10] = $m[10] = 1 - 2*$x*$x - 2*$y*$y;
	$mi[14] = $m[11] = 0;

	$mi[ 3] = $m[12] = 0;
	$mi[ 7] = $m[13] = 0;
	$mi[11] = $m[14] = 0;
	$mi[15] = $m[15] = 1;

	return (\@m,\@mi);

}

=item B<stringify>

Returns a string representation of the quaternion. This is used
to overload the '""' operator, so that quaternions may be
freely interpolated in strings.

 my $q = Math::Quaternion->new(1,2,3,4);
 print $q->stringify;                # "( 1 2 3 4 )"
 print "$q";                         # "( 1 2 3 4 )"


=cut

sub stringify {
	my $self = shift;
	return "( ".join(" ",@$self)." )";
}

=item B<slerp>

Takes two quaternion arguments and one scalar; performs
spherical linear interpolation between the two quaternions. The
quaternion arguments are assumed to be unit quaternions, and the
scalar is assumed to lie between 0 and 1: a scalar argument of
zero will return the first quaternion argument, and a scalar
argument of one will return the second.

 use Math::Trig;
 my @axis = (0,0,1);
 my $rq1 = Math::Quaternion::rotation(pi/2,\@axis);   # 90  degs about Z
 my $rq2 = Math::Quaternion::rotation(pi,\@axis);     # 180 degs about Z
 
 my $interp = Math::Quaternion::slerp($rq1,$rq2,0.5); # 135 degs about Z

=cut

sub slerp {
	my ($q0,$q1,$t) = @_;

	my $dotprod = dot($q0,$q1);
	if ($dotprod<0) {
		# Reverse signs so we travel the short way round
		$dotprod = -$dotprod;
		$q1 = negate($q1);
	}

	my $theta = Math::Trig::acos($dotprod);

	if (abs($theta) < 1e-5) {
		# In the limit theta->0 , spherical interpolation is
		# approximated by linear interpolation, which also
		# avoids division-by-zero problems.

		return plus(scale($q0,(1-$t)) ,scale($q1,$t));

	}

	my $st = sin($theta);
	my $ist = 1.0/$st;

	my $q = plus(
		scale($q0,($ist * sin( (1-$t)*$theta ))),
		scale($q1,($ist*sin($t*$theta)))
	);

	
	return normalize($q);

}


=item B<exp>

Exponential operator e^q. Any quaternion q can be written as x+uy,
where x is a real number, and u is a unit pure quaternion.  Then,
exp(q) == exp(x) * ( cos(y) + u sin(y) ).

 my $q = Math::Quaternion->new(1,2,3,4);
 print Math::Quaternion::exp($q);

=cut

sub exp {
	my $q = shift;

	if (isreal($q)) {
		return Math::Quaternion->new(CORE::exp($q->[0]),0,0,0);
	}

	my ($q0,$q1,$q2,$q3)=@$q;

	my $y = sqrt($q1*$q1+$q2*$q2+$q3*$q3); # Length of pure-quat part.
	my ($ux,$uy,$uz) = ($q1/$y,$q2/$y,$q3/$y); # Unit vector.

	my $ex = CORE::exp($q0);
	my $exs = $ex*sin($y);

	return Math::Quaternion->new($ex*cos($y),$exs*$ux,$exs*$uy,$exs*$uz);
}

=item B<log>

Returns the logarithm of its argument. The logarithm of a negative
real quaternion can take any value of them form (log(-q0),u*pi) for
any unit vector u. In these cases, u is chosen to be (1,0,0).

 my $q = Math::Quaternion->new(1,2,3,4);
 print Math::Quaternion::log($q);

=cut

sub log {
	my $q = shift;

	if (ref $q) {
		if ("Math::Quaternion" ne ref $q) {
			$q = Math::Quaternion->new($q);
		}
	} else {
		$q = Math::Quaternion->new($q);
	}

	if (isreal($q)) {
		if ($q->[0] > 0) {
			return Math::Quaternion->new(CORE::log($q->[0]));
		} else {
			return Math::Quaternion->new(CORE::log(-($q->[0])),pi,0,0);
		}
	}

	my ($q0,$q1,$q2,$q3)=@$q;

	my $modq = sqrt($q0*$q0 + $q1*$q1 + $q2*$q2 + $q3*$q3);

	my $x = CORE::log($modq);
	my $qquatmod = sqrt($q1*$q1+$q2*$q2+$q3*$q3); # mod of quat part
	my $y = atan2($qquatmod,$q0);
	my $c = $y/$qquatmod;

	return Math::Quaternion->new($x,$c*$q1,$c*$q2,$c*$q3);
	
}
*/

