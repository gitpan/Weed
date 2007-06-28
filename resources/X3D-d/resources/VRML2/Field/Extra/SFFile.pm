package VRML2::Field::Extra::SFFile;
use strict;

BEGIN {
	use Carp;
	use FileHandle ();
	use File::Basename ();
	#use File::Compare '';

	use LWP::Simple ();

	use VRML2::Field;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

my $realpath = "/usr/lib/desktop/realpath";
my $filetype = "filetype";
my $cat      = "cat";
my $gzcat    = "gzcat";

sub setValue {
	my $this = shift;
	if (@_) {
		my $value = shift;
		$value =~ s/^file://;
		$this->SUPER::setValue($value);
#		$this->SUPER::setValue($this->realpath($value)) if -e $value;
	}
}


# file vars
sub realpath {
	my $this = shift;
	my $fn   = shift || $this->filename;
	if (-e $fn) {
		my $file = $this->quote;
		$fn = `$realpath $file`;
		chomp $fn;
	}
	return $fn;
}

sub quote {
    my $this = shift;
	my $filename = $this->filename; 
	$filename =~ s/([\#\'\&\|\s\<\>\{\}\(\)\?\*\!\[\]])/\\$1/sg;
	$filename =~ s/([`"])/?/sg;
	return $filename;
}

sub filename {
	my $this = shift;
	$this->setValue(@_) if @_;
	return $this->getValue;
}

sub basename {
	my $this = shift;
	return File::Basename::basename($this->filename, @_);
}

my $counter = 0;
my $tmp     = "/tmp";

sub tempfname {
	my $this = shift;
	my $suf  = shift || '';
	my $tempfname = $this->_tempfname($suf);
	while (-e $tempfname) {
		$tempfname = $this->_tempfname($suf);
	}
	return $tempfname;
}

sub _tempfname {
	my $this = shift;
	my $suf  = shift || '';
	++$counter;
	return sprintf "$tmp/%05d%02d%s", $$, $counter, ($suf ? ".$suf" : ''); 
}

sub filetype {
	my $this = shift;
	my $filename = $this->quote;
	my $filetype = `filetype $filename`;
	return $1 if $filetype =~ /([^\s]+)\n$/s;
}

# create human readable filesize string
sub fsize {
	my $this = shift;
	my $size = $this->filesize;

	my $string = "";
	if ($size > 10995116277760) {
		$size /= 1099511627776;
		$string .= ' TB';
	} elsif ($size > 10737418240) {
		$size /= 1073741824;
		$string  .= ' GB';
	} elsif ($size > 10485760) {
		$size /= 1048576;
		$string  .= ' MB';
	} elsif ($size > 10240) {
		$size /= 1024;
		$string .= ' KBytes';
	} else { $string .= ' Bytes'; }
	$string = sprintf($size < 100 ? "%.1f" : "%.0f", $size) . $string;

	return $string;
}

sub filesize {
	my $this = shift;
	return -s $this->filename;
}

sub lastaccess {
	my $this = shift;
	return ((stat $this->filename)[8]);
}

sub lastmodify {
	my $this = shift;
	return ((stat $this->filename)[9]);
}

sub blocks {
	my $this = shift;
	return ((stat $this->filename)[12]);
}


# file func
sub get {
	my $this = shift;
	my $fh = $this->fh;
	return join '', <$fh>;
}

sub gzcat {
	my $this     = shift;
	my $filename = $this->quote;
	return join '', `$gzcat $filename`;
}

sub fh {
	my $this = shift;
	return new FileHandle($this->filename);
}

1;
__END__

package PML::File;
use strict;
use Carp;
use File::Basename ();
use File::Compare;
use FileHandle;

use vars qw(@ISA);
use PML::Field::SFTime;
@ISA = qw(PML::Field File::Basename);

use overload
	'<=>' => \&compare,
	'cmp' => \&compare_text,
	'<>'  => \&glob;

my $realpath = "realpath";

sub quote {
    my $this = shift;
	my $path = $this->filename; 
	$path =~ s/([\#\'\&\|\s\<\>\{\}\(\)\?\*\!\[\]])/\\$1/sg;
	$path =~ s/([`"])/?/sg;
	return $path;
}

sub setValue {
	my $this = shift;
	return $this->filename(@_);
}

sub filename {
	my $this = shift;
	if (@_) {
		my $value = $this->SUPER::setValue(@_);
		$value =~ s/^file://;
		$this->SUPER::setValue($this->realpath($value)) if -e $value;
	}
	return $this->getValue;
}

sub realpath {
	my $this = shift;
	my $fn   = shift || $this->filename;
	if (-e $fn) {
		my $file = $this->quote;
		$fn = `$realpath $file`;
		chomp $fn;
	}
	return $fn;
}

# create human readable filesize string
sub fsize ($size) {
	my $this = shift;
	my $size = shift || $this->filesize;

	my $string = "";
	if ($size > 10995116277760) {
		$size /= 1099511627776;
		$string .= ' TB';
	} elsif ($size > 10737418240) {
		$size /= 1073741824;
		$string  .= ' GB';
	} elsif ($size > 10485760) {
		$size /= 1048576;
		$string  .= ' MB';
	} elsif ($size > 10240) {
		$size /= 1024;
		$string .= ' KBytes';
	} else { $string .= ' Bytes'; }
	$string = sprintf($size < 100 ? "%.1f" : "%.0f", $size) . $string;

	return $string;
}

sub filesize {
	my $this = shift;
	return -s $this->filename;
}

sub lastaccess {
	my $this = shift;
	return new PML::Field::SFTime((stat $this->filename)[8]);
}

sub lastmodify {
	my $this = shift;
	return new PML::Field::SFTime((stat $this->filename)[9]);
}

sub blocks {
	my $this = shift;
	return new PML::Field::SFTime((stat $this->filename)[12]);
}

sub print {
	my $this = shift;
	return new PML::Field::SFTime((stat $this->filename)[12]);
}

sub fetch {
	my $this = shift;
	my $fh = $this->fh;
	return join '', <$fh>;
}

sub gzcat {
	my $this = shift;
	if (-e $this) {
		my $file = $this->quote;
		return `gzcat $file`;
	}
}

sub glob {
#	my $this = shift;
#	my $fh = $this->fh;
#	return <$fh>;
}

sub file {
#	my $this = shift;
#	my $fh = $this->fh;
#	return join '', <$fh>;
}

sub fh {
	my $this = shift;
	return new FileHandle("$this");
}

sub _filetype {
	my $this = shift;
	return '' unless -f $this->filename;
	my $file = $this->quote;
	return `filetype -v $file`;
}

sub filetype {
	my $this = shift;
	my $file = $this->quote;
	my $filetype = $this->_filetype;
	return $1 if $filetype =~ /LEGEND\s+(.*?)\n/s;
}

sub defaultExtension {
	my $this = shift;
	my $file = $this->quote;
	my $filetype = $this->_filetype;
	return $1 if $filetype =~ /\"DefaultExtension\"\s+(.*?)\n/s;
	return $1 if $this->filename =~ /\.([^\.]+)$/;
}

my $tmp     = "/tmp";
my $counter = 0;

sub tempfname {
	my $this = shift;
	my $suf  = shift || '';
	++$counter;
	return "$tmp/sffile.$$.$counter.$suf";
}

sub cp {
	my $this = shift;
	my $dest = shift;
	my $file = $this->quote;
	my $retv = system("cp $file " . $this->quote($dest) . " >/dev/null 2>&1") ? 0 : 1;
	if ($retv) {
		$this->filename("$dest/" . $this->basename) if -d $dest;
		$this->filename($dest) if -f $dest;
	}
	return $retv;
}

sub mv {
	my $this = shift;
	my $dest = shift;
	my $file = $this->quote;
	my $retv = system("mv $file " . $this->quote($dest) . " >/dev/null 2>&1") ? 0 : 1;
	if ($retv) {
		$this->filename("$dest/" . $this->basename) if -d $dest;
		$this->filename($dest) if -f $dest;
	}
	return $retv;
}

sub rm {
	my $this = shift;
	my $file = $this->quote;
	my $retv = system("rm $file >/dev/null 2>&1") ? 0 : 1;
	return $retv;
}

sub rmtmp {
	my $this = shift;
	$this->rm if $this->filename =~ /^\/tmp/;
	1;
}


sub toString {
	my $this = shift;
	return $this->filename;
}

1;

__END__
