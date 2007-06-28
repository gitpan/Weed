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


#include "Quaternion.cpp"

class SFRotation {
	public:
		SFVec3f* axis;
		double angle;
		Quaternion* q;

	private:
		SFRotation (Quaternion* q) {
			axis  = new SFVec3f();
 			angle = 0;
			this->q = q;
			this->q->getAxisAngle(axis, angle);
		}

	public:
		SFRotation (   ) {
			Inline_Stack_Vars;
			switch (Inline_Stack_Items-1) {
				case 0:
					axis  = new SFVec3f(0,0,1);
					angle = 0;
					q     = new Quaternion();
					break;
				case 1: break;
				case 2:
					if (sv_isobject(Inline_Stack_Item(1)) && (SvTYPE(SvRV(Inline_Stack_Item(1))) == SVt_PVMG)) {
						if (sv_isobject(Inline_Stack_Item(2)) && (SvTYPE(SvRV(Inline_Stack_Item(2))) == SVt_PVMG)) {
							axis  = new SFVec3f();
							angle = 0;
							q     = new Quaternion(
								(SFVec3f*)SvIV((SV*)SvRV(Inline_Stack_Item(1))),
								(SFVec3f*)SvIV((SV*)SvRV(Inline_Stack_Item(2)))
							);
							q->getAxisAngle(axis, angle);
						}
				   	else {
							axis  = ((SFVec3f*)SvIV((SV*)SvRV(Inline_Stack_Item(1))))->copy();
							angle = SvNV(Inline_Stack_Item(2));
							q     = new Quaternion(axis, angle);
				   	}
					}
				   else {
				   	warn ( "SFRotation::new(vec1, angle | vec2) -- vec1 is not a blessed reference" );
				   	XSRETURN_UNDEF;
				   }
					break;
				case 3: break;
				case 4:
					axis  = new SFVec3f(
						SvNV(Inline_Stack_Item(1)),
						SvNV(Inline_Stack_Item(2)),
						SvNV(Inline_Stack_Item(3))
					);
					angle = SvNV(Inline_Stack_Item(4));
					q     = new Quaternion(axis, angle);
					break;
				default:
					break;
			}
		}
		
		~SFRotation () { delete axis; delete q; }

		//inline const SFRotation* copy () { return new SFRotation(axis,angle); }
		
		inline void setX     (const double x) { this->axis->x = x; q->setRotation(axis, angle); }
		inline void setY     (const double y) { this->axis->y = y; q->setRotation(axis, angle); }
		inline void setZ     (const double z) { this->axis->z = z; q->setRotation(axis, angle); }
		inline void setAngle (const double a) { this->angle   = a; q->setRotation(axis, angle); }

		inline const double getX     () { return axis->x; }
		inline const double getY     () { return axis->y; }
		inline const double getZ     () { return axis->z; }
		inline const double getAngle () { return   angle; }
		
		inline const SFVec3f* getAxis() { return axis->copy(); }
		
		inline const SFRotation* inverse() { return new SFRotation (q->inverse()); }
		
		inline const SFRotation* multiply(const SFRotation* rotation) {
			return new SFRotation (q->multiply(rotation->q)); 
		}
		
		inline const SFVec3f* multVec(const SFVec3f* vec) {
			return q->multVec(vec); 
		}
		
		inline void setAxis(const SFVec3f* v) {
			axis->setValue(v->x, v->y, v->z);
			q->setRotation(axis, angle);
		}
		
		inline const SFRotation* slerp(const SFRotation* destRotation, const double t) {
			return new SFRotation (q->slerp(destRotation->q, t)); 
		}

};

MODULE = SFRotation     	PACKAGE = main::SFRotation

PROTOTYPES: DISABLE

SFRotation *
SFRotation::new(...)
    PREINIT:
	I32 *	__temp_markstack_ptr;
    CODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	RETVAL = new SFRotation();
	PL_markstack_ptr = __temp_markstack_ptr;
    OUTPUT:
RETVAL

void
SFRotation::DESTROY()
    
void
SFRotation::setX(x)
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
SFRotation::setY(y)
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
SFRotation::setZ(z)
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

void
SFRotation::setAngle(a)
	double	a
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setAngle(a);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFRotation::getX()
    CODE:
	RETVAL = THIS->getX();
    OUTPUT:
RETVAL

double
SFRotation::getY()
    CODE:
	RETVAL = THIS->getY();
    OUTPUT:
RETVAL

double
SFRotation::getZ()
    CODE:
	RETVAL = THIS->getZ();
    OUTPUT:
RETVAL

double
SFRotation::getAngle()
    CODE:
	RETVAL = THIS->getAngle();
    OUTPUT:
RETVAL

SFVec3f *
SFRotation::getAxis()
    CODE:
	RETVAL = const_cast<SFVec3f *>(THIS->getAxis());
    OUTPUT:
RETVAL

SFRotation *
SFRotation::inverse()
    CODE:
	RETVAL = const_cast<SFRotation *>(THIS->inverse());
    OUTPUT:
RETVAL

SFRotation *
SFRotation::multiply(rotation)
	SFRotation *	rotation
    CODE:
	RETVAL = const_cast<SFRotation *>(THIS->multiply(rotation));
    OUTPUT:
RETVAL

SFVec3f *
SFRotation::multVec(vec)
	SFVec3f *	vec
    CODE:
	RETVAL = const_cast<SFVec3f *>(THIS->multVec(vec));
    OUTPUT:
RETVAL

void
SFRotation::setAxis(v)
	SFVec3f *	v
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setAxis(v);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SFRotation *
SFRotation::slerp(destRotation, t)
	SFRotation *	destRotation
	double	t
    CODE:
	RETVAL = const_cast<SFRotation *>(THIS->slerp(destRotation,t));
    OUTPUT:
RETVAL

MODULE = SFRotation     	PACKAGE = main	

PROTOTYPES: DISABLE

