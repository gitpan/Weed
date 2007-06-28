package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFColorRGBA";
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

#define PI 3.141592653589793238462643383279502884197168
#define _max(a,b)     (a > b ? a : b)
#define _min(a,b)     (a < b ? a : b)
#define _minmax(v,a,b) _min(_max(v, a), b)

class SFColorRGBA {
	public:
		double r;
		double g;
		double b;
		double a;

	public:
		SFColorRGBA (const double r=0, const double g=0, const double b=0, const double a=0) { setValue(r,g,b,a); }

		inline const SFColorRGBA* copy () { return new SFColorRGBA(r,g,b,a); }
		
		inline void setValue (const double r, const double g, const double b, const double a) {
			this->r = _minmax(r, 0,1);
			this->g = _minmax(g, 0,1);
			this->b = _minmax(b, 0,1);
			this->a = _minmax(a, 0,1);
		}
		
		inline void getValue () {
			Inline_Stack_Vars;
			Inline_Stack_Reset;
				Inline_Stack_Push(sv_2mortal(newSVnv(r)));
				Inline_Stack_Push(sv_2mortal(newSVnv(g)));
				Inline_Stack_Push(sv_2mortal(newSVnv(b)));
				Inline_Stack_Push(sv_2mortal(newSVnv(a)));
			Inline_Stack_Done;
		}
		
		inline void setRed   (const double r) { this->r = _minmax(r, 0,1); }
		inline void setGreen (const double g) { this->g = _minmax(g, 0,1); }
		inline void setBlue  (const double b) { this->b = _minmax(b, 0,1); }
		inline void setAlpha (const double b) { this->a = _minmax(a, 0,1); }

		inline const double getRed   () { return r; }
		inline const double getGreen () { return g; }
		inline const double getBlue  () { return b; }
		inline const double getAlpha () { return a; }

		void setHSV (double h, double s, double v) {
			// H is given on [0, 2 * Pi]. S and V are given on [0, 1]. 
			// RGB are each returned on [0, 1]. 
		
			if ( s == 0 ) {
				// achromatic (grey)
				r = g = b = v;
				return;
			}
		
			h *= 180 / PI;
		
			h /= 60;                             // sector 0 to 5
			double i = floor( h );
			double f = h - i;							 // factorial part of h
			double p = v * ( 1 - s );
			double q = v * ( 1 - s * f );
			double t = v * ( 1 - s * ( 1 - f ) );
		
			if (i == 0) return setValue (v, t, p, a);
			if (i == 1) return setValue (q, v, p, a);
			if (i == 2) return setValue (p, v, t, a);
			if (i == 3) return setValue (p, q, v, a);
			if (i == 4) return setValue (t, p, v, a);
			return setValue (v, p, q, a);
		} 
		
		void getHSV () {
			double h, s, v;
		
			double min = _min( r, _min( g, b ) );
			double max = _max( r, _max( g, b ) );
			v = max;                                       // v
		
			double delta = max - min;
		
			if ( max != 0 && delta != 0 ) {
				s = delta / max;                            // s
			} else {
				// r = g = b = 0                            // s = 0, h is undefined
				s = 0;
				h = 0;
				Inline_Stack_Vars;
				Inline_Stack_Reset;
					Inline_Stack_Push(sv_2mortal(newSVnv(h)));
					Inline_Stack_Push(sv_2mortal(newSVnv(s)));
					Inline_Stack_Push(sv_2mortal(newSVnv(v)));
				Inline_Stack_Done;
				return;
			}
		
			if ( r == max ) {
				h = ( g - b ) / delta;                     // between yellow & magenta
			} else if ( g == max ) {
				h = 2 + ( b - r ) / delta;                 // between cyan & yellow
			} else {
				h = 4 + ( r - g ) / delta;                 // between magenta & cyan
			}
		
			h *= PI * 1/3;                                // radiants
			if( h < 0 ) {
				h += 2 * PI;
			}
		
			Inline_Stack_Vars;
			Inline_Stack_Reset;
				Inline_Stack_Push(sv_2mortal(newSVnv(h)));
				Inline_Stack_Push(sv_2mortal(newSVnv(s)));
				Inline_Stack_Push(sv_2mortal(newSVnv(v)));
			Inline_Stack_Done;
			return;
		}
		
		inline const SFColorRGBA* negate (SV* s=0) {
			return new SFColorRGBA(
				-r,
				-g,
				-b,
				a
			);
		}
		
		inline const SFColorRGBA* add (SFColorRGBA* v, SV* s=0) {
			return new SFColorRGBA(
				r + v->r,
				g + v->g,
				b + v->b,
				a
			);
		}
		
		inline const SFColorRGBA* subtract (SFColorRGBA* v, SV* s=0) {
			return new SFColorRGBA(
				r - v->r,
				g - v->g,
				b - v->b,
				a
			);
		}

		inline const SFColorRGBA* multiply (SFColorRGBA* v, SV* s=0) {
			return new SFColorRGBA(
				r * v->r,
				g * v->g,
				b * v->b,
				a
			);
		}

		inline const SFColorRGBA* lighten (const double v, SV* s=0) {
			return new SFColorRGBA(
				r * v,
				g * v,
				b * v,
				a
			);
		}
		
		inline const SFColorRGBA* divide (SFColorRGBA* v, SV* s=0) {
			return new SFColorRGBA(
				r / v->r,
				g / v->g,
				b / v->b,
				a
			);
		}

		inline const SFColorRGBA* darken (const double v, SV* s=0) {
			return new SFColorRGBA(
				r / v,
				g / v,
				b / v,
				a
			);
		}

};

