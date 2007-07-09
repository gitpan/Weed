package Weed::FieldTypes::SFVec2d;

use Weed 'SFVec2d : X3DField { 0 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFVector';

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

1;
__END__
