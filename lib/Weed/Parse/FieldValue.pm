package Weed::Parse::FieldValue;
use Weed;

use Weed::RegularExpressions;

use Weed::Parse::String 'string';
use Weed::Parse::Double 'double';

sub parse {
	my ( $fieldType, $string ) = @_;
	return &fieldValue( $fieldType, \$string );
}

sub fieldValue {
	my ( $fieldType, $string ) = @_;

	if ( index( $fieldType, 'SF' ) == 0 ) {
		return &sfboolValue($string)      if $fieldType eq 'SFBool';
		return &sfcolorValue($string)     if $fieldType eq 'SFColor';
		return &sfcolorRGBAValue($string) if $fieldType eq 'SFColorRGBA';
		return &sfdoubleValue($string)    if $fieldType eq 'SFDouble';
		return &sffloatValue($string)     if $fieldType eq 'SFFloat';
		return &sfimageValue($string)     if $fieldType eq 'SFImage';
		return &sfint32Value($string)     if $fieldType eq 'SFInt32';
		return &null($string)             if $fieldType eq 'SFNode';
		return &sfrotationValue($string)  if $fieldType eq 'SFRotation';
		return &sfstringValue($string)    if $fieldType eq 'SFString';
		return &sftimeValue($string)      if $fieldType eq 'SFTime';
		return &sfvec2dValue($string)     if $fieldType eq 'SFVec2d';
		return &sfvec2fValue($string)     if $fieldType eq 'SFVec2f';
		return &sfvec3dValue($string)     if $fieldType eq 'SFVec3d';
		return &sfvec3fValue($string)     if $fieldType eq 'SFVec3f';
		return &sfvec4dValue($string)     if $fieldType eq 'SFVec4d';
		return &sfvec4fValue($string)     if $fieldType eq 'SFVec4f';
	} else {
		return &mfboolValue($string)      if $fieldType eq 'MFBool';
		return &mfcolorValue($string)     if $fieldType eq 'MFColor';
		return &mfcolorRGBAValue($string) if $fieldType eq 'MFColorRGBA';
		return &mfdoubleValue($string)    if $fieldType eq 'MFDouble';
		return &mffloatValue($string)     if $fieldType eq 'MFFloat';
		return &mfimageValue($string)     if $fieldType eq 'MFImage';
		return &mfint32Value($string)     if $fieldType eq 'MFInt32';
		return &brackets($string)         if $fieldType eq 'MFNode';
		return &mfrotationValue($string)  if $fieldType eq 'MFRotation';
		return &mfstringValue($string)    if $fieldType eq 'MFString';
		return &mftimeValue($string)      if $fieldType eq 'MFTime';
		return &mfvec2dValue($string)     if $fieldType eq 'MFVec2d';
		return &mfvec2fValue($string)     if $fieldType eq 'MFVec2f';
		return &mfvec3dValue($string)     if $fieldType eq 'MFVec3d';
		return &mfvec3fValue($string)     if $fieldType eq 'MFVec3f';
		return &mfvec4dValue($string)     if $fieldType eq 'MFVec4d';
		return &mfvec4fValue($string)     if $fieldType eq 'MFVec4f';
	}

	#	if ( $this->{comment} =~ /$_CosmoWorlds/ ) {
	#		my $version = $1;
	#		return $this->sfenumValue if $fieldType eq 'SFEnum';
	#		return $this->mfenumValue if $fieldType eq 'MFEnum';
	#	}

	return;
}

sub sfboolValue {
	my ($string) = @_;
	return YES if $$string =~ m.$_TRUE.gc;
	return NO  if $$string =~ m.$_FALSE.gc;
	return;
}

sub sfcolorValue {
	my ($string) = @_;
	my ( $r, $g, $b );
	$r = &float($string);
	if ( defined $r ) {
		$g = &float($string);
		if ( defined $g ) {
			$b = &float($string);
			if ( defined $b ) {
				return new Weed::Values::Color [ $r, $g, $b ];
			}
		}
	}
	return;
}

sub sfdoubleValue {
	my ($string) = @_;
	my $double = &float($string);
	return $double if defined $double;
	return;
}

sub sffloatValue {
	my ($string) = @_;
	my $float = &float($string);
	return $float if defined $float;
	return;
}

sub float {
	my ($string) = @_;
	return $1 if $$string =~ m.$_float.gc;
	return 0  if $$string =~ m.$_nan.gc;

	#return ...  if $$string =~ m.$_inf.gc;
	#X3DError::Debug "VRML2::Parser::float undef\n";
	return;
}

sub sfimageValue {
	my ($string) = @_;
	my ( $width, $height, $components );
	my $pixels = new X3DArray;

	$width = &int32($string);
	if ( defined $width ) {
		$height = &int32($string);
		if ( defined $height ) {
			$components = &int32($string);
			if ( defined $components ) {
				my $size = $height * $width;
				for ($size) {
					my $pixel = &int32($string);
					last unless defined $pixel;
					push @$pixels, $pixel;
				}
				return new Weed::Values::Image [ $width, $height, $components, $pixels ];
			}
		}
	}

	return;
}

sub mfimageValue {
	my ($string) = @_;

	my $sfimageValue = &sfimageValue($string);
	return new X3DArray($sfimageValue) if defined $sfimageValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfimageValues = &sfimageValues($string);
		return new X3DArray($sfimageValues)
		  if @$sfimageValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfimageValues {
	my ($string)      = @_;
	my $sfimageValue  = &sfimageValue($string);
	my $sfimageValues = new X3DArray;
	while ( defined $sfimageValue ) {
		push @$sfimageValues, $sfimageValue;
		$sfimageValue = &sfimageValue($string);
	}
	return $sfimageValues;
}

sub sfint32Value {
	my ($string) = @_;
	my $int32 = &int32($string);
	return $int32 if defined $int32;
	return;
}

sub int32 {
	my ($string) = @_;
	return defined $2 ? hex($1) : $1 if $$string =~ m.$_int32.gc;
	return;
}

sub sfrotationValue {
	my ($string) = @_;
	my ( $x, $y, $z, $angle );

	$x = &float($string);
	if ( defined $x ) {
		$y = &float($string);
		if ( defined $y ) {
			$z = &float($string);
			if ( defined $z ) {
				$angle = &float($string);
				if ( defined $angle ) {
					return new Weed::Values::Rotation [ $x, $y, $z, $angle ];
				}
			}
		}
	}

	return;
}

sub sfstringValue {
	my ($string) = @_;
	return &string($string);
}

sub sftimeValue {
	my ($string) = @_;
	my $time = &double($string);
	return $time if defined $time;
	return;
}

sub mftimeValue {
	my ($string) = @_;

	my $sftimeValue = &sftimeValue($string);
	return new X3DArray($sftimeValue) if defined $sftimeValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sftimeValues = &sftimeValues($string);
		return $sftimeValues
		  if @$sftimeValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sftimeValues {
	my ($string)     = @_;
	my $sftimeValue  = &sftimeValue($string);
	my $sftimeValues = new X3DArray;
	while ( defined $sftimeValue ) {
		push @$sftimeValues, $sftimeValue;
		$sftimeValue = &sftimeValue($string);
	}
	return $sftimeValues;
}

sub sfvec2fValue {
	my ($string) = @_;
	my ( $x, $y );

	$x = &float($string);
	if ( defined $x ) {
		$y = &float($string);
		if ( defined $y ) {
			return new Weed::Values::Vec2 [ $x, $y ];
		}
	}

	return;
}

sub sfvec2dValue {
	my ($string) = @_;
	my ( $x, $y );

	$x = &double($string);
	if ( defined $x ) {
		$y = &double($string);
		if ( defined $y ) {
			return new Weed::Values::Vec2 [ $x, $y ];
		}
	}

	return;
}

sub sfvec3fValue {
	my ($string) = @_;
	my ( $x, $y, $z );

	$x = &float($string);
	if ( defined $x ) {
		$y = &float($string);
		if ( defined $y ) {
			$z = &float($string);
			if ( defined $z ) {
				return new Weed::Values::Vec3 [ $x, $y, $z ];
			}
		}
	}

	return;
}

sub sfvec3dValue {
	my ($string) = @_;
	my ( $x, $y, $z );

	$x = &double($string);
	if ( defined $x ) {
		$y = &double($string);
		if ( defined $y ) {
			$z = &double($string);
			if ( defined $z ) {
				return new Weed::Values::Vec3 [ $x, $y, $z ];
			}
		}
	}

	return;
}

sub sfvec4fValue {
	my ($string) = @_;
	my ( $x, $y, $z, $w );

	$x = &float($string);
	if ( defined $x ) {
		$y = &float($string);
		if ( defined $y ) {
			$z = &float($string);
			if ( defined $z ) {
				$w = &float($string);
				if ( defined $w ) {
					return new Weed::Values::Vec4 [ $x, $y, $z, $w ];
				}
			}
		}
	}

	return;
}

sub sfvec4dValue {
	my ($string) = @_;
	my ( $x, $y, $z, $w );

	$x = &double($string);
	if ( defined $x ) {
		$y = &double($string);
		if ( defined $y ) {
			$z = &double($string);
			if ( defined $z ) {
				$w = &double($string);
				if ( defined $w ) {
					return new Weed::Values::Vec4 [ $x, $y, $z, $w ];
				}
			}
		}
	}

	return;
}

sub mfboolValue {
	my ($string) = @_;

	my $sfboolValue = &sfboolValue($string);
	return new X3DArray($sfboolValue) if defined $sfboolValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfboolValues = &sfboolValues($string);
		return $sfboolValues
		  if @$sfboolValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfboolValues {
	my ($string)     = @_;
	my $sfboolValue  = &sfboolValue($string);
	my $sfboolValues = new X3DArray;
	while ( defined $sfboolValue ) {
		push @$sfboolValues, $sfboolValue;
		$sfboolValue = &sfboolValue($string);
	}
	return $sfboolValues;
}

sub mfcolorValue {
	my ($string) = @_;

	my $sfcolorValue = &sfcolorValue($string);
	return new X3DArray($sfcolorValue) if defined $sfcolorValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfcolorValues = &sfcolorValues($string);
		return $sfcolorValues
		  if @$sfcolorValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfcolorValues {
	my ($string)      = @_;
	my $sfcolorValue  = &sfcolorValue($string);
	my $sfcolorValues = new X3DArray;
	while ( defined $sfcolorValue ) {
		push @$sfcolorValues, $sfcolorValue;
		$sfcolorValue = &sfcolorValue($string);
	}
	return $sfcolorValues;
}

sub mfdoubleValue {
	my ($string) = @_;

	my $sfdoubleValue = &sfdoubleValue($string);
	return new X3DArray($sfdoubleValue) if defined $sfdoubleValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfdoubleValues = &sfdoubleValues($string);
		return $sfdoubleValues
		  if @$sfdoubleValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfdoubleValues {
	my ($string)       = @_;
	my $sfdoubleValue  = &sfdoubleValue($string);
	my $sfdoubleValues = new X3DArray;
	while ( defined $sfdoubleValue ) {
		push @$sfdoubleValues, $sfdoubleValue;
		$sfdoubleValue = &sfdoubleValue($string);
	}
	return $sfdoubleValues;
}

sub mffloatValue {
	my ($string) = @_;

	my $sffloatValue = &sffloatValue($string);
	return new X3DArray($sffloatValue) if defined $sffloatValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sffloatValues = &sffloatValues($string);
		return $sffloatValues
		  if @$sffloatValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sffloatValues {
	my ($string)      = @_;
	my $sffloatValue  = &sffloatValue($string);
	my $sffloatValues = new X3DArray;
	while ( defined $sffloatValue ) {
		push @$sffloatValues, $sffloatValue;
		$sffloatValue = &sffloatValue($string);
	}
	return $sffloatValues;
}

sub mfint32Value {
	my ($string) = @_;

	my $sfint32Value = &sfint32Value($string);
	return new X3DArray($sfint32Value) if defined $sfint32Value;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfint32Values = &sfint32Values($string);
		return $sfint32Values
		  if @$sfint32Values && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfint32Values {
	my ($string)      = @_;
	my $sfint32Value  = &sfint32Value($string);
	my $sfint32Values = new X3DArray;
	while ( defined $sfint32Value ) {
		push @$sfint32Values, $sfint32Value;
		$sfint32Value = &sfint32Value($string);
	}
	return $sfint32Values;
}

sub mfrotationValue {
	my ($string) = @_;

	my $sfrotationValue = &sfrotationValue($string);
	return new X3DArray($sfrotationValue) if defined $sfrotationValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfrotationValues = &sfrotationValues($string);
		return $sfrotationValues
		  if @$sfrotationValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfrotationValues {
	my ($string)         = @_;
	my $sfrotationValue  = &sfrotationValue($string);
	my $sfrotationValues = new X3DArray;
	while ( defined $sfrotationValue ) {
		push @$sfrotationValues, $sfrotationValue;
		$sfrotationValue = &sfrotationValue($string);
	}
	return $sfrotationValues;
}

sub mfstringValue {
	my ($string) = @_;

	my $sfstringValue = &sfstringValue($string);
	return new X3DArray($sfstringValue) if defined $sfstringValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfstringValues = &sfstringValues($string);
		return $sfstringValues
		  if @$sfstringValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfstringValues {
	my ($string)       = @_;
	my $sfstringValue  = &sfstringValue($string);
	my $sfstringValues = new X3DArray;
	while ( defined $sfstringValue ) {
		push @$sfstringValues, $sfstringValue;
		$sfstringValue = &sfstringValue($string);
	}
	return $sfstringValues;
}

sub mfvec2dValue {
	my ($string) = @_;

	my $sfvec2dValue = &sfvec2dValue($string);
	return new X3DArray($sfvec2dValue) if defined $sfvec2dValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec2dValues = &sfvec2dValues($string);
		return $sfvec2dValues
		  if @$sfvec2dValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec2dValues {
	my ($string)      = @_;
	my $sfvec2dValue  = &sfvec2dValue($string);
	my $sfvec2dValues = new X3DArray;
	while ( defined $sfvec2dValue ) {
		push @$sfvec2dValues, $sfvec2dValue;
		$sfvec2dValue = &sfvec2dValue($string);
	}
	return $sfvec2dValues;
}

sub mfvec2fValue {
	my ($string) = @_;

	my $sfvec2fValue = &sfvec2fValue($string);
	return new X3DArray($sfvec2fValue) if defined $sfvec2fValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec2fValues = &sfvec2fValues($string);
		return new X3DArray($sfvec2fValues)
		  if @$sfvec2fValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec2fValues {
	my ($string)      = @_;
	my $sfvec2fValue  = &sfvec2fValue($string);
	my $sfvec2fValues = new X3DArray;
	while ( defined $sfvec2fValue ) {
		push @$sfvec2fValues, $sfvec2fValue;
		$sfvec2fValue = &sfvec2fValue($string);
	}
	return $sfvec2fValues;
}

sub mfvec3dValue {
	my ($string) = @_;

	my $sfvec3dValue = &sfvec3dValue($string);
	return new X3DArray($sfvec3dValue) if defined $sfvec3dValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec3dValues = &sfvec3dValues($string);
		return $sfvec3dValues
		  if @$sfvec3dValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec3dValues {
	my ($string)      = @_;
	my $sfvec3dValue  = &sfvec3dValue($string);
	my $sfvec3dValues = new X3DArray;
	while ( defined $sfvec3dValue ) {
		push @$sfvec3dValues, $sfvec3dValue;
		$sfvec3dValue = &sfvec3dValue($string);
	}
	return $sfvec3dValues;
}

sub mfvec3fValue {
	my ($string) = @_;

	my $sfvec3fValue = &sfvec3fValue($string);
	return new X3DArray($sfvec3fValue) if defined $sfvec3fValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec3fValues = &sfvec3fValues($string);
		return $sfvec3fValues
		  if @$sfvec3fValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec3fValues {
	my ($string)      = @_;
	my $sfvec3fValue  = &sfvec3fValue($string);
	my $sfvec3fValues = new X3DArray;
	while ( defined $sfvec3fValue ) {
		push @$sfvec3fValues, $sfvec3fValue;
		$sfvec3fValue = &sfvec3fValue($string);
	}
	return $sfvec3fValues;
}

#
sub mfvec4dValue {
	my ($string) = @_;

	my $sfvec4dValue = &sfvec4dValue($string);
	return new X3DArray($sfvec4dValue) if defined $sfvec4dValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec4dValues = &sfvec4dValues($string);
		return $sfvec4dValues
		  if @$sfvec4dValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec4dValues {
	my ($string)      = @_;
	my $sfvec4dValue  = &sfvec4dValue($string);
	my $sfvec4dValues = new X3DArray;
	while ( defined $sfvec4dValue ) {
		push @$sfvec4dValues, $sfvec4dValue;
		$sfvec4dValue = &sfvec4dValue($string);
	}
	return $sfvec4dValues;
}

sub mfvec4fValue {
	my ($string) = @_;

	my $sfvec4fValue = &sfvec4fValue($string);
	return new X3DArray($sfvec4fValue) if defined $sfvec4fValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec4fValues = &sfvec4fValues($string);
		return $sfvec4fValues
		  if @$sfvec4fValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec4fValues {
	my ($string)      = @_;
	my $sfvec4fValue  = &sfvec4fValue($string);
	my $sfvec4fValues = new X3DArray;
	while ( defined $sfvec4fValue ) {
		push @$sfvec4fValues, $sfvec4fValue;
		$sfvec4fValue = &sfvec4fValue($string);
	}
	return $sfvec4fValues;
}

#
sub null {
	my ($string) = @_;
	return undef if $$string =~ m/$_NULL/gc;
	warn __PACKAGE__ . " could not pare NULL";
	return;
}

sub brackets {
	my ($string) = @_;
	return new X3DArray if $$string =~ m.$_brackets.gc;
	return;
}

# Fields CosmoWorlds
sub sfenumValue {
	my ($string) = @_;
	my $enum = &enum($string);
	return $enum if defined $enum;
}

sub enum {
	my ($string) = @_;
	return $1 if $$string =~ m.$_enum.gc;
	return;
}

sub mfenumValue {
	my ($string) = @_;

	my $sfenumValue = &sfenumValue($string);
	return new X3DArray($sfenumValue) if defined $sfenumValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfenumValues = &sfenumValues($string);
		return $sfenumValues
		  if @$sfenumValues && $$string =~ m.$_close_bracket.gc;
	}
	return;
}

sub sfenumValues {
	my ($string)     = @_;
	my $sfenumValue  = &sfenumValue($string);
	my $sfenumValues = new X3DArray;
	while ( defined $sfenumValue ) {
		push @$sfenumValues, $sfenumValue;
		$sfenumValue = &sfenumValue($string);
	}
	return $sfenumValues;
}

# colorRGBA
sub sfcolorRGBAValue {
	my ($string) = @_;
	my ( $r, $g, $b, $a );
	$r = &float($string);
	if ( defined $r ) {
		$g = &float($string);
		if ( defined $g ) {
			$b = &float($string);
			if ( defined $b ) {
				$a = &float($string);
				if ( defined $a ) {
					return new Weed::Values::ColorRGBA [ $r, $g, $b, $a ];
				}
			}
		}
	}
	return;
}

sub mfcolorRGBAValue {
	my ($string) = @_;

	my $sfcolorRGBAValue = &sfcolorRGBAValue($string);
	return new X3DArray($sfcolorRGBAValue) if defined $sfcolorRGBAValue;

	return new X3DArray if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfcolorRGBAValues = &sfcolorRGBAValues($string);
		return $sfcolorRGBAValues
		  if @$sfcolorRGBAValues && $$string =~ m.$_close_bracket.gc;
	}
	return;
}

sub sfcolorRGBAValues {
	my ($string)          = @_;
	my $sfcolorRGBAValue  = &sfcolorRGBAValue($string);
	my $sfcolorRGBAValues = new X3DArray;
	while ( defined $sfcolorRGBAValue ) {
		push @$sfcolorRGBAValues, $sfcolorRGBAValue;
		$sfcolorRGBAValue = &sfcolorRGBAValue($string);
	}
	return $sfcolorRGBAValues;
}

1;
__END__

