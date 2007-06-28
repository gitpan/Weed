package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFVec2d";
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

class SFVec2d {
	public:
		double x;
		double y;

	public:
		SFVec2d (const double x=0, const double y=0) { setValue(x,y); }

		inline const SFVec2d* copy () { return new SFVec2d(x,y); }
		
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

		inline const SFVec2d* negate (SV* s=0) {
			return new SFVec2d(
				-x,
				-y
			);
		}
		
		inline const SFVec2d* add (SFVec2d* v, SV* s=0) {
			return new SFVec2d(
				x + v->x,
				y + v->y
			);
		}
		
		inline const SFVec2d* subtract (SFVec2d* v, SV* s=0) {
			return new SFVec2d(
				x - v->x,
				y - v->y
			);
		}

		inline const SFVec2d* multiply (const double v, SV* s=0) {
			return new SFVec2d(
				x * v,
				y * v
			);
		}

		inline const SFVec2d* divide (const double v, SV* s=0) {
			return new SFVec2d(
				x / v,
				y / v
			);
		}

		inline const double dot (SFVec2d* v, SV* s=0) {
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
	
		inline const SFVec2d* normalize () {
			return divide(length());
		}

};

