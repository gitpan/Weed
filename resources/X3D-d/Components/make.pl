#!/usr/bin/perl -w -I "~holger/perl"
use strict;
use warnings;

sub makepm {
	my $folder = shift; $folder =~ s/\.pm$//so;
	my $base = $folder =~ m|([^/]+)$|o ? $1 : return;

	#printf "%s\n", $base;
	my @nodes;

	open FILE, ">$folder/../$base.pm";

	print FILE <<EOT;
package X3D::Components::$base;
use strict;
use warnings;

use rlib "X3D/Components/$base";
use rlib "X3D/Components/$base/Nodes";

EOT

	@nodes = grep {/^X3D/} map { s/\.pm//; $_ } `ls -C1 $folder`;
	chomp @nodes;

	#printf "%s\n", join ", ", @nodes;
	print FILE "#Abstract node types\n";
	printf FILE "use $_;\n", $_ foreach @nodes;

	print FILE "\n";

	@nodes = map { s/\.pm//; $_ } `ls -C1 $folder/Nodes`;
	chomp @nodes;

	#printf "%s\n", join ", ", @nodes;
	print FILE "#Node set\n";
	printf FILE "use $_;\n", $_ foreach @nodes;

	print FILE <<EOT;

1;
__END__
EOT

	close FILE;
}

makepm($_) foreach @ARGV;

sleep 2;

1;
__END__
