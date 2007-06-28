package System::User;
use strict;

use POSIX qw(strftime);
use Array;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;

	$args->{name} = $ENV{USER} if !exists $args->{name} && exists $ENV{USER};
	$this->name($args->{name}) if exists $args->{name};

	return $this;
}

sub name {
	my $this = shift;
	if (@_) {
		($this->{name},
		 $this->{password},
		 $this->{uid},
		 $this->{gid},
		 $this->{quota},
		 $this->{fullname},
		 $this->{gcos},
		 $this->{home},
		 $this->{shell}) = getpwnam(shift);
	}
	$this->{lang} = '';
	$this->{locale} = '';
	return $this->{name};
}

sub password {
	my $this = shift;
	return $this->{password};
}

sub uid {
	my $this = shift;
	return $this->{uid};
}

sub gid {
	my $this = shift;
	return $this->{gid};
}

sub quota {
	my $this = shift;
	return $this->{quota};
}

sub fullname {
	my $this = shift;
	return $this->{fullname};
}

sub gcos {
	my $this = shift;
	return $this->{gcos};
}

sub home {
	my $this = shift;
	return $this->{home};
}

sub shell {
	my $this = shift;
	return $this->{shell};
}

sub lang {
	my $this = shift;
	if (@_) {
		$this->{lang} = shift;
		system "echo '$this->{lang}' > '$this->{home}/.lang'";
		$this->{locale} = '';
	}
	unless ($this->{lang}) {
		$this->{lang} = `cat "$this->{home}/.lang"`;
		chomp $this->{lang};
		$this->{locale} = '';
	}
	return $this->{lang};
}

sub locale {
	my $this = shift;
	$this->{locale} = POSIX::setlocale( &POSIX::LC_ALL, $this->lang) unless $this->{locale};
	return $this->{locale};
}

1;

=head1 NAME

System::User - provides an interface to System User

=cut

__END__
