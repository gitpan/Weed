package VRML::Field::MFNode;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::MField;
@ISA = qw(VRML::MField);

use overload
	'push' => \&push,
	'""' => \&toString;

use VRML::Generator qw($TIDY_SPACE $TIDY_BREAK $BREAK indent $DEEP);

sub push {
	my $this  = CORE::shift;
	my $nodes = CORE::shift;
	CORE::push @{ $this }, @{ $nodes };
	return;

	#my $this = CORE::shift;
	my @values = map {
		ref $_ eq "ARRAY" ?
		@{$_} :
		(ref $_ eq "MFNode" ?
			@{$_->getValue} :			
			$_
		)
	} @_;

	CORE::push @{ $this }, @values;

	foreach (@values) {
		return unless $_->getValue->getName;

		#print $_->getValue->getName, " ";
		#print exists $_->getValue->{browser}->{node}->{$_->getValue->getName}, "\n";

		if (exists $_->getValue->{browser}->{node}->{$_->getValue->getName}) {
			$_->getValue->{clones} =
			$_->getValue->{browser}->{node}->{$_->getValue->getName}->{clones};

			CORE::push @{$_->getValue->{clones}}, $_->getValue;
			$_->getValue->setName($_->getValue->getName);
		} else {
			$_->getValue->{browser}->{node}->{$_->getValue->getName} =
			$_->getValue;
		}
	}
}

sub index {
	my $this  = CORE::shift;
	my $key   = CORE::shift;
	my $index = 0;
	foreach (@{$this}) {
		if (ref($key) eq "VRML::Node::Node") {
			last if $_->getValue eq $key;
		} elsif (ref($_) eq "SFNode") {
			last if $_ eq $key;
		}
		++$index;
	}
	return $index < $this  ? $index : -1;
}

sub remove {
	my $this = CORE::shift;
	my @remove;
	foreach (@_) {
		my $i = $this->index($_);
		if ($i > -1) {
			my $node = $this->splice($i, 1);
			$node->getValue->delete;
			CORE::push @remove, $node;
		}
	}
	return @remove;
}

sub toString {
	my $this   = shift;
	return "[$TIDY_SPACE]" unless @{ $this };

	my $string ;
	
	if ($#{ $this }) {
		$DEEP++;
		$string = "[".$TIDY_BREAK.indent;
		
		$string .= join $BREAK.indent, @{$this};
		--$DEEP;
		$string .= $TIDY_BREAK.indent."]";
	} else {
		$string = "@{$this}";
	}

	return $string;
}

1;
__END__
