package System::ENV;
use strict;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(&unique_id);
}

&get_user(`/usr/bin/whoami`);

sub get_user {
	my $user = shift;
	chomp $user;
	($ENV{USER}, undef, $ENV{UID}, $ENV{GID}, undef, $ENV{FULLNAME}, $ENV{GCOS}, $ENV{HOME}, $ENV{SHELL}, undef) = getpwnam($user);
	($ENV{GROUP}, undef, undef, undef) = getgrgid($ENV{GID});
	$ENV{HOST} = &hostname;
	$ENV{DOMAIN} = &domainname;
	$ENV{HTTP_DOMAIN} = &domainname($ENV{HTTP_HOST} || $ENV{SERVER_NAME}) unless exists $ENV{HTTP_DOMAIN};
	$ENV{SERVER_DOMAIN} = &domainname($ENV{SERVER_NAME} || $ENV{HTTP_HOST}) unless exists $ENV{SERVER_DOMAIN};
	$ENV{UNIQUE_ID} = &unique_id;
	return;
}

sub hostname {
	return $ENV{HOST} if $ENV{HOST};
	my $hn = `/usr/bsd/hostname`; chomp $hn;
	return "$hn";
}

sub domainname {
	my $domain = shift || $ENV{HOST}; $domain =~ s/^.*?\.//;
	return $domain;
}

my $unique_id_local_counter = 0;
sub unique_id {
	return $ENV{UNIQUE_ID} if exists $ENV{UNIQUE_ID};
	return sprintf "%X%X%X", time, $$, $unique_id_local_counter++;
}
1;

=head1 NAME

System::ENV

=head1 SYNOPSIS

hostname
domainname
unique_id
$ENV{UNIQUE_ID}
$ENV{USER}
$ENV{GROUP}
$ENV{HOME}

=cut

__END__
