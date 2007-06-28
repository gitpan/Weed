package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.001';

	our $package   = "SFFloat";
	our $directory = "_Inline";

}

our ($VERSION, $package, $directory);

use Inline (CPP => 'DATA',
	NAME					=> $package,
#	VERSION 				=> $VERSION,
#	DIRECTORY 			=> $directory,
#	TYPEMAPS				=> 'CPP.map',
#	LIBS					=> '-lfoo',
#	INC 					=> '-I/foo/include',
#	PREFIX				=> 'XXX_',
	FORCE_BUILD 		=> 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS				=> 0,
);

system "rm -r ../auto/$package" if -e "../auto/$package";
system "cp -r $directory/lib/auto/$package ../auto";

1;
__DATA__
__CPP__

class SFFloat {
	public:
		float value;

		SFFloat (const float value=0) {
			setValue(value);
		}
		
		inline void setValue (const float value=0) {
			this->value = value;
		}
		
		inline const float getValue () {
			return value;
		}
};
