package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFFloat";
	our $directory = "_Inline";
}

our ($VERSION, $package, $directory);

use Inline (CPP => 'DATA',
	NAME					=> $package,
#	VERSION 				=> $VERSION,
#	DIRECTORY 			=> $directory,
	TYPEMAPS				=> "map/$package.map",
#	LIBS					=> '-lfoo',
#	INC 					=> '-I/foo/include',
#	PREFIX				=> 'XXX_',
	FORCE_BUILD 		=> 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS				=> 0,
);

system "mkdir -p ../auto" unless -e "../auto";
system "rm -r ../auto/$package" if -e "../auto/$package";
system "cp -r $directory/lib/auto/$package ../auto";

1;
__DATA__
__CPP__

class SFFloat {
	private:
		double value;

	public:
		SFFloat (const double v=0) { setValue(v); }

		inline const SFFloat* copy () { return new SFFloat(value); }

		inline void setValue (const double v) { value = v; }
		inline const double getValue () { return value; }

		//inline void madd      (const double v) { value += v; }
		//inline void msubtract (const double v) { value -= v; }
		//inline void mmultiply (const double v) { value *= v; }
		//inline void mdivide   (const double v) { value /= v; }
	
		//inline const SFFloat* add      (const double v) { return new SFFloat(value + v); }
		//inline const SFFloat* subtract (const double v) { return new SFFloat(value - v); }
		//inline const SFFloat* multiply (const double v) { return new SFFloat(value * v); }
		//inline const SFFloat* divide   (const double v) { return new SFFloat(value / v); }
};

