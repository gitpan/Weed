package Weed::FieldTypes::BaseFieldTypes::SFVector;
use Weed::Perl;

use base 'Weed::FieldTypes::BaseFieldTypes::SFNumber';

use Weed::FieldHelper;

use overload
  '0+' => 'length',

  '~' => sub { $_[0]->new( ~$_[0]->getValue ) },

  '&' => sub { $_[0]->new( $_[2] ? $_[1] & $_[0]->getValue : $_[0]->getValue & $_[1] ) },
  '|' => sub { $_[0]->new( $_[2] ? $_[1] | $_[0]->getValue : $_[0]->getValue | $_[1] ) },
  '^' => sub { $_[0]->new( $_[2] ? $_[1] ^ $_[0]->getValue : $_[0]->getValue ^ $_[1] ) },

  '<<' => sub { $_[0]->new( $_[2] ? $_[1] << $_[0]->getValue : $_[0]->getValue << $_[1] ) },
  '>>' => sub { $_[0]->new( $_[2] ? $_[1] >> $_[0]->getValue : $_[0]->getValue >> $_[1] ) },

  'neg' => sub { $_[0]->new( -( 0 + $_[0]->getValue ) ) },

  '+' => sub { $_[0]->new( $_[0]->getValue + $_[1] ) },
  '-' => sub { $_[0]->new( $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] ) },

  '*' => sub { $_[0]->new( $_[0]->getValue * $_[1] ) },
  '/' => sub { $_[0]->new( $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] ) },
  '%' => sub { $_[0]->new( $_[2] ? $_[1] % $_[0]->getValue : $_[0]->getValue % $_[1] ) },

  '**' => sub { $_[0]->new( $_[2] ? $_[1]**$_[0]->getValue : $_[0]->getValue**$_[1] ) },

  'int'  => sub { $_[0]->new( int $_[0]->getValue ) },
  'cos'  => sub { $_[0]->new( cos $_[0]->getValue ) },
  'sin'  => sub { $_[0]->new( sin $_[0]->getValue ) },
  'exp'  => sub { $_[0]->new( exp $_[0]->getValue ) },
  'abs'  => sub { $_[0]->new( abs $_[0]->getValue ) },
  'log'  => sub { $_[0]->new( log $_[0]->getValue ) },
  'sqrt' => sub { $_[0]->new( sqrt $_[0]->getValue ) },

  '@{}' => sub { $_[0]->getValue },
  ;

use Weed::Tie::VectorValue;

sub new_from_definition {
	my $this = shift->X3DField::new_from_definition(@_);
	tie @{ $this->getValue }, 'Weed::Tie::VectorValue', $this;
	return $this;
}

sub setValue {
	my $this   = shift;
	my $vector = $this->getValue;
	$vector->setValue( Weed::FieldHelper::NumVal(@_) );
	$this->X3DField::setValue($vector);
}

sub length { $_[0]->getValue->length }

sub toString {
	return $_[0]->getValue->toString;
}

1;
__END__
