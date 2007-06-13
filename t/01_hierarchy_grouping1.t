#!/usr/bin/perl -w
#package 01_hierarchy_grouping1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;
ok my $seed = new X3DGroupingNode;
isa_ok $seed, 'X3DNode';
isa_ok $seed, 'Weed::Components::Core::Node';
isa_ok $seed, 'X3DObject';
isa_ok $seed, 'Weed::Seed';
isa_ok $seed, 'X3DUniversal';
isa_ok $seed, 'Weed::Universal';
say;
say $seed;
say;
say $seed->Weed::Package::stringify;
say;
say 'Weed::Components::Grouping::GroupingNode'->Weed::Package::stringify;
say;
say 'X3DObject'->Weed::Package::stringify;
say;
say 'X3DNode'->Weed::Package::stringify;

is $seed->Weed::Package::stringify, 'X3DGroupingNode [ 
  Weed::Components::Grouping::GroupingNode []
  X3DChildNode [ 
    Weed::Components::Core::ChildNode []
    X3DNode [ 
      Weed::Components::Core::Node []
      X3DObject [ 
        Weed::Seed []
        X3DUniversal [ Weed::Universal [] ]
      ]
    ]
  ]
  X3DBoundedObject [ 
    Weed::Components::Grouping::BoundedObject []
    X3DObject [ 
      Weed::Seed []
      X3DUniversal [ Weed::Universal [] ]
    ]
  ]
]';

__END__

