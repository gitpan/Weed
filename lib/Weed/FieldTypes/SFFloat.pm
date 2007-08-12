package Weed::FieldTypes::SFFloat;

our $VERSION = '0.01';

use Weed 'SFFloat : SFDouble { 0 }';

use base 'Weed::BaseFieldTypes::Scalar';

sub toString { sprintf X3DGenerator->FLOAT, $_[0]->getValue }

1;
__END__
Data::Float 
