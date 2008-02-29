package TestTypeBase;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}


use Weed 'TestType {}';

sub new { shift->X3DUniversal::new }

1;
__END__
