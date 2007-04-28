package Weed::Browser;
use strict;
use warnings;

our $VERSION = '0.0013';

use Weed '
X3DBrowser : X3DGroupingNode {
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
	my $this = $self->SUPER::new;
	$this->setName($this->getType);
	return $this;
}

1;
__END__
