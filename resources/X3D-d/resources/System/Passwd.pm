package System::Passwd;
use strict;

use Array;

use overload
	'""' => \&toString;

my $Filename = '/etc/passwd';

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;
	$this->filename(exists $args->{filename} ? $args->{filename} : $Filename);

	$args->{name} = $ENV{USER} if !exists $args->{name} && exists $ENV{USER};
	$this->name($args->{name}) if exists $args->{name};

	return $this;
}

sub filename {
	my $this = shift;
	if (@_) {
		$this->{filename} = shift;
		$this->parse;
	}
	return $this->{filename};
}

sub parse {
	my $this = shift;
	$this->{users} = {};

	open(PASSWD, $this->{filename}) || return;
	$this->{users} = {
		map {
			chomp $_;
			my ($name, $password, $UID, $GID, $fullname, $home, $shell) = split ':', $_;
			$name => {
				name => $name || '',
				password => $password || '',
				UID => $UID || '',
				GID => $GID || '',
				fullname => $fullname || '',
				home => $home || '',
				shell => $shell || '',
			}
		} grep {!/^#/} <PASSWD>
	};
	close PASSWD;

	return;
}

sub user {
	my $this = shift;
	$this->{user} = shift if @_;
	return $this->{user};
}

sub users {
	my $this = shift;
	return ''.keys %{$this->{users}};
}

sub name {
	my $this = shift;
	if (@_) {
		my $name = shift;
		if (exists $this->{users}->{$name}) {
			$this->{user} = $this->{users}->{$name};
		} else {
			$this->{user} = {};
		}
	}
	return $this->{user}->{name};
}

sub create {
	my $this = shift;
	if (@_) {
		my $name = shift;
		unless (exists $this->{users}->{$name}) {
			$this->{users}->{$name} = {
				name   => $name,
				passwd => '',
			}
		}
		$this->{user} = $this->{users}->{$name};
	}
	return $this->{user}->{name};
}

sub password {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{password} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{password};
}

sub UID {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{UID} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{UID};
}

sub GID {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{GID} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{GID};
}

sub full_name {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{fullname} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{fullname};
}

sub fullname {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{fullname} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{fullname};
}

sub home {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{home} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{home};
}

sub shell {
	my $this = shift;
	$this->{users}->{$this->{user}->{name}}->{shell} = shift if @_;
	return $this->{users}->{$this->{user}->{name}}->{shell};
}

sub save {
	my $this = shift;
	open PASSWD, ">$this->{filename}";
	print PASSWD "$this\n";
	close PASSWD;
	return;
}

sub toString {
	my $this = shift;
	return join "\n", map {
		join ":",
			$this->{users}->{$_}->{name},
			$this->{users}->{$_}->{password},
			$this->{users}->{$_}->{UID},
			$this->{users}->{$_}->{GID},
			$this->{users}->{$_}->{fullname},
			$this->{users}->{$_}->{home},
			$this->{users}->{$_}->{shell};
	} sort keys %{$this->{users}};
}

sub DESTROY {
	my $this  = shift;
 	0;
}

1;

=head1 NAME

System::Passwd - provides an interface to /etc/passwd

=cut

__END__
