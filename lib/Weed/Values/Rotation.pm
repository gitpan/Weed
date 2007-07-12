package Weed::Values::Rotation;
use Weed::Perl;

our $VERSION = '0.008';

use Weed::Values::Vec3;
use Math::Quaternion;

use overload
  '=' => 'getClone',

  'bool' => sub { abs( $_[0]->{quaternion}->[0] ) < 1 },    # ! $_[0]->{quaternion}->[0]->isreal

  '~' => 'inverse',

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

  '""' => 'toString',
  ;

use constant getDefaultValue => [ 0, 0, 1, 0 ];

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	$this->{axis}  = [];
	$this->{angle} = 0;

	$this->setValue(@_);

	return $this;
}

sub new_from_quaternion {
	return $_[0]->_new_from_quaternion( new Math::Quaternion( $_[1] ) );
}

sub _new_from_quaternion {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless {}, $class;

	$this->_setQuaternion(shift);

	return $this;
}

sub getClone { $_[0]->new( $_[0] ) }

sub setValue {
	my $this = shift;
	if ( 0 == @_ ) {
		# No arguments, default to standard rotation.
		$this->{axis}       = [ 0, 0, 1 ];
		$this->{angle}      = 0;
		$this->{quaternion} = new Math::Quaternion();
	}
	elsif ( 1 == @_ ) {
		my $arg = shift;

		if ( 'ARRAY' eq ref $arg ) {
			$this->_setValue( [ @$arg[ 0, 1, 2 ] ], $arg->[3] )
		}
		elsif ( UNIVERSAL::isa( $arg, __PACKAGE__ ) ) {
			$this->{axis}       = [ @{ $arg->{axis} } ];
			$this->{angle}      = $arg->{angle};
			$this->{quaternion} = new Math::Quaternion( $arg->{quaternion} );
		}
	}
	elsif ( 2 == @_ ) {
		my $arg1 = shift;

		if ( UNIVERSAL::isa( $arg1, 'ARRAY' ) ) {

			my $arg2 = shift;

			if ( !ref $arg2 ) {    # vec1, angle
				$this->_setValue( $arg1, $arg2 );
			}
			elsif ( UNIVERSAL::isa( $arg2, 'ARRAY' ) ) {    # vec1, vec2
				$this->_setQuaternion(
					eval { Math::Quaternion::rotation( $arg1, $arg2 ) }
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
	elsif ( 4 == @_ ) {    # x,y,z,angle

		$this->_setValue( [ @_[ 0, 1, 2 ] ], $_[3] )
	}
	else {
		warn("Don't understand arguments passed to new()");
		return;
	}

}

sub _setValue {
	my ( $this, $axis, $angle ) = @_;

	if ( $axis->[0] && $axis->[1] && $axis->[2] ) {
		$this->{axis}       = $axis;
		$this->{angle}      = $angle;
		$this->{quaternion} = Math::Quaternion::rotation( $axis, $angle );
	}
	else {
		$this->{axis}       = [ 0, 0, 1 ];
		$this->{angle}      = 0;
		$this->{quaternion} = new Math::Quaternion();
	}
	return;
}

sub setX {
	my $this = shift;
	$this->{axis}->[0] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
	return;
}

sub setY {
	my $this = shift;
	$this->{axis}->[1] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
	return;
}

sub setZ {
	my $this = shift;
	$this->{axis}->[2] = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
	return;
}

sub setAxis {
	my $this = shift;
	$this->{axis} = $_[0];
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
	return;
}

sub setAngle {
	my $this = shift;
	$this->{angle} = shift;
	$this->{quaternion} = Math::Quaternion::rotation( $this->{angle}, $this->{axis} );
	return;
}

sub setQuaternion {
	my $this = shift;
	$this->_setQuaternion( eval { new Math::Quaternion(shift) } || new Math::Quaternion() );
	return;
}

sub _setQuaternion {
	my $this = shift;
	my $q    = shift;
	$this->{quaternion} = $q;
	$this->{axis}       = [ $q->rotation_axis ];
	$this->{angle}      = $q->rotation_angle;
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

sub getAxis { [ @{ $_[0]->{axis} } ] }

sub getAngle { $_[0]->{angle} }

sub getQuaternion { new Math::Quaternion( $_[0]->{quaternion} ) }
#Returns a copy, weil $_[0]->{quaternion} kann sich ändern

# (1,2,3, 4) -> (1,2,3, -4)
sub inverse { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->inverse ) }

use overload '*' => sub {
	my ( $a, $b, $r ) = @_;

	if ( UNIVERSAL::isa( $b, 'ARRAY' ) ) {
		return $a->multVec($b);
	}

	if ( UNIVERSAL::isa( $b, ref $a ) ) {
		return $r ? $b->multiply($a) : $a->multiply($b);
	}

	return $b->multiply( $a, 1 );

};

sub multiply { $_[0]->_new_from_quaternion( $_[1]->{quaternion}->multiply( $_[0]->{quaternion} ) ) }

sub multVec { new Weed::Values::Vec3( $_[0]->{quaternion}->rotate_vector( @{ $_[1] } ) ) }

sub slerp { $_[0]->_new_from_quaternion( $_[0]->{quaternion}->slerp( $_[1]->{quaternion}, $_[2] ) ) }

sub round {
	my ( $this, $digits ) = @_;
	my $rounded = $this->getClone;
	@{ $rounded->{axis} } = map { Math::round( $_, $digits ) } @{ $rounded->{axis} };
	$rounded->{angle} = Math::round( $rounded->{angle}, $digits );
	@{ $rounded->{quaternion} } = map { Math::round( $_, $digits ) } @{ $rounded->{quaternion} };
	return $rounded;
}

sub elementCount () { 4 }

sub clear { $_[0]->setValue() }

sub toString { join " ", @{ $_[0]->{axis} }, $_[0]->{angle} }

1;
