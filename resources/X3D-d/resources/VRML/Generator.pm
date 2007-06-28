package VRML::Generator;
require 5.005;
use strict;
use Carp;

use VRML::Parse::Symbols qw($whitespace);
BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT @EXPORT_OK);
	@ISA = qw(Exporter);
	@EXPORT = qw(indent mfield_break);
	@EXPORT_OK = qw(
		$STYLE
		
		$SPACE
		$TAB
		$BREAK
		$STRING
		
		$INDENT_CHAR
		$INDENT_SIZE
		
		$MFIELD_BREAK
		
		$TIDY_SPACE
		$TIDY_BREAK
		
		$SCRIPT_FIELD_CLASS
		$FIELD_CLASS
		$FIELD_TYPE
		$FIELD_NAME
		
		$DEEP
	);
}

use vars @EXPORT_OK;
																	  
my $Styles = '^(tidy|compact|clean)$';
my $Style  = 'tidy';												  
																	  
my $Space  = ' ';													  
my $Tab    = "\t";													  
my $Break  = "\n";
my $String = '%s';													  
																	  
my $Indent_Char = $Space;
my $Indent_Size = 2;												  

my $MField_Break = $Break;											  
																	  
my $Script_field_Class = '%-8s';
my $Field_Class = '%-13s';											  
my $Field_Type  = '%-8s';											  
my $Field_Name  = $String;											  

my $Deep = 0;											  
	
&initialize;
&strict;
																  
sub initialize {
	$STYLE = $Style;
																		  
	$SPACE  = $Space;
	$TAB    = $Tab;
	$BREAK  = $Break;
	$STRING = $String;
	
	$INDENT_CHAR = $Indent_Char;
	$INDENT_SIZE = $Indent_Size;
	
	$MFIELD_BREAK = $MField_Break;
	
	$TIDY_SPACE = &tidy_space;
	$TIDY_BREAK = &tidy_break;
	
	$SCRIPT_FIELD_CLASS = $Script_field_Class;
	$FIELD_CLASS = $Field_Class;
	$FIELD_TYPE  = $Field_Type;
	$FIELD_NAME  = $Field_Name;
	
	$DEEP = $Deep;
}

sub strict {
	$STYLE = &style;
																		  
	$SPACE  = &space;
	$TAB    = &tab;
	$BREAK  = &break;
	$STRING = $STRING;
	
	$INDENT_CHAR = &indent_char;
	$INDENT_SIZE = &indent_size;
	
	$MFIELD_BREAK = &mfield_break;
	
	$TIDY_SPACE = &tidy_space;
	$TIDY_BREAK = &tidy_break;
	
	$SCRIPT_FIELD_CLASS = &script_field_class;
	$FIELD_CLASS = &field_class;
	$FIELD_TYPE  = &field_type;
	$FIELD_NAME  = &field_name;
	
	$DEEP = &deep;
}

sub style { $STYLE =~ /$Styles/ ? $STYLE : $Style }
sub deep  { $DEEP < 0 ? 0 : $Deep }
sub space { $SPACE =~ /$whitespace/ ? $SPACE : $Space }
sub tab   { $TAB =~ /$whitespace/ ? $TAB : $Tab }
sub break { $BREAK =~ /$whitespace/ ? $BREAK : $Break }


sub tidy_space { return $SPACE if $STYLE ne 'clean' }
sub tidy_break { return $BREAK if $STYLE ne 'clean' }

sub indent_char { $INDENT_CHAR =~ /$whitespace/ ? $INDENT_CHAR : $Indent_Char }
sub indent_size { $INDENT_SIZE < 0 ? $Indent_Size : $INDENT_SIZE }
sub indent      { $INDENT_CHAR x ($INDENT_SIZE * $DEEP) }
sub mfield_break { $STYLE ne 'tidy' ? $TIDY_SPACE : $MFIELD_BREAK.indent }

sub script_field_class { $STYLE ne 'clean' ? $SCRIPT_FIELD_CLASS.$SPACE : $STRING.$SPACE }
sub field_class { $STYLE ne 'clean' ? $FIELD_CLASS.$SPACE : $STRING.$SPACE }
sub field_type  { $STYLE ne 'clean' ? $FIELD_TYPE.$SPACE  : $STRING.$SPACE }
sub field_name  { $STYLE ne 'clean' ? $FIELD_NAME.$TAB    : $STRING.$SPACE }

1;
__END__

#my $HTML_INDENT_CHAR = "&nbsp; ";
#my $HTML_INDENT_SIZE = 8;

