package Weed::Values::Rotation;
use Weed::Perl;

our $VERSION = '0.0082';

use Package::Alias X3DRotation => __PACKAGE__;

use Math::Quaternion;
use Weed::Values::Vec3;

use Weed::Values::Tie::Rotation;

use overload
  '=' => 'getClone',

  'bool' => sub { abs( ${ $_[0] }->{quaternion}->[0] ) < 1 },    # ! $_[0]->{quaternion}->[0]->isreal

  '==' => sub { UNIVERSAL::isa( $_[1], ref $_[0] ) ?
	  ${ $_[0] }->{quaternion}->stringify eq ${ $_[1] }->{quaternion}->stringify :
	  $_[1] == $_[0]
  },

  '!=' => sub { UNIVERSAL::isa( $_[1], ref $_[0] ) ?
	  ${ $_[0] }->{quaternion}->stringify ne ${ $_[1] }->{quaternion}->stringify :
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

  '@{}' => sub { ${ $_[0] }->{array} },

  '""' => 'toString',
  ;

use constant getDefaultValue => [ 0, 0, 1, 0 ];

sub new {
	my $self = shift;
	my $type = ref($self) || $self;
	my $this = bless \{}, $type;

	$$this->{array} = [];
	tie @{ $$this->{array} }, 'Weed::Values::Tie::Rotation', $this;

	$this->setValue(@_);

	return $this;
}

sub new_from_quaternion { $_[0]->_new_from_quaternion( new Math::Quaternion( $_[1] ) ) }

sub _new_from_quaternion {
	my $type = ref( $_[0] ) || $_[0];
	my $this = bless \{}, $type;

	$this->_setQuaternion( $_[1] );

	return $this;
}

sub getClone {
	my $type = ref( $_[0] ) || $_[0];
	my $this = bless \{}, $type;

	$$this->{array} = [];
	tie @{ $$this->{array} }, 'Weed::Values::Tie::Rotation', $this;

	$$this->{rotation}   = [ @{ ${ $_[0] }->{rotation} } ];
	$$this->{quaternion} = new Math::Quaternion( ${ $_[0] }->{quaternion} );

	return $this;
}

sub setValue {
	my $this = shift;

	if ( 0 == @_ ) {
		# No arguments, default to standard rotation.
		$$this->{rotation} = [ 0, 0, 1, 0 ];
		$$this->{quaternion} = new Math::Quaternion();
	}
	elsif ( 1 == @_ ) {
		if ( UNIVERSAL::isa( $_[0], __PACKAGE__ ) ) {
			# (SELF)
			$$this->{rotation}   = [ @{ ${ $_[0] }->{rotation} } ];
			$$this->{quaternion} = new Math::Quaternion( ${ $_[0] }->{quaternion} );
		}
		elsif ( UNIVERSAL::isa( $_[0], 'ARRAY' ) ) {
			# [x,y,z,angle]
			$this->_setValue( $_[0] );
		}
		else {
			warn("Don't understand arguments passed to new()");
			return;
		}
	}
	elsif ( 2 == @_ ) {
		if ( UNIVERSAL::isa( $_[0], 'ARRAY' ) ) {
			if ( UNIVERSAL::isa( $_[1], 'ARRAY' ) ) {
				# ( vec1, vec2 )
				$this->_setQuaternion(
					eval { Math::Quaternion::rotation( $_[0], $_[1] ) }
					  || new Math::Quaternion()
				);
			} elsif ( !ref $_[1] ) {
				# ( vec, angle )
				$this->_setValue( [ @{ $_[0] }, $_[1] ] );
			}
			else {
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
		$this->_setValue( [@_] )
	}
	else {
		warn("Don't understand arguments passed to new()");
		return;
	}

	return;
}

# ($this, $rotation)
sub _setValue {
	if ( $_[1]->[0] && $_[1]->[1] && $_[1]->[2] ) {
		${ $_[0] }->{rotation} = $_[1];
		${ $_[0] }->{quaternion} = Math::Quaternion::rotation( @{ $_[1] }[ 3, 0, 1, 2 ] );
	}
	else {
		${ $_[0] }->{rotation} = [ 0, 0, 1, 0 ];
		${ $_[0] }->{quaternion} = new Math::Quaternion();
	}
	return;
}

sub setX {
	${ $_[0] }->{rotation}->[0] = $_[1];
	${ $_[0] }->{quaternion} = Math::Quaternion::rotation( @{ ${ $_[0] }->{rotation} }[ 3, 0, 1, 2 ] );
	return;
}

sub setY {
	${ $_[0] }->{rotation}->[1] = $_[1];
	${ $_[0] }->{quaternion} = Math::Quaternion::rotation( @{ ${ $_[0] }->{rotation} }[ 3, 0, 1, 2 ] );
	return;
}

sub setZ {
	${ $_[0] }->{rotation}->[2] = $_[1];
	${ $_[0] }->{quaternion} = Math::Quaternion::rotation( @{ ${ $_[0] }->{rotation} }[ 3, 0, 1, 2 ] );
	return;
}

sub setAxis {
	@{ ${ $_[0] }->{rotation} }[ 0, 1, 2 ] = @{ $_[1] };
	${ $_[0] }->{quaternion} = Math::Quaternion::rotation( ${ $_[0] }->{rotation}->[3], $_[1] );
	return;
}

sub setAngle {
	${ $_[0] }->{rotation}->[3] = $_[1];
	${ $_[0] }->{quaternion} = Math::Quaternion::rotation( @{ ${ $_[0] }->{rotation} }[ 3, 0, 1, 2 ] );
	return;
}

sub setQuaternion {
	$_[0]->_setQuaternion( eval { new Math::Quaternion( $_[1] ) } || new Math::Quaternion() );
	return;
}

sub _setQuaternion {
	${ $_[0] }->{quaternion} = $_[1];
	${ $_[0] }->{rotation} = [ $_[1]->rotation_axis, $_[1]->rotation_angle ];
	return;
}

sub getValue {
	return [ @{ ${ $_[0] }->{rotation} } ];
}

sub getX { ${ $_[0] }->{rotation}->[0] }

sub getY { ${ $_[0] }->{rotation}->[1] }

sub getZ { ${ $_[0] }->{rotation}->[2] }

sub getAxis { new X3DVec3 [ @{ ${ $_[0] }->{rotation} }[ 0, 1, 2 ] ] }

sub getAngle { ${ $_[0] }->{rotation}->[3] }

sub getQuaternion { new Math::Quaternion( ${ $_[0] }->{quaternion} ) }

sub x : lvalue     { ${ $_[0] }->{array}->[0] }
sub y : lvalue     { ${ $_[0] }->{array}->[1] }
sub z : lvalue     { ${ $_[0] }->{array}->[2] }
sub angle : lvalue { ${ $_[0] }->{array}->[3] }

sub inverse { $_[0]->_new_from_quaternion( ${ $_[0] }->{quaternion}->inverse ) }

sub multiply { $_[0]->_new_from_quaternion( ${ $_[1] }->{quaternion}->multiply( ${ $_[0] }->{quaternion} ) ) }

sub multVec { new X3DVec3( [ ${ $_[0] }->{quaternion}->rotate_vector( @{ $_[1] } ) ] ) }

sub slerp { $_[0]->_new_from_quaternion( ${ $_[0] }->{quaternion}->slerp( ${ $_[1] }->{quaternion}, $_[2] ) ) }

sub normalize { $_[0]->_new_from_quaternion( ${ $_[0] }->{quaternion} ) }

sub round {
	my ( $this, $digits ) = @_;
	my $rounded = $this->getClone;
	@{ ${$rounded}->{rotation} }   = map { X3DMath::round( $_, $digits ) } @{ ${$rounded}->{rotation} };
	@{ ${$rounded}->{quaternion} } = map { X3DMath::round( $_, $digits ) } @{ ${$rounded}->{quaternion} };
	return $rounded;
}

use constant elementCount => 4;

sub clear { $_[0]->setValue() }

sub toString { join " ", @{ ${ $_[0] }->{rotation} }[ 0, 1, 2, 3 ] }

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

