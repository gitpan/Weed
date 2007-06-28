#!/usr/bin/perl -w
#package 01_fieldDefinition
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}
use Weed::Perl;

is (X3DConstants->initializeOnly, 0);
is (X3DConstants->inputOnly,      1);
is (X3DConstants->outputOnly,     2);
is (X3DConstants->inputOutput,    3);

my $fieldDefinition1 = new X3DFieldDefinition( "SFNode", YES, YES, "name", "value", "range" );
ok $fieldDefinition1->isIn;
ok $fieldDefinition1->isOut;
is $fieldDefinition1->getAccessType, X3DConstants->inputOutput;
is $fieldDefinition1->getName, 'name';
is $fieldDefinition1->getValue, 'value';
is $fieldDefinition1->getRange, 'range';

1;
__END__

PROTO Particle [
  exposedField SFTime   cycleInterval	1
  exposedField SFBool   enabled	TRUE
  exposedField SFFloat  maximumSpeed	299792.458
  exposedField SFVec3f  translation	0 0 0
  exposedField SFVec3f  velocity	0 0 0
  exposedField SFVec3f  acceleration	0 0 0
  exposedField SFTime   startTime	0
  exposedField SFTime   stopTime	0
  eventOut     SFTime   cycleTime
  eventOut     SFFloat  fraction_changed
  eventOut     SFBool   isActive
  eventOut     SFTime   time
  eventIn      MFNode   addChildren
  eventIn      MFNode   removeChildren
  exposedField MFNode   children	[ ]
]
{
  PROTO Data [
    exposedField SFFloat  maximumSpeed	299792.458
    exposedField SFFloat  maximumSpeed2	0
    exposedField SFVec3f  translation	0 0 0
    exposedField SFVec3f  velocity	0 0 0
    exposedField SFVec3f  acceleration	0 0 0
    eventIn      MFNode   addChildren
    eventIn      MFNode   removeChildren
    exposedField MFNode   children	[ ]
  ]
  {
    Transform {
      translation IS translation
      children IS children
    }
  }

  DEF Data Data {
    maximumSpeed IS maximumSpeed
    translation IS translation
    velocity IS velocity
    acceleration IS acceleration
    children IS children
  }

  DEF _Particle Script {
    eventIn      SFFloat  set_maximumSpeed
    eventIn      SFBool   set_isActive
    eventIn      SFTime   set_cycleTime
    eventIn      SFTime   set_time
    field        SFVec3f  translation	0 0 0
    field        SFVec3f  velocity	0 0 0
    field        SFTime   lastTime	0
    field        SFNode   timeSensor	DEF Time TimeSensor {
      cycleInterval IS cycleInterval
      enabled IS enabled
      loop TRUE
      startTime IS startTime
      stopTime IS stopTime
    }
    field        SFNode   data	USE Data
    url "vrmlscript:
function rel_add3d (v, u) {
	return v.add(u).divide(1 + (Math.abs(v.dot(u)) / data.maximumSpeed2));
}

function set_maximumSpeed () {
	data.maximumSpeed2 = data.maximumSpeed * data.maximumSpeed;
}

function set_isActive (value, time) {
	if (value) {
		lastTime = time;
	}
}

function set_time (value, time) {
	deltaTime = time - lastTime;
	
	data.velocity  = rel_add3d(data.velocity, data.acceleration.multiply(deltaTime));
	data.translation = data.translation.add(data.velocity.multiply(deltaTime));

	lastTime = time;
}

function initialize () {
	set_maximumSpeed();
}
"
    mustEvaluate TRUE
    directOutput TRUE
  }

  ROUTE Data.maximumSpeed_changed TO _Particle.set_maximumSpeed
  ROUTE Time.isActive TO _Particle.set_isActive
  ROUTE Time.time TO _Particle.set_time
}


