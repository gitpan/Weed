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


class SFBool {
	private:
		int value;

	public:
		SFBool (const int v=0) { setValue(v); }

		inline const SFBool* copy () { return new SFBool(value); }
		
		inline void setValue (const int v) { value = v ? 1 : 0; }
		inline const int getValue () { return value; }
};


MODULE = SFBool     	PACKAGE = main::SFBool

PROTOTYPES: DISABLE

SFBool *
SFBool::new(...)
    PREINIT:
	int	v;
    CODE:
switch(items-1) {
case 1:
	v = (int)SvIV(ST(1));
	RETVAL = new SFBool(v);
	break; /* case 1 */
default:
	RETVAL = new SFBool();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFBool *
SFBool::copy()
    CODE:
	RETVAL = const_cast<SFBool *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFBool::setValue(v)
	int	v
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

int
SFBool::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFBool::DESTROY()

MODULE = SFBool     	PACKAGE = main	

PROTOTYPES: DISABLE

