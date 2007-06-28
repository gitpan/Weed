package VRML::MField;
use strict;
use Carp;

use overload
	'splice' => \&splice,
	'push' => \&push,
#	'eq' => \&eq,
#	'ne' => \&ne,
	"<=>" => \&ncmp,
	"==" => \&neq,
	"!=" => \&nne,
	'bool' => \&bool,
	'0+' => \&numify,
	'""' => \&toString;

use VRML::Generator qw($DEEP $TIDY_SPACE mfield_break);
use Array;

sub new {
	my $self  = CORE::shift;
	my $class = ref($self) || $self;
	my $this = [];
	if (@_) {
		if (!$#_ && ref $_[0] eq 'ARRAY') {
			$this = $_[0];
			bless $this, $class;
			return $this;
		}
	}

	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub getValue {
	my $this = CORE::shift;
	return [@{$this}];
}

sub get1Value {
	my $this = CORE::shift;
	my $index = CORE::shift;
	return $this->[$index];
}

sub setValue {
	my $this = CORE::shift;
	if (@_) {
		@{$this} = map {
			ref($_) eq 'ARRAY' || ref($_) =~ /^MF/ ?
			@{$_} :
			$_
		} @_;
	} else {
		@{$this} = ();
	}
	return $this;
}

sub set1Value {
	my $this  = CORE::shift;
	my $index = CORE::shift;
	my $value = CORE::shift;
	$this->[$index] = $value;
	return $this->[$index];
}

sub getSize { $#{$_[0]} }
sub length  { $#{$_[0]} + 1 }

sub splice  {
	my $this = CORE::shift;
	return CORE::splice(@{$this}) if @_ < 1;
	return CORE::splice(@{$this}, CORE::shift()) if @_ < 2;
	return CORE::splice(@{$this}, CORE::shift(), CORE::shift()) if @_ < 3;
	return CORE::splice(@{$this}, CORE::shift(), CORE::shift(), map { ref $_ ? @{$_} : $_ } @_);
}
sub push    { CORE::push	@{ CORE::shift() }, map { ref $_ ? @{$_} : $_ } @_ }
sub pop     { CORE::pop 	@{ CORE::shift() } }
sub shift   { CORE::shift	@{ CORE::shift() } }
sub unshift { CORE::unshift @{ CORE::shift() }, map { ref $_ ? @{$_} : $_ } @_ }

sub ncmp {
	return $_[1] <=> $_[0]->length unless ref $_[1];
	return $_[1] <=> $_[0]->length unless ref $_[1] eq ref $_[0];
	return array_ncmp($_[0], $_[1]);
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { $_[1] <=> $_[0] }

sub bool { $_[0]->length }
sub numify { $_[0]->length }

sub toString {
	my $this   = CORE::shift;
	return "[$TIDY_SPACE]" unless @{ $this };

	my $string = '';
	if ($#{ $this }) {
		$DEEP++;
		$string = "[".mfield_break;
		$string .= join ",".mfield_break, map {"$_"} @{ $this };
		--$DEEP;
		$string .= mfield_break."]";
	} else {
		$string = "$this->[0]";
	}

	return $string;
}

sub DESTROY {
	my $this  = CORE::shift;
 	0;
}
1;

__END__
sub IS {
	my $this = CORE::shift;
	if (@_) {
		return CORE::shift if ref $_[0] eq 'HASH';
	} else {
		if (!$#{$this} && ref $this->[0] eq 'HASH') {
			return "IS ".$this->[0]->{is} if exists $this->[0]->{is};
		}
	}
}

#sub eq   { 
#	return unless @{$_[1]} eq @{$_[0]};
#	foreach (0..&min($#{$_[0]}, $#{$_[1]})) {
#		return unless $_[1]->[$_] eq $_[0]->[$_]; 
#	}
#	return 1;
#}
#sub ne   {
#	return unless @{$_[1]} ne @{$_[0]};
#	foreach (0..&min($#{$_[0]}, $#{$_[1]})) {
#		return unless $_[1]->[$_] ne $_[0]->[$_]; 
#	}
#	return 1;
#}
#
#sub min { $_[0]<$_[1]?$_[0]:$_[1] }

