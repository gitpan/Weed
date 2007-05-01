package Weed::Parse::FieldTypes;
use strict;
use warnings;

use Weed::RegularExpressions;

sub sfboolValue {
	my ($string) = @_;
	return 1  if $$string =~ m.$_TRUE.gc;
	return !1 if $$string =~ m.$_FALSE.gc;
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
				return [ $r, $g, $b ];
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
	my $pixels = [];

	$width = &int32($string);
	if ( defined $width ) {
		$height = &int32($string);
		if ( defined $height ) {
			$components = &int32($string);
			if ( defined $components ) {
				my $size = $height * $width;
				for ( my $i = 0 ; $i < $size ; ++$i ) {
					my $pixel = &int32($string);
					last unless defined $pixel;
					push @$pixels, $pixel;
				}
				return [ $width, $height, $components, $pixels ];
			}
		}
	}

	return;
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
					return [ $x, $y, $z, $angle ];
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

sub string {
	my ($string) = @_;
	return $1 if $$string =~ m.$_string.gc;
	return;
}

sub sftimeValue {
	my ($string) = @_;
	my $time = &double($string);
	return $time if defined $time;
	return;
}

sub double {
	my ($string) = @_;
	return $1 if $$string =~ m.$_double.gc;
	return;
}

sub mftimeValue {
	my ($string) = @_;

	my $sftimeValue = &sftimeValue($string);
	return [$sftimeValue] if defined $sftimeValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sftimeValues = [];
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
			return [ $x, $y ];
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
			return [ $x, $y ];
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
				return [ $x, $y, $z ];
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
				return [ $x, $y, $z ];
			}
		}
	}

	return;
}

sub mfboolValue {
	my ($string) = @_;

	my $sfboolValue = &sfboolValue($string);
	return [$sfboolValue] if defined $sfboolValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfboolValues = [];
	while ( defined $sfboolValue ) {
		push @$sfboolValues, $sfboolValue;
		$sfboolValue = &sfboolValue($string);
	}
	return $sfboolValues;
}

sub mfcolorValue {
	my ($string) = @_;

	my $sfcolorValue = &sfcolorValue($string);
	return [$sfcolorValue] if defined $sfcolorValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfcolorValues = [];
	while ( defined $sfcolorValue ) {
		push @$sfcolorValues, $sfcolorValue;
		$sfcolorValue = &sfcolorValue($string);
	}
	return $sfcolorValues;
}

sub mfdoubleValue {
	my ($string) = @_;

	my $sfdoubleValue = &sfdoubleValue($string);
	return [$sfdoubleValue] if defined $sfdoubleValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfdoubleValues = [];
	while ( defined $sfdoubleValue ) {
		push @$sfdoubleValues, $sfdoubleValue;
		$sfdoubleValue = &sfdoubleValue($string);
	}
	return $sfdoubleValues;
}

sub mffloatValue {
	my ($string) = @_;

	my $sffloatValue = &sffloatValue($string);
	return [$sffloatValue] if defined $sffloatValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sffloatValues = [];
	while ( defined $sffloatValue ) {
		push @$sffloatValues, $sffloatValue;
		$sffloatValue = &sffloatValue($string);
	}
	return $sffloatValues;
}

sub mfint32Value {
	my ($string) = @_;

	my $sfint32Value = &sfint32Value($string);
	return [$sfint32Value] if defined $sfint32Value;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfint32Values = [];
	while ( defined $sfint32Value ) {
		push @$sfint32Values, $sfint32Value;
		$sfint32Value = &sfint32Value($string);
	}
	return $sfint32Values;
}

sub mfrotationValue {
	my ($string) = @_;

	my $sfrotationValue = &sfrotationValue($string);
	return [$sfrotationValue] if defined $sfrotationValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfrotationValues = [];
	while ( defined $sfrotationValue ) {
		push @$sfrotationValues, $sfrotationValue;
		$sfrotationValue = &sfrotationValue($string);
	}
	return $sfrotationValues;
}

sub mfstringValue {
	my ($string) = @_;

	my $sfstringValue = &sfstringValue($string);
	return [$sfstringValue] if defined $sfstringValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfstringValues = [];
	while ( defined $sfstringValue ) {
		push @$sfstringValues, $sfstringValue;
		$sfstringValue = &sfstringValue($string);
	}
	return $sfstringValues;
}

sub mfvec2dValue {
	my ($string) = @_;

	my $sfvec2dValue = &sfvec2dValue($string);
	return [$sfvec2dValue] if defined $sfvec2dValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfvec2dValues = [];
	while ( defined $sfvec2dValue ) {
		push @$sfvec2dValues, $sfvec2dValue;
		$sfvec2dValue = &sfvec2dValue($string);
	}
	return $sfvec2dValues;
}

sub mfvec2fValue {
	my ($string) = @_;

	my $sfvec2fValue = &sfvec2fValue($string);
	return [$sfvec2fValue] if defined $sfvec2fValue;

	return [] if $$string =~ m.$_brackets.gc;

	if ( $$string =~ m.$_open_bracket.gc ) {
		my $sfvec2fValues = &sfvec2fValues($string);
		return [$sfvec2fValues]
		  if @$sfvec2fValues && $$string =~ m.$_close_bracket.gc;
	}

	return;
}

sub sfvec2fValues {
	my ($string)      = @_;
	my $sfvec2fValue  = &sfvec2fValue($string);
	my $sfvec2fValues = [];
	while ( defined $sfvec2fValue ) {
		push @$sfvec2fValues, $sfvec2fValue;
		$sfvec2fValue = &sfvec2fValue($string);
	}
	return $sfvec2fValues;
}

sub mfvec3dValue {
	my ($string) = @_;

	my $sfvec3dValue = &sfvec3dValue($string);
	return [$sfvec3dValue] if defined $sfvec3dValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfvec3dValues = [];
	while ( defined $sfvec3dValue ) {
		push @$sfvec3dValues, $sfvec3dValue;
		$sfvec3dValue = &sfvec3dValue($string);
	}
	return $sfvec3dValues;
}

sub mfvec3fValue {
	my ($string) = @_;

	my $sfvec3fValue = &sfvec3fValue($string);
	return [$sfvec3fValue] if defined $sfvec3fValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfvec3fValues = [];
	while ( defined $sfvec3fValue ) {
		push @$sfvec3fValues, $sfvec3fValue;
		$sfvec3fValue = &sfvec3fValue($string);
	}
	return $sfvec3fValues;
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
	return [$sfenumValue] if defined $sfenumValue;

	return [] if $$string =~ m.$_brackets.gc;

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
	my $sfenumValues = [];
	while ( defined $sfenumValue ) {
		push @$sfenumValues, $sfenumValue;
		$sfenumValue = &sfenumValue($string);
	}
	return $sfenumValues;
}

1;
__END__

