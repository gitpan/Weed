package VRML2::Field::Extra::SFDirectory;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field::Extra::SFFile;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field::Extra::SFFile);
}

sub setValue {
	my $this = shift;
	$this->VRML2::Field::Extra::SFFile::setValue(@_);
	${$this} = File::Basename::dirname ${$this} if -f ${$this};
	return;
}

# find, directories, files
sub find {
	my $this = shift;
	my $path = shift || "$this";
	my @files;
	opendir DIR, $path;
	push @files, map {
		my $f = "$path/$_";
		-d $f ? ($this->new($f), $this->find($f)) : new SFFile($f)
	} grep {!/^\..?$/} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @files;
}


# find, directories, files
sub directories {
	my $this = shift;
	my $path = shift || "$this";
	my @directories;
	opendir DIR, $path;
	push @directories, map {
		$this->new("$path/$_")
	} grep {-d "$path/$_"} grep {!/^\..?$/} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @directories;
}

sub files {
	my $this = shift;
	my $path = shift || "$this";
	my @directories;
	opendir DIR, $path;
	push @directories, map {
		$this->new("$path/$_")
	} grep {!-d "$path/$_"} grep {!/^\..?$/} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @directories;
}


1;
__END__

package PML::Directory;
use strict;
use Carp;

use vars qw(@ISA);
use PML::File;
@ISA = qw(PML::File);

sub setValue {
	my $this = shift;
	$this->PML::File::setValue(@_);
	${$this} = dirname ${$this} if -f ${$this};
	return $this;
}

sub mkdir { return CORE::mkdir(@_) }

sub rmdir {
	my $this = shift;
	foreach (reverse $this->find) {
		unlink $_ if -f $_; 
		CORE::rmdir($_) if -d $_; 
	}
}

# size
sub size {
	my $this = shift;
	my $size = -s $this;
	$size += -s $_ foreach $this->find;
	return $size;
}

sub blocks {
	my $this = shift;
	return $this->size;
}

# find, directories, files
sub find {
	my $this = shift;
	my $path  = shift || "$this";
	my @files;
	opendir DIR, $path;
	push @files, map {
		my $f = "$path/$_";
		-d $f ? ($f, $this->find($f)) : $f
	} grep {!/^\..?$/} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @files;
}

sub directories {
	my $this = shift;
	opendir DIR, "$this";
	my @dirs = map { $this->new("$this/$_") } grep { !/^\..?$/ && -d "$this/$_"} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @dirs;
}

sub files {
	my $this = shift;
	my $path = shift || "$this";
	my @files;
	opendir DIR, $path;
	push @files, map {
		my $f = "$path/$_";
		-d $f ? ($f, $this->files($f)) : $f
	} grep {!/^\..?$/} readdir DIR;
	closedir DIR;
	return sort {uc($a) cmp uc($b)} @files;
}


# sequences
sub sequences {
	my $this = shift;
	my $sequences = {};
	foreach ($this->find) {
		next unless /(.*?)\d+([^\/\d]*)$/;
		push @{$sequences->{$1.$2}}, $_;
	}
	foreach (keys %{$sequences}) {
		$sequences->{$_} = [sort {
			$a =~ /.*?(\d+)[^\/\d]*$/; my $N = $1;
			$b =~ /.*?(\d+)[^\/\d]*$/;
			$N <=> $1
		} @{$sequences->{$_}}];
		$sequences->{$_}->[0] =~ /.*?(\d+)[^\/\d]*$/; my $N = $1;
		$sequences->{$_}->[$#{$sequences->{$_}}] =~ /(.*?)(\d+)([^\/\d]*)$/;
		$sequences->{"$1\[$N-$2\]$3"} = $sequences->{$_};
		delete $sequences->{$_};
	}
	return $sequences;
}

1;
__END__
