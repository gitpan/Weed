package Weed::Values::Rotation;
use Weed::Perl;

use Weed::Values::Vec3;
use Math::Quaternion;

use overload
  '=' => 'getClone',

  '~' => 'inverse',

  'bool' => sub { abs( $_[0]->{quaternion}->[0] ) < 1 },    # ! $_[0]->{quaternion}->[0]->isreal

  '==' => sub { "$_[0]" eq $_[1] },
  '!=' => sub { "$_[0]" ne $_[1] },
  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },

  '*' => 'multVec',

  '""' => 'toString',
  ;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	$this->{axis} = [];

	if ( 0 == @_ ) {
		# No arguments, default to standard rotation.
		@{ $this->{axis} } = ( 0, 0, 1 );
		$this->{angle}      = 0;
		$this->{quaternion} = new Math::Quaternion();
	}
	elsif ( 1 == @_ ) {

		my $arg = shift;

		if ( 'ARRAY' eq ref $arg ) {

			$this->setValue(@$arg);

		}
		elsif ( UNIVERSAL::isa( $arg, __PACKAGE__ ) ) {

			$this->setQuaternion( $arg->{quaternion} );

		}
	}
	elsif ( 2 == @_ ) {

		my $arg1    = shift;
		my $reftype = Scalar::Util::reftype($arg1);

		if ( $reftype eq 'ARRAY' ) {
			my $arg2    = shift;
			my $reftype = Scalar::Util::reftype($arg2);

			if ( !$reftype ) {    # vec1, angle

				$this->setValue( @$arg1, $arg2 );

			} elsif ( $reftype eq 'ARRAY' ) {    # vec1, vec2
				$this->private::setQuaternion( eval { Math::Quaternion::rotation( $arg1, $arg2 ) }
					  || new Math::Quaternion() );
			} else {
				warn("Don't understand arguments passed to new()");
				return;
			}
		}
		else {
			warn("Don't understand arguments passed to new()");
			return;
		}
	}
	elsif ( 4 == @_ ) {    # x,y,z,angle
		$this->setValue(@_);
	}
	else {
		warn("Don't understand arguments passed to new()");
		return;
	}

	return $this;
}

sub new_from_quaternion {
	return $_[0]->private::new_from_quaternion( new Math::Quaternion( $_[1] ) );
}

sub private::new_from_quaternion {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	$this->private::setQuaternion(shift);

	return $this;
}

sub getClone {
	my $this = shift;
	return $this->private::new_from_quaternion( $this->{quaternion} );
}

sub setValue {
	my $this = shift;
	if ( $_[0] && $_[1] && $_[2] ) {
		$this->private::setQuaternion( Math::Quaternion::rotation( [ @_[ 0, 1, 2 ] ], $_[3] ) );
	}
	else {
		@{ $this->{axis} } = ( 0, 0, 1 );
		$this->{angle}      = 0;
		$this->{quaternion} = new Math::Quaternion();
	}
}

sub setX {
	my $this = shift;
	$this->{axis}->[0] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
}

sub setY {
	my $this = shift;
	$this->{axis}->[1] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
}

sub setZ {
	my $this = shift;
	$this->{axis}->[2] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
}

sub setAxis {
	my $this = shift;
	@{ $this->{axis} } = @{ $_[0] };
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
}

sub setAngle {
	my $this = shift;
	$this->{angle} = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
}

sub setQuaternion {
	my $this = shift;
	$this->private::setQuaternion( eval { new Math::Quaternion(shift) } || new Math::Quaternion() );
}

sub private::setQuaternion {
	my $this = shift;
	my $q    = shift;
	$this->{quaternion} = $q;
	@{ $this->{axis} } = $q->rotation_axis;
	$this->{angle} = $q->rotation_angle;
}

sub getValue {
	my $this = shift;

	#$this->private::setQuaternion( $this->{quaternion} );

	return [
		$this->getAxis,
		$this->getAngle
	];
}

sub getX { $_[0]->{axis}->[0] }

sub getY { $_[0]->{axis}->[1] }

sub getZ { $_[0]->{axis}->[2] }

sub getAxis { wantarray ? @{ $_[0]->{axis} } : new Weed::Values::Vec3 [ @{ $_[0]->{axis} } ] }

sub getAngle { $_[0]->{angle} }

sub getQuaternion { new Math::Quaternion( $_[0]->{quaternion} ) }
#Returns a copy, weil $_[0]->{quaternion} kann sich ändern

# (1,2,3, 4) -> (1,2,3, -4)
sub inverse { $_[0]->private::new_from_quaternion( $_[0]->{quaternion}->inverse ) }

sub multiply { $_[0]->private::new_from_quaternion( $_[1]->{quaternion}->multiply( $_[0]->{quaternion} ) ) }

sub multVec {
	my $this = shift;
	if ( @_ < 3 ) {
		my $ref = ref( $_[0] );
		if ( $ref eq 'ARRAY' || $ref->isa("Weed::Values::Vec3") ) {
			my @v = $this->{quaternion}->rotate_vector( @{ $_[0] } );
			return ref( $_[0] ) eq "ARRAY" ? [@v] : $_[0]->new(@v);
		}
		else {
			return $this->multiply( $_[0] );
		}
	}
	elsif ( @_ < 4 ) {
		return $this->{quaternion}->rotate_vector(@_);
	}
	else {
		return $this->multiply( $this->new(@_) );
	}
}

sub slerp { $_[0]->private::new_from_quaternion( $_[0]->{quaternion}->slerp( $_[1]->{quaternion}, $_[2] ) ) }

sub toString {
	my $this = shift;
	return join " ", @{ $this->getValue };
}

1;
