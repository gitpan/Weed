package Weed::FieldTypes::SFVec2d;

our $VERSION = '0.0078';

use Weed 'SFVec2d : X3DField { 0 0 }';

use base 'Weed::FieldTypes::BaseFieldTypes::Vector';

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

1;
__END__
