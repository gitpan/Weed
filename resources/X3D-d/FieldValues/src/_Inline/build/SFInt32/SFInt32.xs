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


class SFInt32 {
	private:
		long value;

	public:
		SFInt32 (const long v=0) { setValue(v); }

		inline const SFInt32* copy () { return new SFInt32(value); }

		inline void setValue (const long v) { value = v; }
		inline const long getValue () { return value; }
};


MODULE = SFInt32     	PACKAGE = main::SFInt32

PROTOTYPES: DISABLE

SFInt32 *
SFInt32::new(...)
    PREINIT:
	long	v;
    CODE:
switch(items-1) {
case 1:
	v = (long)SvIV(ST(1));
	RETVAL = new SFInt32(v);
	break; /* case 1 */
default:
	RETVAL = new SFInt32();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFInt32 *
SFInt32::copy()
    CODE:
	RETVAL = const_cast<SFInt32 *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFInt32::setValue(v)
	long	v
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

long
SFInt32::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFInt32::DESTROY()

MODULE = SFInt32     	PACKAGE = main	

PROTOTYPES: DISABLE

