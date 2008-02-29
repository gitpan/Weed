# package Makefile
use 5.006;
use ExtUtils::MakeMaker;

BEGIN {
	# See lib/ExtUtils/MakeMaker.pm for Details of how to influence
	# the Contents of the Makefile that is written.
	WriteMakefile(
		'NAME' => 'Weed',
		# 'VERSION'   => 0.009,    # finds $VERSION
		'VERSION_FROM' => 'lib/Weed.pm',
		'PREREQ_PM'    => {
			Test::More => 0,
			Benchmark  => 0,
			# Test::Benchmark => 0,

			UNIVERSAL => 0,

			base     => 0,
			constant => 0,
			enum     => 0,
			integer  => 0,
			overload => 0,
			strict   => 0,
			warnings => 0,

			# Universal
			Exporter       => 0,
			Carp           => 0,
			Time::HiRes    => 0,
			Package::Alias => 0,
			Class::ISA     => 0,
			Scalar::Util   => 0,
			Hash::NoRef    => 0,
			Want           => 0,
			Sub::Name      => 0,    # 0.02
			                        # Sub::Signatures => 0,
			Callback       => 0,    # 1.07

			# Concept ArrayHash <>
			# Object::MultiType => 0,

			# Values
			POSIX            => 0,
			Math::Quaternion => 0,
			Math::Trig       => 0,
			Math::Complex    => 0,

			# Array
			Algorithm::Numerical::Shuffle => 0,
			# Sort::ArbBiLex               => 0,

			# Fields
			Tie::Scalar     => 0,
			Tie::Array      => 0,
			Tie::Hash       => 0,
			Unicode::String => 0,

			# perl_BUILD
			File::Temp => 0,

			# test
			Data::Dumper => 0,

			# LWP::Simple         => 0,
			# Data::Validate::URI => 0,
		},    # e.g., Module::Name => 1.1

		# ABSTRACT_FROM => 'lib/Weed.pm',
		ABSTRACT => 'Contains the Abstract that will be displayed on CPAN',
		AUTHOR   => 'Holger Seelig <holger.seelig@yahoo.de>',
		# NO_META  => 1,
		# NORECURS => 0,
	);
}

1;
__END__

# clean
cd '/home/holger/perl/cpan/Weed'
perl Makefile.PL | grep OK
sudo make clean | grep OK
sudo rm Makefile.old 2>&1 | grep OK
sudo rm MANIFEST 2>&1 | grep OK
sudo rm MANIFEST.bak 2>&1 | grep OK


# mk dist
perl Makefile.PL | grep OK
make manifest 2>&1 | grep OK
cat MANIFEST | cpanversion+ 0.0001 | grep OK
perl Makefile.PL | grep OK
make test | grep OK
make dist | grep OK
mv *.gz ../


# mk install
sudo cpan . | grep OK


# mk test
perl Makefile.PL | grep OK
make test
