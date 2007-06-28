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


MODULE = SFVec3d     	PACKAGE = main::SFVec3d

PROTOTYPES: DISABLE

SFVec3d *
SFVec3d::new(...)
    PREINIT:
	double	x;
	double	y;
	double	z;
    CODE:
switch(items-1) {
case 1:
	x = (double)SvNV(ST(1));
	RETVAL = new SFVec3d(x);
	break; /* case 1 */
case 2:
	x = (double)SvNV(ST(1));
	y = (double)SvNV(ST(2));
	RETVAL = new SFVec3d(x,y);
	break; /* case 2 */
case 3:
	x = (double)SvNV(ST(1));
	y = (double)SvNV(ST(2));
	z = (double)SvNV(ST(3));
	RETVAL = new SFVec3d(x,y,z);
	break; /* case 3 */
default:
	RETVAL = new SFVec3d();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::copy()
    CODE:
	RETVAL = const_cast<SFVec3d *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFVec3d::setValue(x, y, z)
	double	x
	double	y
	double	z
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(x,y,z);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SFVec3d::getValue()
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
SFVec3d::setX(x)
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
SFVec3d::setY(y)
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

void
SFVec3d::setZ(z)
	double	z
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setZ(z);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFVec3d::getX()
    CODE:
	RETVAL = THIS->getX();
    OUTPUT:
RETVAL

double
SFVec3d::getY()
    CODE:
	RETVAL = THIS->getY();
    OUTPUT:
RETVAL

double
SFVec3d::getZ()
    CODE:
	RETVAL = THIS->getZ();
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::negate(...)
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 1:
	s = ST(1);
	RETVAL = const_cast<SFVec3d *>(THIS->negate(s));
	break; /* case 1 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->negate());
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::add(v, ...)
	SFVec3d *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec3d *>(THIS->add(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->add(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::subtract(v, ...)
	SFVec3d *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec3d *>(THIS->subtract(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->subtract(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::multiply(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec3d *>(THIS->multiply(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->multiply(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFVec3d *
SFVec3d::divide(v, ...)
	double	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec3d *>(THIS->divide(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->divide(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

double
SFVec3d::dot(v, ...)
	SFVec3d *	v
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

SFVec3d *
SFVec3d::cross(v, ...)
	SFVec3d *	v
    PREINIT:
	SV *	s;
    CODE:
switch(items-1) {
case 2:
	s = ST(2);
	RETVAL = const_cast<SFVec3d *>(THIS->cross(v,s));
	break; /* case 2 */
default:
	RETVAL = const_cast<SFVec3d *>(THIS->cross(v));
} /* switch(items) */ 
    OUTPUT:
RETVAL

double
SFVec3d::length(...)
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

SFVec3d *
SFVec3d::normalize()
    CODE:
	RETVAL = const_cast<SFVec3d *>(THIS->normalize());
    OUTPUT:
RETVAL

void
SFVec3d::DESTROY()

MODULE = SFVec3d     	PACKAGE = main	

PROTOTYPES: DISABLE

