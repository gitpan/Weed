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


class SFNode {
	private:
		SV* value;

	public:
		SFNode (SV* sv=&PL_sv_no) {
			value = SvREFCNT_inc(&PL_sv_no); //initialize value
			setValue(sv);
		}
		
		~SFNode () {
			SvREFCNT_dec(value);
		}

		inline const SFNode* copy () { return new SFNode(value); }

		inline void setValue (SV* sv) {
			// test !defined(sv), sv(false), undef  then sv = false
			if (!SvOK(sv) || !sv_true(sv) || sv == &PL_sv_undef) sv = &PL_sv_no;

			if (sv == &PL_sv_no || (sv_isobject(sv) && sv_derived_from(sv, "X3DNode"))) {
				SvREFCNT_dec(value);
				value = SvREFCNT_inc(sv);
			} else {			
				Perl_croak(aTHX_ "Usage: SFNode::setValue(THIS, value:X3DNode) value is not of type X3DNode");
			}

		}

		inline const SV* getValue () { return SvREFCNT_inc(value); }

		inline const long getReferenceCount () { return value == &PL_sv_no ? 0 : SvREFCNT(value); }
};

/*
class SFNode {
	private:
		SV* value;

	public:
		SFNode (SV* sv=&PL_sv_no) {
			value = SvREFCNT_inc(&PL_sv_no); //initialize value
			setValue(sv);
		}
		
		~SFNode () {
			if (value != &PL_sv_no) SvREFCNT_dec(SvRV(value));
			SvREFCNT_dec(value);
		}

		inline const SFNode* copy () { return new SFNode(value); }

		inline void setValue (SV* sv) {
			// test !defined(sv), sv(false), undef  then sv = false
			if (!SvOK(sv) || !sv_true(sv) || sv == &PL_sv_undef) sv = &PL_sv_no;

			if (sv == &PL_sv_no || (sv_isobject(sv) && sv_derived_from(sv, "X3DNode"))) {
				if (value != &PL_sv_no) SvREFCNT_dec(SvRV(value));
				SvREFCNT_dec(value);
				value = SvREFCNT_inc(sv);
				if (value != &PL_sv_no) SvREFCNT_inc(SvRV(value));
			} else {			
				Perl_croak(aTHX_ "Usage: SFNode::setValue(THIS, value:X3DNode) value is not of type X3DNode");
			}

		}

		inline const SV* getValue () { return SvREFCNT_inc(value); }

		inline const long getReferenceCount () { return value == &PL_sv_no ? 0 : SvREFCNT(SvRV(value)); }
};
*/

MODULE = SFNode     	PACKAGE = main::SFNode

PROTOTYPES: DISABLE

SFNode *
SFNode::new(...)
    PREINIT:
	SV *	sv;
    CODE:
switch(items-1) {
case 1:
	sv = ST(1);
	RETVAL = new SFNode(sv);
	break; /* case 1 */
default:
	RETVAL = new SFNode();
} /* switch(items) */ 
    OUTPUT:
RETVAL

void
SFNode::DESTROY()
    
SFNode *
SFNode::copy()
    CODE:
	RETVAL = const_cast<SFNode *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFNode::setValue(sv)
	SV *	sv
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(sv);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
SFNode::getValue()
    CODE:
	RETVAL = const_cast<SV *>(THIS->getValue());
    OUTPUT:
RETVAL

long
SFNode::getReferenceCount()
    CODE:
	RETVAL = THIS->getReferenceCount();
    OUTPUT:
RETVAL

MODULE = SFNode     	PACKAGE = main	

PROTOTYPES: DISABLE

