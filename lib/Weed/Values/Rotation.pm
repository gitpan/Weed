package Weed::Values::Rotation;
use Weed::Perl;

our $VERSION = '0.0081';

use Package::Alias X3DRotation => __PACKAGE__;

use Math::Quaternion;
use Weed::Values::Vec3;

use overload
  '=' => 'getClone',

  'bool' => sub { abs( $_[0]->{quaternion}->[0] ) < 1 },    # ! $_[0]->{quaternion}->[0]->isreal

  '==' => sub { UNIVERSAL::isa( $_[1], ref $_[0] ) ?
	  "$_[0]->{quaternion}" eq "$_[1]->{quaternion}" :
	  $_[1] == $_[0]
  },

  '!=' => sub { UNIVERSAL::isa( $_[1], ref $_[0] ) ?
	  "$_[0]->{quaternion}" ne "$_[1]->{quaternion}" :
	  $_[1] != $_[0]
  },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },

  '~' => 'inverse',

  '*' => sub {
	my ( $a, $b, $r ) = @_;

	if ( UNIVERSAL::isa( $b, 'ARRAY' ) ) {
		return $a->multVec($b);
	}

	if ( UNIVERSAL::isa( $b, ref $a ) ) {
		return $r ? $b->multiply($a) : $a->multiply($b);
	}

	return $b->multiply( $a, 1 );
  },

  '""' => 'toString',
  ;

use constant getDefaultValue => [ 0, 0, 1, 0 ];

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	$this->setValue(@_);

	return $this;
}

sub new_from_quaternion { $_[0]->_new_from_quaternion( new Math::Quaternion( $_[1] ) ) }

sub _new_from_quaternion {
	my $class = ref( $_[0] ) || $_[0];
	my $this = bless {}, $class;

	$this->_setQuaternion( $_[1] );

	return $this;
}

sub getClone {
	my $class = ref( $_[0] ) || $_[0];
	my $this = bless {}, $class;

	$this->{axis}       = [ @{ $_[0]->{axis} } ];
	$this->{angle}      = $_[0]->{angle};
	$this->{quaternion} = new Math::Quaternion( $_[0]->{quaternion} );

	return $this;
}

sub setValue {
	my $this = shift;

	if ( 0 == @_ ) {
		# No arguments, default to standard rotation.
		$this->{axis}       = [ 0, 0, 1 ];
		$this->{angle}      = 0;
		$this->{quaternion} = new Math::Quaternion();
	}
	elsif ( 1 == @_ ) {
		if ( UNIVERSAL::isa( $_[0], __PACKAGE__ ) ) {
			# (SELF)
			$this->{axis}       = [ @{ $_[0]->{axis} } ];
			$this->{angle}      = $_[0]->{angle};
			$this->{quaternion} = new Math::Quaternion( $_[0]->{quaternion} );
		}
		elsif ( UNIVERSAL::isa( $_[0], 'ARRAY' ) ) {
			# [...]
			$this->setValue( @{ $_[0] } );
		}
		else {
			warn("Don't understand arguments passed to new()");
			return;
		}
	}
	elsif ( 2 == @_ ) {
		if ( UNIVERSAL::isa( $_[0], 'ARRAY' ) ) {
			if ( !ref $_[1] ) {
				# ( vec, angle )
				$this->_setValue( $_[0], $_[1] );
			}
			elsif ( UNIVERSAL::isa( $_[1], 'ARRAY' ) ) {
				# ( vec1, vec2 )
				$this->_setQuaternion(
					eval { Math::Quaternion::rotation( $_[0], $_[1] ) }
					  || new Math::Quaternion()
				);
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
	elsif ( 4 == @_ ) {
		# ( x, y, z, angle)
		$this->_setValue( [ @_[ 0, 1, 2 ] ], $_[3] )
	}
	else {
		warn("Don't understand arguments passed to new()");
		return;
	}

	return;
}

# ($this, $axis, $angle)
sub _setValue {
	if ( $_[1]->[0] && $_[1]->[1] && $_[1]->[2] ) {
		$_[0]->{axis}       = $_[1];
		$_[0]->{angle}      = $_[2];
		$_[0]->{quaternion} = Math::Quaternion::rotation( $_[1], $_[2] );
	}
	else {
		$_[0]->{axis}       = [ 0, 0, 1 ];
		$_[0]->{angle}      = 0;
		$_[0]->{quaternion} = new Math::Quaternion();
	}
	return;
}

sub setX {
	$_[0]->{axis}->[0] = $_[1];
	$_[0]->{quaternion} = Math::Quaternion::rotation( $_[0]->{angle}, $_[0]->{axis} );
	return;
}

sub setY {
	$_[0]->{axis}->[1] = $_[1];
	$_[0]->{quaternion} = Math::Quaternion::rotation( $_[0]->{angle}, $_[0]->{axis} );
	return;
}

sub setZ {
	$_[0]->{axis}->[2] = $_[1];
	$_[0]->{quaternion} = Math::Quaternion::rotation( $_[0]->{angle}, $_[0]->{axis} );
	return;
}

sub setAxis {
	$_[0]->{axis} = $_[1];
	$_[0]->{quaternion} = Math::Quaternion::rotation( $_[0]->{angle}, $_[1] );
	return;
}

sub setAngle {
	$_[0]->{angle} = $_[1];
	$_[0]->{quaternion} = Math::Quaternion::rotation( $_[1], $_[0]->{axis} );
	return;
}

sub setQuaternion {
	$_[0]->_setQuaternion( eval { new Math::Quaternion( $_[1] ) } || new Math::Quaternion() );
	return;
}

sub _setQuaternion {
	$_[0]->{quaternion} = $_[1];
	$_[0]->{axis}       = [ $_[1]->rotation_axis ];
	$_[0]->{angle}      = $_[1]->rotation_angle;
	return;
}

sub getValue {
	return [
		@{ $_[0]->{axis} },
		$_[0]->{angle}
	];
}

sub getX { $_[0]->{axis}->[0] }

sub getY { $_[0]->{axis}->[1] }

sub getZ { $_[0]->{axis}->[2] }

sub getAxis { new X3DVec3 [ @{ $_[0]->{axis} } ] }

sub getAngle { $_[0]->{angle} }

sub getQuaternion { new Math::Quaternion( $_[0]->{quaternion} ) }

sub inverse { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->inverse ) }

sub multiply { $_[0]->_new_from_quaternion( $_[1]->{quaternion}->multiply( $_[0]->{quaternion} ) ) }

sub multVec { new X3DVec3( [ $_[0]->{quaternion}->rotate_vector( @{ $_[1] } ) ] ) }

sub slerp { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->slerp( $_[1]->{quaternion}, $_[2] ) ) }

sub normalize { $_[0]->_new_from_quaternion( $_[0]->{quaternion} ) }

sub round {
	my ( $this, $digits ) = @_;
	my $rounded = $this->getClone;
	@{ $rounded->{axis} } = map { X3DMath::round( $_, $digits ) } @{ $rounded->{axis} };
	$rounded->{angle} = X3DMath::round( $rounded->{angle}, $digits );
	@{ $rounded->{quaternion} } = map { X3DMath::round( $_, $digits ) } @{ $rounded->{quaternion} };
	return $rounded;
}

use constant elementCount => 4;

sub clear { $_[0]->setValue() }

sub toString { join " ", @{ $_[0]->{axis} }, $_[0]->{angle} }

1;
__END__

  #'neg' => sub { $_[0]->_new_from_quaternion( -$_[0]->{quaternion} ) },

  #'+' => sub { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->plus( $_[1]->{quaternion} ) ) },
  #'-' => sub { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->minus( $_[1]->{quaternion}, $_[2] ) ) },
  #'.' => sub { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->dot( $_[1]->{quaternion} ) ) },

  #'**' => sub { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->power( $_[1]->{quaternion}, $_[2] ) ) },

  #'abs' => sub { $_[0]->_new_from_quaternion( abs $_[0]->{quaternion} ) },
  #'exp' => sub { $_[0]->_new_from_quaternion( exp $_[0]->{quaternion} ) },
  #'log' => sub { $_[0]->_new_from_quaternion( log $_[0]->{quaternion} ) },

