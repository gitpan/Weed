package VRML2::Event::eventOut;
use strict;

BEGIN {
	use Carp;

	use VRML2::Event;
	use VRML2::FieldTypes;

	use VRML2::Generator;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Event);
}

use overload
	'""'   => \&toString;

sub setValue {
	my $this = shift;
	my $value = shift;
	$this->{value} = ref $value ? $value : $this->newValue;
}

sub newValue {
	my $this = shift;

	my $fieldType = $this->{type};

	if ( index($fieldType, 'SF') == 0 ) {
		return new SFBool	  if $fieldType eq 'SFBool';
		return new SFColor    if $fieldType eq 'SFColor';
		return new SFFloat    if $fieldType eq 'SFFloat';
		return new SFImage    if $fieldType eq 'SFImage';
		return new SFInt32    if $fieldType eq 'SFInt32';
		return new SFNode	  if $fieldType eq 'SFNode';
		return new SFRotation if $fieldType eq 'SFRotation';
		return new SFString   if $fieldType eq 'SFString';
		return new SFTime	  if $fieldType eq 'SFTime';
		return new SFVec2f    if $fieldType eq 'SFVec2f';
		return new SFVec3f    if $fieldType eq 'SFVec3f';
	} else {
		return new MFColor    if $fieldType eq 'MFColor';
		return new MFFloat    if $fieldType eq 'MFFloat';
		return new MFInt32    if $fieldType eq 'MFInt32';
		return new MFNode	  if $fieldType eq 'MFNode';
		return new MFRotation if $fieldType eq 'MFRotation';
		return new MFString   if $fieldType eq 'MFString';
		return new MFTime	  if $fieldType eq 'MFTime';
		return new MFVec2f    if $fieldType eq 'MFVec2f';
		return new MFVec3f    if $fieldType eq 'MFVec3f';
	}

	return new SFEnum if $fieldType eq 'SFEnum';
	return new MFEnum if $fieldType eq 'MFEnum';
}

sub toString {
	my $this = shift;
	my $string = $this->SUPER::toString;

	unless ($string) {
		my $space1 = $TSPACE x 4;
		my $space2 = -8 * length $TSPACE;
	
		$string =  sprintf "eventOut $space1%".$space2."s %s",
			$this->{type},
			$this->{name};
	}

	return $string;
}

1;
__END__
