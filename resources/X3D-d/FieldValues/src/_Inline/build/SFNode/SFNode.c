/*
 * This file was generated automatically by xsubpp version 1.9508 from the
 * contents of SFNode.xs. Do not edit this file, edit SFNode.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST!
 *
 */

#line 1 "SFNode.xs"
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

#line 99 "SFNode.c"
XS(XS_main__SFNode_new); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_new)
{
    dXSARGS;
    if (items < 1)
	Perl_croak(aTHX_ "Usage: main::SFNode::new(CLASS, ...)");
    {
#line 96 "SFNode.xs"
	SV *	sv;
#line 109 "SFNode.c"
	char *	CLASS = (char *)SvPV_nolen(ST(0));
	SFNode *	RETVAL;
#line 98 "SFNode.xs"
switch(items-1) {
case 1:
	sv = ST(1);
	RETVAL = new SFNode(sv);
	break; /* case 1 */
default:
	RETVAL = new SFNode();
} /* switch(items) */ 
#line 121 "SFNode.c"
	ST(0) = sv_newmortal();
    sv_setref_pv( ST(0), "SFNode", (void*)RETVAL );


    }
    XSRETURN(1);
}

XS(XS_main__SFNode_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_DESTROY)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: main::SFNode::DESTROY(THIS)");
    {
	SFNode *	THIS;

    if (sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG)) {
        THIS = (SFNode *)SvIV((SV*)SvRV( ST(0) ));
    }
    else {
        warn ( "SFNode::() -- THIS is not a blessed reference" );
        XSRETURN_UNDEF;
    };

	delete THIS;
    }
    XSRETURN_EMPTY;
}

XS(XS_main__SFNode_copy); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_copy)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: main::SFNode::copy(THIS)");
    {
	SFNode *	THIS;
	SFNode *	RETVAL;

    if (sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG)) {
        THIS = (SFNode *)SvIV((SV*)SvRV( ST(0) ));
    }
    else {
        warn ( "SFNode::() -- THIS is not a blessed reference" );
        XSRETURN_UNDEF;
    };
#line 115 "SFNode.xs"
	RETVAL = const_cast<SFNode *>(THIS->copy());
#line 171 "SFNode.c"
	ST(0) = sv_newmortal();
    sv_setref_pv( ST(0), "SFNode", (void*)RETVAL );


    }
    XSRETURN(1);
}

XS(XS_main__SFNode_setValue); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_setValue)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: main::SFNode::setValue(THIS, sv)");
    SP -= items;
    {
	SV *	sv = ST(1);
#line 123 "SFNode.xs"
	I32 *	__temp_markstack_ptr;
#line 191 "SFNode.c"
	SFNode *	THIS;

    if (sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG)) {
        THIS = (SFNode *)SvIV((SV*)SvRV( ST(0) ));
    }
    else {
        warn ( "SFNode::() -- THIS is not a blessed reference" );
        XSRETURN_UNDEF;
    };
#line 125 "SFNode.xs"
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(sv);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */
#line 211 "SFNode.c"
	PUTBACK;
	return;
    }
}

XS(XS_main__SFNode_getValue); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_getValue)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: main::SFNode::getValue(THIS)");
    {
	SFNode *	THIS;
	SV *	RETVAL;

    if (sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG)) {
        THIS = (SFNode *)SvIV((SV*)SvRV( ST(0) ));
    }
    else {
        warn ( "SFNode::() -- THIS is not a blessed reference" );
        XSRETURN_UNDEF;
    };
#line 138 "SFNode.xs"
	RETVAL = const_cast<SV *>(THIS->getValue());
#line 236 "SFNode.c"
	ST(0) = RETVAL;
	sv_2mortal(ST(0));
    }
    XSRETURN(1);
}

XS(XS_main__SFNode_getReferenceCount); /* prototype to pass -Wmissing-prototypes */
XS(XS_main__SFNode_getReferenceCount)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: main::SFNode::getReferenceCount(THIS)");
    {
	SFNode *	THIS;
	long	RETVAL;
	dXSTARG;

    if (sv_isobject(ST(0)) && (SvTYPE(SvRV(ST(0))) == SVt_PVMG)) {
        THIS = (SFNode *)SvIV((SV*)SvRV( ST(0) ));
    }
    else {
        warn ( "SFNode::() -- THIS is not a blessed reference" );
        XSRETURN_UNDEF;
    };
#line 145 "SFNode.xs"
	RETVAL = THIS->getReferenceCount();
#line 263 "SFNode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_SFNode); /* prototype to pass -Wmissing-prototypes */
XS(boot_SFNode)
{
    dXSARGS;
    char* file = __FILE__;

    XS_VERSION_BOOTCHECK ;

        newXS("main::SFNode::new", XS_main__SFNode_new, file);
        newXS("main::SFNode::DESTROY", XS_main__SFNode_DESTROY, file);
        newXS("main::SFNode::copy", XS_main__SFNode_copy, file);
        newXS("main::SFNode::setValue", XS_main__SFNode_setValue, file);
        newXS("main::SFNode::getValue", XS_main__SFNode_getValue, file);
        newXS("main::SFNode::getReferenceCount", XS_main__SFNode_getReferenceCount, file);
    XSRETURN_YES;
}

