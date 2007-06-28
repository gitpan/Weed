package Weed::FieldTypes::BaseFieldTypes::SFVector;
use Weed::Perl;

use Weed::FieldHelper;
use UNIVERSAL 'isa';

use overload
  '0+' => 'length',

  'neg' => sub { $_[0]->new( -( 0 + $_[0]->getValue ) ) },

  '+' => sub { $_[0]->new( $_[0]->getValue + $_[1] ) },
  '-' => sub { $_[0]->new( $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] ) },

  '*' => sub { $_[0]->new( $_[0]->getValue * $_[1] ) },
  '/' => sub { $_[0]->new( $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] ) },
  '%' => sub { $_[0]->new( $_[2] ? $_[1] % $_[0]->getValue : $_[0]->getValue % $_[1] ) },

  '**' => sub { $_[0]->new( $_[2] ? $_[1]**$_[0]->getValue : $_[0]->getValue**$_[1] ) },
  ;

sub setValue {
	my $this = shift;

	my $vector = $this->getValue;
	$vector = ref( $this->getInitialValue )->new unless ref $vector;

	$vector->setValue( Weed::FieldHelper::NumVal(@_) );
	return $this->X3DField::setValue($vector);
}

sub length { $_[0]->getValue->length }

sub toString {
	return $_[0]->getValue->toString;
}

1;
__END__
