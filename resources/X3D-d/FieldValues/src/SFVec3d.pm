package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFVec3d";
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

class SFVec3d {
	public:
		double x;
		double y;
		double z;

	public:
		SFVec3d (const double x=0, const double y=0, const double z=0) { setValue(x,y,z); }

		inline const SFVec3d* copy () { return new SFVec3d(x,y,z); }
		
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

		inline const SFVec3d* negate (SV* s=0) {
			return new SFVec3d(
				-x,
				-y,
				-z
			);
		}
		
		inline const SFVec3d* add (SFVec3d* v, SV* s=0) {
			return new SFVec3d(
				x + v->x,
				y + v->y,
				z + v->z
			);
		}
		
		inline const SFVec3d* subtract (SFVec3d* v, SV* s=0) {
			return new SFVec3d(
				x - v->x,
				y - v->y,
				z - v->z
			);
		}

		inline const SFVec3d* multiply (const double v, SV* s=0) {
			return new SFVec3d(
				x * v,
				y * v,
				z * v
			);
		}

		inline const SFVec3d* divide (const double v, SV* s=0) {
			return new SFVec3d(
				x / v,
				y / v,
				z / v
			);
		}

		inline const double dot (SFVec3d* v, SV* s=0) {
			return 
				x * v->x +
				y * v->y +
				z * v->z
			;
		}

		inline const SFVec3d* cross (SFVec3d* v, SV* s=0) {
			return new SFVec3d(
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
	
		inline const SFVec3d* normalize () {
			return divide(length());
		}

};

