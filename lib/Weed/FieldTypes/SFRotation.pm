package Weed::FieldTypes::SFRotation;

our $VERSION = '0.012';

use Weed 'SFRotation : X3DField { 0 0 1 0 }';

use overload
  '~' => sub { ~$_[0]->getValue },

  '==' => sub { $_[0]->getValue == $_[1] },
  '!=' => sub { $_[0]->getValue != $_[1] },
  'eq' => sub { $_[0]->getValue eq $_[1] },
  'ne' => sub { $_[0]->getValue ne $_[1] },

  '*' => 'multiply',

  '@{}' => sub { $_[0]->{array} },
  ;

use Weed::Tie::Value::Rotation;
use Weed::FieldHelper;

sub create {
	my ($this) = @_;
	$this->{value} = $this->getInitialValue->getClone;
	$this->{array} = new Weed::Tie::Value::Rotation $this;
	return;
}

sub setValue {
	my $this   = shift;
	my $vector = $this->{value};

	$vector->setValue( @_ ? Weed::FieldHelper::RotVal(@_) : $this->getDefaultValue );

	$this->X3DField::setValue($vector);
}

sub x : lvalue     { $_[0]->{array}->[0] }
sub y : lvalue     { $_[0]->{array}->[1] }
sub z : lvalue     { $_[0]->{array}->[2] }
sub angle : lvalue { $_[0]->{array}->[3] }

sub getAxis { $_[0]->getValue->getAxis }

sub inverse { $_[0]->getValue->inverse }

sub multiply { $_[2] ? $_[1] * $_[0]->getValue : $_[0]->getValue * $_[1] }

sub multVec { }

#sub setAxis  { shift->getValue->setAxis( Weed::FieldHelper::NumVal(@_) ) }

sub slerp { }

sub round { $_[0]->getValue->round( $_[1] ) }

sub toString { $_[0]->getValue->toString }

1;
__END__
