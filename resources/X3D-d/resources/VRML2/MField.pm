package VRML2::MField;
use strict;

BEGIN {
	use Carp;

	use VRML2::Array qw(array_ncmp);

	use VRML2::Generator;

	use VRML2::Console;
}

use overload

	"<=>" => \&ncmp,
	"=="  => \&neq,
	"!="  => \&nne,

	#"ne" => \&nne,

	'""' => \&toString;

sub new {
	my $self  = CORE::shift;
	my $class = ref($self) || $self;
	my $this  = [];

	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub copy {
	my $this = shift;
	my $copy = $this->new($this->getValue);
	return $copy;
}

sub ncmp {
	return array_ncmp($_[0], $_[1]);
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { ($_[0] <=> $_[1]) && 1 }


sub getValue {
	my $this = CORE::shift;
	return [@{$this}];
}

sub get1Value {
	my $this  = CORE::shift;
	my $index = CORE::shift;
	$this->length($index + 1) if $#{$this} < $index;
	return $this->[$index];
}

sub setValue {
	my $this = CORE::shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			$this->length(scalar @{$_[0]});

			for (my $i = 0; $i < @{$_[0]}; ++$i) {
				$this->[$i]->setValue($_[0]->[$i]->getValue);
			}
		} elsif (substr(ref $_[0], 0,2) eq 'MF') {
			$this->length(scalar @{$_[0]});

			for (my $i = 0; $i < @{$_[0]}; ++$i) {
				$this->[$i]->setValue($_[0]->[$i]->getValue);
			}
		} else {
			$this->length(scalar @_);

			for (my $i = 0; $i < @_; ++$i) {
				$this->[$i]->setValue($_[$i]->getValue);
			}
		}
	} else {
		@{$this} = ();
	}
	return $this;
}

sub set1Value {
	my $this  = CORE::shift;
	my $index = CORE::shift;
	my $value = CORE::shift;
	$this->length($index + 1) if $#{$this} < $index;
	$this->[$index]->setValue($value);
}

sub length  {
	my $this = CORE::shift;

	my $ref    = ref $this;
	my $length = @{$this};
	#print CONSOLE " VRML2::MField::length $ref: $length -> @_\n";

	if (@_) {
		my $length = CORE::shift;
		if ($length < @{$this}) {
			# decrease size
			@{$this} = splice(@{$this}, $length);
		} else {
			# increase size
			$this->increaseSize($length);
		}
	}

	return scalar @{$this};
}

# template function
sub increaseSize  {
	my $this   = CORE::shift;
	my $length = CORE::shift;
	#print CONSOLE " VRML2::MField::increaseSize\n";

	#for (my $i = @{$this}; $i < $length; ++$i) {
	#	$this->[$i] = new MField();
	#}
}

sub push  {
	my $this   = CORE::shift;
	my $mfield = CORE::shift;

	my $i      = $this->length;
	my $length = $i + $mfield->length;

	$this->length($length);

	for (; $i < $length; ++$i) {
		$this->[$i]->setValue($mfield->[$i]->getValue);
	}
}

sub toString {
	my $this = CORE::shift;
	#print CONSOLE " VRML2::MField::toString\n";

	return '['.$TSPACE.']' unless @{ $this };

	my $string = '';
	if ($#{ $this }) {
		$string .= '['.$TSPACE;
		$string .= join ",$TSPACE", @{$this};
		$string .= $TSPACE.']';
	} else {
		$string .= $this->[0];
	}
	
	return $string;
}

1;

__END__
