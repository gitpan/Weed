package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFVec3f";
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

class SFVec3f {
	public:
		double x;
		double y;
		double z;

	public:
		SFVec3f (const double x=0, const double y=0, const double z=0) { setValue(x,y,z); }

		inline const SFVec3f* copy () { return new SFVec3f(x,y,z); }
		
		inline void setValue (const double x, const double y, const double z) {
			this->x = x;
			this->y = y;
			this->z = z;
		}
		
		inline void getValue () {
			Inline_Stack_Vars;
			Inline_Stack_Reset;
				Inline_Stack_Push(sv_2mortal(newSVnv(x)));
				Inline_Stack_Push(sv_2mortal(newSVnv(y)));
				Inline_Stack_Push(sv_2mortal(newSVnv(z)));
			Inline_Stack_Done;
		}
		
		inline void setX (const double x) { this->x = x; }
		inline void setY (const double y) { this->y = y; }
		inline void setZ (const double z) { this->z = z; }

		inline const double getX () { return x; }
		inline const double getY () { return y; }
		inline const double getZ () { return z; }

		inline const SFVec3f* negate (SV* s=0) {
			return new SFVec3f(
				-x,
				-y,
				-z
			);
		}
		
		inline const SFVec3f* add (SFVec3f* v, SV* s=0) {
			return new SFVec3f(
				x + v->x,
				y + v->y,
				z + v->z
			);
		}
		
		inline const SFVec3f* subtract (SFVec3f* v, SV* s=0) {
			return new SFVec3f(
				x - v->x,
				y - v->y,
				z - v->z
			);
		}

		inline const SFVec3f* multiply (const double v, SV* s=0) {
			return new SFVec3f(
				x * v,
				y * v,
				z * v
			);
		}

		inline const SFVec3f* divide (const double v, SV* s=0) {
			return new SFVec3f(
				x / v,
				y / v,
				z / v
			);
		}

		inline const double dot (SFVec3f* v, SV* s=0) {
			return 
				x * v->x +
				y * v->y +
				z * v->z
			;
		}

		inline const SFVec3f* cross (SFVec3f* v, SV* s=0) {
			return new SFVec3f(
				y * v->z - z * v->y,
				z * v->x - x * v->z,
				x * v->y - y * v->x
			);
		}

		inline const double length (SV* s=0) {
			return sqrt(
				x*x +
				y*y +
				z*z
			);
		}
	
		inline const SFVec3f* normalize () {
			return divide(length());
		}

};

