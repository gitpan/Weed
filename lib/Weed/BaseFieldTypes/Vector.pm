package Weed::BaseFieldTypes::Vector;
use Weed::Perl;

our $VERSION = '0.0082';

use base 'Weed::BaseFieldTypes::Scalar';

use overload
  '0+' => 'length',

  '~' => sub { ~$_[0]->getValue },

  '&' => sub { $_[2] ? $_[1] & $_[0]->getValue : $_[0]->getValue & $_[1] },
  '|' => sub { $_[2] ? $_[1] | $_[0]->getValue : $_[0]->getValue | $_[1] },
  '^' => sub { $_[2] ? $_[1] ^ $_[0]->getValue : $_[0]->getValue ^ $_[1] },

  'neg' => sub { -$_[0]->getValue },

  '.' => sub { $_[0]->getValue . $_[1] },
  'x' => sub { $_[2] ? $_[1] x $_[0]->getValue : $_[0]->getValue x $_[1] },

  '@{}' => sub { $_[0]->{array} },
  ;

use Weed::Tie::Value::Vector;
use Weed::FieldHelper;

sub new_from_definition {
	my $this = shift->X3DField::new_from_definition(@_);
	$this->{array} = new Weed::Tie::Value::Vector $this;
	return $this;
}

sub getInitialValue { $_[0]->getDefinition->getValue->getClone }

sub setValue {
	my $this   = shift;
	my $vector = $this->getValue;
	$vector->setValue( @_ ? Weed::FieldHelper::NumVal(scalar @$vector, @_) : $this->getDefaultValue );
	$this->X3DField::setValue($vector);
}

sub length { $_[0]->getValue->length }

sub toString { $_[0]->getValue->toString }

1;
__END__
