package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFNode";
	our $directory = "_Inline";
}

our ($VERSION, $package, $directory);

use Inline (CPP => 'DATA',
	NAME					=> $package,
#	VERSION 				=> $VERSION,
#	DIRECTORY 			=> $directory,
	TYPEMAPS				=> "map/$package.map",
#	LIBS					=> '-lfoo',
#	INC 					=> '-I/foo/include',
#	PREFIX				=> 'XXX_',
	FORCE_BUILD 		=> 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS				=> 0,
);

system "mkdir -p ../auto" unless -e "../auto";
system "chmod u+w ../auto/$package/*" if -e "../auto/$package";
#system "rm -r ../auto/$package" if -e "../auto/$package";
system "cp -r $directory/lib/auto/$package ../auto";

1;
__DATA__
__CPP__

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
