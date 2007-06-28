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


class SFFloat {
	private:
		double value;

	public:
		SFFloat (const double v=0) { setValue(v); }

		inline const SFFloat* copy () { return new SFFloat(value); }

		inline void setValue (const double v) { value = v; }
		inline const double getValue () { return value; }

		//inline void madd      (const double v) { value += v; }
		//inline void msubtract (const double v) { value -= v; }
		//inline void mmultiply (const double v) { value *= v; }
		//inline void mdivide   (const double v) { value /= v; }
	
		//inline const SFFloat* add      (const double v) { return new SFFloat(value + v); }
		//inline const SFFloat* subtract (const double v) { return new SFFloat(value - v); }
		//inline const SFFloat* multiply (const double v) { return new SFFloat(value * v); }
		//inline const SFFloat* divide   (const double v) { return new SFFloat(value / v); }
};


MODULE = SFFloat     	PACKAGE = main::SFFloat

PROTOTYPES: DISABLE

SFFloat *
SFFloat::new(...)
    PREINIT:
	double	v;
    CODE:
switch(items-1) {
case 1:
	v = (double)SvNV(ST(1));
	RETVAL = new SFFloat(v);
	break; /* case 1 */
default:
	RETVAL = new SFFloat();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFFloat *
SFFloat::copy()
    CODE:
	RETVAL = const_cast<SFFloat *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFFloat::setValue(v)
	double	v
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(v);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFFloat::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFFloat::DESTROY()

MODULE = SFFloat     	PACKAGE = main	

PROTOTYPES: DISABLE

