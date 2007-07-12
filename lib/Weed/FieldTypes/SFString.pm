package Weed::FieldTypes::SFString;

our $VERSION = '0.0078';

use Weed 'SFString : X3DField { "" }';

use Unicode::String;
#Text::Unidecode;

use overload
  'int' => sub { length $_[0]->getValue },
  '0+'  => sub { length $_[0]->getValue },
  ;

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( defined $value ? "$value" : $this->getDefaultValue );
}

sub toString { sprintf "%s", $_[0]->getValue }

1;
__END__

