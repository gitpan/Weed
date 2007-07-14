package Weed::FieldTypes::SFString;

our $VERSION = '0.0079';

use Weed 'SFString : X3DField { "" }';

use base 'Weed::BaseFieldTypes::Scalar';

use Unicode::String;
#Text::Unidecode;
use overload
#  '0+' => 'length',
  '~' => sub { ~$_[0]->getValue },
 ;


sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( defined $value ? "$value" : $this->getDefaultValue );
}

sub toString { sprintf "%s", $_[0]->getValue }

1;
__END__

