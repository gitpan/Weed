use ExtUtils::MakeMaker;
my %options = %{       
{
  'TYPEMAPS' => [
    '/usr/share/perl/5.8/ExtUtils/typemap',
    '/home/holger/perl/X3D/Fields/src/map/SFColorRGBA.map',
    '/home/holger/perl/X3D/Fields/src/_Inline/build/SFColorRGBA/CPP.map'
  ],
  'NAME' => 'SFColorRGBA',
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
