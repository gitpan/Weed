package Weed::FieldTypes::SFVec4d;

use Weed 'SFVec4d : X3DField { 0 0 0 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::SFVector';

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

sub z : lvalue { $_[0]->[2] }

sub w : lvalue { $_[0]->[3] }

1;
__END__
