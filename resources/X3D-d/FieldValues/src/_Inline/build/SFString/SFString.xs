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


class SFString {
	private:
		SV* value;

	public:
		SFString (char* v="") { value = newSVpvf(v); }
		~SFString () { SvREFCNT_dec(value); }

		inline const SFString* copy () { return new SFString(getValue()); }

		inline void setValue (char* v) { sv_setpvf(value, v); }
		inline char* getValue () { return SvPV_nolen(value); }
};


MODULE = SFString     	PACKAGE = main::SFString

PROTOTYPES: DISABLE

SFString *
SFString::new(...)
    PREINIT:
	char *	v;
    CODE:
switch(items-1) {
case 1:
	v = (char *)SvPV_nolen(ST(1));
	RETVAL = new SFString(v);
	break; /* case 1 */
default:
	RETVAL = new SFString();
} /* switch(items) */ 
    OUTPUT:
RETVAL

void
SFString::DESTROY()
    
SFString *
SFString::copy()
    CODE:
	RETVAL = const_cast<SFString *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFString::setValue(v)
	char *	v
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

char *
SFString::getValue()
    
MODULE = SFString     	PACKAGE = main	

PROTOTYPES: DISABLE

