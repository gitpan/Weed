package Weed::FieldTypes::SFString;

use Weed 'SFString : X3DField { "" }';

use Unicode::String;

use overload
  'int' => sub { length $_[0]->getValue },
  '0+'  => sub { length $_[0]->getValue },
;

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue("$value");
}

sub toString { sprintf "%s", $_[0]->getValue }

1;
__END__

