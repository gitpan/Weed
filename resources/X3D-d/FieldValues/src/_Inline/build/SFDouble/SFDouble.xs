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


class SFDouble {
	private:
		double value;

	public:
		SFDouble (const double v=0) { setValue(v); }

		inline const SFDouble* copy () { return new SFDouble(value); }

		inline void setValue (const double v) { value = v; }
		inline const double getValue () { return value; }
};


MODULE = SFDouble     	PACKAGE = main::SFDouble

PROTOTYPES: DISABLE

SFDouble *
SFDouble::new(...)
    PREINIT:
	double	v;
    CODE:
switch(items-1) {
case 1:
	v = (double)SvNV(ST(1));
	RETVAL = new SFDouble(v);
	break; /* case 1 */
default:
	RETVAL = new SFDouble();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFDouble *
SFDouble::copy()
    CODE:
	RETVAL = const_cast<SFDouble *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFDouble::setValue(v)
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
SFDouble::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFDouble::DESTROY()

MODULE = SFDouble     	PACKAGE = main	

PROTOTYPES: DISABLE

