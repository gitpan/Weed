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


MODULE = SFVec2f     	PACKAGE = main::SFVec2f

PROTOTYPES: DISABLE

SFVec2f *
SFVec2f::new(...)
    PREINIT:
	double	x;
	double	y;
    CODE:
switch(items-1) {
case 1:
	x = (double)SvNV(ST(1));
	RETVAL = new SFVec2f(x);
	break; /* case 1 */
case 2:
	x = (double)SvNV(ST(1));
	y = (double)SvNV(ST(2));
	RETVAL = new SFVec2f(x,y);
	break; /* case 2 */
default:
	RETVAL = new SFVec2f();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::copy()
    CODE:
	RETVAL = const_cast<SFVec2f *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFVec2f::setValue(x, y)
	double	x
	double	y
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(x,y);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFVec2f::getValue()
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
SFVec2f::setX(x)
	double	x
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setX(x);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFVec2f::setY(y)
	double	y
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setY(y);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFVec2f::getX()
    CODE:
	RETVAL = THIS->getX();
    OUTPUT:
RETVAL

double
SFVec2f::getY()
    CODE:
	RETVAL = THIS->getY();
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::negate(...)
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 1:
	s = ST(1);
	RETVAL = const_cast<SFVec2f *>(THIS->negate(s));
	break; /* case 1 */
default:
	RETVAL = const_cast<SFVec2f *>(THIS->negate());
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::add(v, ...)
	SFVec2f *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec2f *>(THIS->add(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec2f *>(THIS->add(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::subtract(v, ...)
	SFVec2f *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec2f *>(THIS->subtract(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec2f *>(THIS->subtract(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::multiply(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec2f *>(THIS->multiply(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec2f *>(THIS->multiply(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::divide(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec2f *>(THIS->divide(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec2f *>(THIS->divide(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

double
SFVec2f::dot(v, ...)
	SFVec2f *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = THIS->dot(v,s);
	break; /* case 2 */
default:
	RETVAL = THIS->dot(v);
} /* switch(items) */ 
    OUTPUT:
RETVAL

double
SFVec2f::length(...)
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 1:
	s = ST(1);
	RETVAL = THIS->length(s);
	break; /* case 1 */
default:
	RETVAL = THIS->length();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec2f *
SFVec2f::normalize()
    CODE:
	RETVAL = const_cast<SFVec2f *>(THIS->normalize());
    OUTPUT:
RETVAL

void
SFVec2f::DESTROY()

MODULE = SFVec2f     	PACKAGE = main	

PROTOTYPES: DISABLE

