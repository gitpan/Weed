#ifndef bool
#include <iostream.h>
#endif
extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
}
#ifdef bool
#undef bool
#include <iostream.h>
#endif


#define PI 3.141592653589793238462643383279502884197168
#define _max(a,b)     (a > b ? a : b)
#define _min(a,b)     (a < b ? a : b)
#define _minmax(v,a,b) _min(_max(v, a), b)

class SFColor {
	public:
		double r;
		double g;
		double b;

	public:
		SFColor (const double r=0, const double g=0, const double b=0) { setValue(r,g,b); }

		inline const SFColor* copy () { return new SFColor(r,g,b); }
		
		inline void setValue (const double r, const double g, const double b) {
			this->r = _minmax(r, 0,1);
			this->g = _minmax(g, 0,1);
			this->b = _minmax(b, 0,1);
		}
		
		inline void getValue () {
			Inline_Stack_Vars;
			Inline_Stack_Reset;
				Inline_Stack_Push(sv_2mortal(newSVnv(r)));
				Inline_Stack_Push(sv_2mortal(newSVnv(g)));
				Inline_Stack_Push(sv_2mortal(newSVnv(b)));
			Inline_Stack_Done;
		}
		
		inline void setRed   (const double r) { this->r = _minmax(r, 0,1); }
		inline void setGreen (const double g) { this->g = _minmax(g, 0,1); }
		inline void setBlue  (const double b) { this->b = _minmax(b, 0,1); }

		inline const double getRed   () { return r; }
		inline const double getGreen () { return g; }
		inline const double getBlue  () { return b; }
	
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
		
			if (i == 0) return setValue (v, t, p);
			if (i == 1) return setValue (q, v, p);
			if (i == 2) return setValue (p, v, t);
			if (i == 3) return setValue (p, q, v);
			if (i == 4) return setValue (t, p, v);
			return setValue (v, p, q);
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
		
		inline const SFColor* negate (SV* s=0) {
			return new SFColor(
				-r,
				-g,
				-b
			);
		}
		
		inline const SFColor* add (SFColor* v, SV* s=0) {
			return new SFColor(
				r + v->r,
				g + v->g,
				b + v->b
			);
		}
		
		inline const SFColor* subtract (SFColor* v, SV* s=0) {
			return new SFColor(
				r - v->r,
				g - v->g,
				b - v->b
			);
		}

		inline const SFColor* multiply (SFColor* v, SV* s=0) {
			return new SFColor(
				r * v->r,
				g * v->g,
				b * v->b
			);
		}

		inline const SFColor* lighten (const double v, SV* s=0) {
			return new SFColor(
				r * v,
				g * v,
				b * v
			);
		}
		
		inline const SFColor* divide (SFColor* v, SV* s=0) {
			return new SFColor(
				r / v->r,
				g / v->g,
				b / v->b
			);
		}

		inline const SFColor* darken (const double v, SV* s=0) {
			return new SFColor(
				r / v,
				g / v,
				b / v
			);
		}

};


MODULE = SFColor     	PACKAGE = main::SFColor

PROTOTYPES: DISABLE

SFColor *
SFColor::new(...)
    PREINIT:
	double	r;
	double	g;
	double	b;
    CODE:
switch(items-1) {
case 1:
	r = (double)SvNV(ST(1));
	RETVAL = new SFColor(r);
	break; /* case 1 */
case 2:
	r = (double)SvNV(ST(1));
	g = (double)SvNV(ST(2));
	RETVAL = new SFColor(r,g);
	break; /* case 2 */
case 3:
	r = (double)SvNV(ST(1));
	g = (double)SvNV(ST(2));
	b = (double)SvNV(ST(3));
	RETVAL = new SFColor(r,g,b);
	break; /* case 3 */
default:
	RETVAL = new SFColor();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::copy()
    CODE:
	RETVAL = const_cast<SFColor *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFColor::setValue(r, g, b)
	double	r
	double	g
	double	b
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(r,g,b);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColor::getValue()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->getValue();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColor::setRed(r)
	double	r
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setRed(r);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColor::setGreen(g)
	double	g
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setGreen(g);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColor::setBlue(b)
	double	b
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setBlue(b);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFColor::getRed()
    CODE:
	RETVAL = THIS->getRed();
    OUTPUT:
RETVAL

double
SFColor::getGreen()
    CODE:
	RETVAL = THIS->getGreen();
    OUTPUT:
RETVAL

double
SFColor::getBlue()
    CODE:
	RETVAL = THIS->getBlue();
    OUTPUT:
RETVAL

void
SFColor::setHSV(h, s, v)
	double	h
	double	s
	double	v
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setHSV(h,s,v);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColor::getHSV()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->getHSV();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SFColor *
SFColor::negate(...)
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 1:
	s = ST(1);
	RETVAL = const_cast<SFColor *>(THIS->negate(s));
	break; /* case 1 */
default:
	RETVAL = const_cast<SFColor *>(THIS->negate());
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::add(v, ...)
	SFColor *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->add(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->add(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::subtract(v, ...)
	SFColor *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->subtract(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->subtract(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::multiply(v, ...)
	SFColor *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->multiply(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->multiply(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::lighten(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->lighten(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->lighten(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::divide(v, ...)
	SFColor *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->divide(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->divide(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColor *
SFColor::darken(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColor *>(THIS->darken(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColor *>(THIS->darken(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

void
SFColor::DESTROY()

MODULE = SFColor     	PACKAGE = main	

PROTOTYPES: DISABLE

