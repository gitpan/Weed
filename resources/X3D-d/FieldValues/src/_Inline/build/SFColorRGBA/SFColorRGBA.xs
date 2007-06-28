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


MODULE = SFColorRGBA     	PACKAGE = main::SFColorRGBA

PROTOTYPES: DISABLE

SFColorRGBA *
SFColorRGBA::new(...)
    PREINIT:
	double	r;
	double	g;
	double	b;
	double	a;
    CODE:
switch(items-1) {
case 1:
	r = (double)SvNV(ST(1));
	RETVAL = new SFColorRGBA(r);
	break; /* case 1 */
case 2:
	r = (double)SvNV(ST(1));
	g = (double)SvNV(ST(2));
	RETVAL = new SFColorRGBA(r,g);
	break; /* case 2 */
case 3:
	r = (double)SvNV(ST(1));
	g = (double)SvNV(ST(2));
	b = (double)SvNV(ST(3));
	RETVAL = new SFColorRGBA(r,g,b);
	break; /* case 3 */
case 4:
	r = (double)SvNV(ST(1));
	g = (double)SvNV(ST(2));
	b = (double)SvNV(ST(3));
	a = (double)SvNV(ST(4));
	RETVAL = new SFColorRGBA(r,g,b,a);
	break; /* case 4 */
default:
	RETVAL = new SFColorRGBA();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::copy()
    CODE:
	RETVAL = const_cast<SFColorRGBA *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFColorRGBA::setValue(r, g, b, a)
	double	r
	double	g
	double	b
	double	a
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(r,g,b,a);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFColorRGBA::getValue()
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
SFColorRGBA::setRed(r)
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
SFColorRGBA::setGreen(g)
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
SFColorRGBA::setBlue(b)
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

void
SFColorRGBA::setAlpha(b)
	double	b
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setAlpha(b);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFColorRGBA::getRed()
    CODE:
	RETVAL = THIS->getRed();
    OUTPUT:
RETVAL

double
SFColorRGBA::getGreen()
    CODE:
	RETVAL = THIS->getGreen();
    OUTPUT:
RETVAL

double
SFColorRGBA::getBlue()
    CODE:
	RETVAL = THIS->getBlue();
    OUTPUT:
RETVAL

double
SFColorRGBA::getAlpha()
    CODE:
	RETVAL = THIS->getAlpha();
    OUTPUT:
RETVAL

void
SFColorRGBA::setHSV(h, s, v)
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
SFColorRGBA::getHSV()
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

SFColorRGBA *
SFColorRGBA::negate(...)
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 1:
	s = ST(1);
	RETVAL = const_cast<SFColorRGBA *>(THIS->negate(s));
	break; /* case 1 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->negate());
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::add(v, ...)
	SFColorRGBA *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->add(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->add(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::subtract(v, ...)
	SFColorRGBA *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->subtract(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->subtract(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::multiply(v, ...)
	SFColorRGBA *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->multiply(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->multiply(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::lighten(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->lighten(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->lighten(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::divide(v, ...)
	SFColorRGBA *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->divide(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->divide(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFColorRGBA *
SFColorRGBA::darken(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFColorRGBA *>(THIS->darken(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFColorRGBA *>(THIS->darken(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

void
SFColorRGBA::DESTROY()

MODULE = SFColorRGBA     	PACKAGE = main	

PROTOTYPES: DISABLE

