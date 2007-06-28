package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFVec2f";
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

class SFVec2f {
	public:
		double x;
		double y;

	public:
		SFVec2f (const double x=0, const double y=0) { setValue(x,y); }

		inline const SFVec2f* copy () { return new SFVec2f(x,y); }
		
		inline void setValue (const double x, const double y) {
			this->x = x;
			this->y = y;
		}
		
		inline void getValue () {
			Inline_Stack_Vars;
			Inline_Stack_Reset;
				Inline_Stack_Push(sv_2mortal(newSVnv(x)));
				Inline_Stack_Push(sv_2mortal(newSVnv(y)));
			Inline_Stack_Done;
		}
		
		inline void setX (const double x) { this->x = x; }
		inline void setY (const double y) { this->y = y; }

		inline const double getX () { return x; }
		inline const double getY () { return y; }

		inline const SFVec2f* negate (SV* s=0) {
			return new SFVec2f(
				-x,
				-y
			);
		}
		
		inline const SFVec2f* add (SFVec2f* v, SV* s=0) {
			return new SFVec2f(
				x + v->x,
				y + v->y
			);
		}
		
		inline const SFVec2f* subtract (SFVec2f* v, SV* s=0) {
			return new SFVec2f(
				x - v->x,
				y - v->y
			);
		}

		inline const SFVec2f* multiply (const double v, SV* s=0) {
			return new SFVec2f(
				x * v,
				y * v
			);
		}

		inline const SFVec2f* divide (const double v, SV* s=0) {
			return new SFVec2f(
				x / v,
				y / v
			);
		}

		inline const double dot (SFVec2f* v, SV* s=0) {
			return 
				x * v->x +
				y * v->y
			;
		}

		inline const double length (SV* s=0) {
			return sqrt(
				x*x +
				y*y
			);
		}
	
		inline const SFVec2f* normalize () {
			return divide(length());
		}

};

