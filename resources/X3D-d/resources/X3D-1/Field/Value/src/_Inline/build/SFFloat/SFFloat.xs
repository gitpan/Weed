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
	public:
		float value;

		SFFloat (const float value=0) {
			setValue(value);
		}
		
		inline void setValue (const float value=0) {
			this->value = value;
		}
		
		inline const float getValue () {
			return value;
		}
};

MODULE = SFFloat     	PACKAGE = main::SFFloat

PROTOTYPES: DISABLE

SFFloat *
SFFloat::new(...)
    PREINIT:
	float	value;
    CODE:
switch(items-1) {
case 1:
	value = (float)SvNV(ST(1));
	RETVAL = new SFFloat(value);
	break; /* case 1 */
default:
	RETVAL = new SFFloat();
} /* switch(items) */ 
    OUTPUT:
RETVAL

void
SFFloat::setValue(...)
    PREINIT:
	I32 *	__temp_markstack_ptr;
	float	value;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
switch(items-1) {
case 1:
	value = (float)SvNV(ST(1));
THIS->setValue(value);
	break; /* case 1 */
default:
THIS->setValue();
} /* switch(items) */ 
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

float
SFFloat::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFFloat::DESTROY()

MODULE = SFFloat     	PACKAGE = main	

PROTOTYPES: DISABLE

