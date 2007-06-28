package Weed::FieldTypes::SFFloat;

use Weed 'SFFloat : SFDouble { 0 }';

sub toString {
	return sprintf X3DGenerator->FLOAT, $_[0]->getValue;
}

1;
__END__
