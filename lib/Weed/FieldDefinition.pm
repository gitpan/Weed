package Weed::FieldDefinition;

use Weed 'X3DFieldDefinition { }';

#  exposedField SFFloat  maximumSpeed	299792.458 #[0,1]

sub create {
	my ( $this, $type, $in, $out, @args ) = @_;

	$this->{type} = $type;

	$this->setInOut( $in, $out );
	@$this{qw'name value range'} = @args;

	return;
}

sub isIn  { $_[0]->{in} }
sub isOut { $_[0]->{out} }

sub setInOut {
	my ( $this, $in, $out ) = @_;
	$this->{in}  = $in  ? X3DConstants->TRUE: X3DConstants->FALSE;
	$this->{out} = $out ? X3DConstants->TRUE: X3DConstants->FALSE;
	return;
}

sub getType { $_[0]->{type} }

sub getAccessType { ( $_[0]->{out} << 1 ) | $_[0]->{in} }

sub getName { $_[0]->{name} }

sub getValue { $_[0]->{value} }

sub getRange { $_[0]->{range} }

sub createField {
	my ( $this, $node ) = @_;

	my $field = $this->getType->new( $this->{value} );
	$field->setDefinition($this);
	return $field;
}

sub shutdown {
	printf "%s->%s %s\n", $_[0]->getType, $_[0]->Weed::Package::sub, $_[0];
}

1;
__END__

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= $X3DGenerator::AccessTypes->[ $this->getAccessType ];
	$string .= $X3DGenerator::SPACE;
	$string .= $this->getType;
	$string .= $X3DGenerator::SPACE;
	$string .= $this->SUPER::toString;

	return $string;
}

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



