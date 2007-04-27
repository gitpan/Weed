package Weed::Universum;
use strict;
use warnings;

our $VERSION = '0.0009';

use Weed;

use constant DESCRIPTION => '
X3DUniversum : X3DGroupingNode {
  MFNode  [in]     addChildren
  MFNode  [in]     removeChildren
  MFNode  [in,out] children       []       [X3DChildNode]
  SFNode  [in,out] metadata       NULL     [X3DMetadataObject]
  SFVec3f []       bboxCenter     0 0 0    (-\u221e,\u221e)
  SFVec3f []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121
}
';

sub new {
	my ($self, $name) = @_;
	my  $this = $self->SUPER::new($name);

	#$this->addChildren(new X3DBrowser);
	
	return $this;
}

sub createBrowser {
	my ($this) = @_;
	my $browser = new X3DBrowser;
	$this->addChildren($browser);
	return $browser;
}

sub getBrowser {
	my ($this) = @_;
	return $this->children ? $this->children->[0] : $this->createBrowser;
}

1;
__END__
