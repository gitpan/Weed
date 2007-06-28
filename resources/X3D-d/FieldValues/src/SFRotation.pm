package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFRotation";
	our $directory = "_Inline";
}

our ($VERSION, $package, $directory);

use Inline (CPP => 'DATA',
	NAME					=> $package,
#	VERSION 				=> $VERSION,
#	DIRECTORY 			=> $directory,
	TYPEMAPS				=> "map/$package.map",
#	LDDLFLAGS			=> "-shared -L/usr/local/lib ../SFVec3f/SFVec3f.o",
#	LIBS					=> '-lauto/SFVec3f/SFVec3f.so',
#	MYEXTLIB 			=> '/home/holger/perl/X3D/Fields/auto/SFVec3f/SFVec3f.so',
#	INC 					=> '-I/foo/include',
#	PREFIX				=> 'XXX_',
	FORCE_BUILD 		=> 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS				=> 0,
);

system "mkdir -p ../auto" unless -e "../auto";
system "rm -r ../auto/$package" if -e "../auto/$package";
system "cp -r $directory/lib/auto/$package ../auto";

1;
__DATA__
__CPP__

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
		SFRotation (...) {
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
