package Weed::FieldTypes::SFColor;

use Weed 'SFColor : X3DField { 0 0 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFVector';

sub r : lvalue { $_[0]->[0] }

sub g : lvalue { $_[0]->[1] }

sub b : lvalue { $_[0]->[2] }

1;
__END__
