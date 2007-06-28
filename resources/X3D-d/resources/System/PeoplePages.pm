package System::PeoplePages;
use strict;

use Array;
use System::PeoplePages::Person;
use System::User;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;
	$this->user($args->{user} || $ENV{USER}); 
	$this->{person} = new System::PeoplePages::Person(path => $this->{path}, key => $args->{key});
	return $this;
}

sub user {
	my $this = shift;
	if (@_) {
		$this->{keys} = [];
		$this->{user} = new System::User unless $this->{user};
		$this->{person} = new System::PeoplePages::Person unless $this->{person};
	
		$this->{user}->name(shift);
		$this->{path} = $this->{user}->home."/.PeoplePagesPersonal"; 
		$this->{person}->path($this->{path});
		$this->scan;
	}
	return $this->{user};
}

sub path {
	my $this = shift;
	return $this->{path};
}

sub scan {
	my $this = shift;
	return unless -d $this->{path};
	opendir PEOPLE, $this->{path};
	$this->{keys} = [sort grep { !/^\./ && -f "$this->{path}/$_" } readdir PEOPLE];
	closedir PEOPLE;
	return 1;
}

sub keys {
	my $this = shift;
	unless ($this->{keys}) {
		opendir PEOPLE, $this->{path};
		$this->{keys} = [sort grep { !/^\./ && -f "$this->{path}/$_" } readdir PEOPLE];
		closedir PEOPLE;
	}
	return $this->{keys};
}

sub person {
	my $this = shift;
	$this->{person}->key(shift) if @_;
	return $this->{person};
}

sub previous {
	my $this = shift;
	my $index = binary_search($this->keys, $this->{person}->key);
	return 0 unless defined $index;
	return $this->keys->[$index ? $index - 1 : $#{$this->keys}];
}

sub next {
	my $this = shift;
	my $index = binary_search($this->keys, $this->{person}->key);
	return 0 unless defined $index;
	return $this->keys->[$index < $#{$this->keys} ? $index + 1 : 0];
}

1;

=head1 NAME

System::PeoplePages - provides an interface to PeoplePages

=cut

__END__
