use ExtUtils::MakeMaker;
my %options = %{       
{
  'TYPEMAPS' => [
    '/usr/share/perl/5.8/ExtUtils/typemap',
    '/home/holger/perl/X3D/Fields/src/map/SFInt32.map',
    '/home/holger/perl/X3D/Fields/src/_Inline/build/SFInt32/CPP.map'
  ],
  'NAME' => 'SFInt32',
  'CC' => 'g++',
  'LIBS' => [
    '-lstdc++'
  ],
  'INC' => '-I/home/holger/perl/X3D/Fields/src',
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
