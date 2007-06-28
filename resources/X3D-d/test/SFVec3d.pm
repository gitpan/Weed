#!perl -w -I "~holger/perl"
use strict;
use warnings;

package vec3;


use overload 
	'@{}' => sub { $_[0]->{value} },
;

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = bless {}, $class;
	$this->{name} = "translation";
	$this->{value} = [@_];

	return $this;
}

sub x : lvalue { $_[0]->{value}->[0] }

sub add1 {
	my ($this, $value) = @_;
	
	my ($x1, $y1, $z1) = @{$this->{value}};
	my ($x2, $y2, $z2) = @{$value->{value}};
	
	return new vec3 (
		$x1 + $x2,
		$y1 + $y2,
		$z1 + $z2,
	);
}

1;

use X3D;
use Time::HiRes qw(time);

my $v1 = new SFVec3f (1,2,3);
my $v2 = new SFVec3f (2,3,4);

printf "%s\n", ref $v1;
printf "%s\n", ref $v2;
printf "%s\n", $v1;
printf "%s\n", $v2;

use Benchmark;
my $v = undef;
timethis(100000, sub { $v = $v1->add($v2) });
printf "%s\n", $v;

my $w1 = new vec3 (1,2,3);
my $w2 = new vec3 (2,3,4);
my $w;
timethis(100000, sub { $w = $w1->add1($w2) });
printf "%s\n", join " ", @{$w->{value}};

my $f = new SFFloat(345);
$f = 2;

$w->x = 123;
$w->[1] = 234;
$w->[2] = $f;
printf "%s\n", join " ", @$w;

#$timeSensor->enabled = 1;
#$timeSensor->enabled = $timeSensor->cycleInterval;
#$cycleInterval = $timeSensor->cycleInterval;
#$cycleInterval->getName;
#$cycleInterval = 1;
#$transform->translation = new SFVec3f(1,2,3);
#$transform->translation->x = 7;
#$transform->translation->[0] = 7;
#$transform->translation->[0] = $timeSensor->cycleInterval;

1;
__END__
