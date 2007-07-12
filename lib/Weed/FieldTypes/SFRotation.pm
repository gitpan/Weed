package Weed::FieldTypes::SFRotation;

our $VERSION = '0.008';

use Weed 'SFRotation : X3DField { 0 0 1 0 }';

use overload
  '~' => sub { $_[0]->new( ~$_[0]->getValue ) },

  '==' => sub { $_[0]->getValue == $_[1] },
  '!=' => sub { $_[0]->getValue != $_[1] },
  'eq' => sub { $_[0]->getValue eq $_[1] },
  'ne' => sub { $_[0]->getValue ne $_[1] },

  '*' => 'multiply',

  '@{}' => sub { $_[0]->{array} },
  ;

use Weed::Tie::RotationValue;
use Weed::FieldHelper;

sub new_from_definition {
	my $this = shift->X3DField::new_from_definition(@_);
	$this->{array} = [];
	tie @{ $this->{array} }, 'Weed::Tie::RotationValue', $this;
	return $this;
}

sub setValue {
	my $this   = shift;
	my $vector = $this->getValue;

	$vector->setValue( @_ ? Weed::FieldHelper::RotVal(@_) : $this->getDefaultValue );

	$this->X3DField::setValue($vector);
}

sub x : lvalue     { $_[0]->{array}->[0] }
sub y : lvalue     { $_[0]->{array}->[1] }
sub z : lvalue     { $_[0]->{array}->[2] }
sub angle : lvalue { $_[0]->{array}->[3] }

sub getAxis { new SFVec3d( $_[0]->getValue->getAxis ) }

sub inverse { }

sub multiply {
	my $r = $_[2] ? $_[1] * $_[0]->getValue : $_[0]->getValue * $_[1];
	return $r             if UNIVERSAL::isa( $r, ref $_[0] );
	return $_[0]->new($r) if UNIVERSAL::isa( $r, ref $_[0]->getValue );
	return new SFVec3d($r);
}

sub multVec { }

#sub setAxis  { shift->getValue->setAxis( Weed::FieldHelper::NumVal(@_) ) }

sub slerp { }

sub round { $_[0]->new( $_[0]->getValue->round( $_[1] ) ) }

sub toString { $_[0]->getValue->toString }

1;
__END__
