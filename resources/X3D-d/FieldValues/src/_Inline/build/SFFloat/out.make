/usr/bin/perl /usr/share/perl/5.8/ExtUtils/xsubpp  -typemap /usr/share/perl/5.8/ExtUtils/typemap -typemap /home/holger/perl/X3D/Fields/src/map/SFFloat.map -typemap /home/holger/perl/X3D/Fields/src/_Inline/build/SFFloat/CPP.map   SFFloat.xs > SFFloat.xsc && mv SFFloat.xsc SFFloat.c
g++ -c  -I/home/holger/perl/X3D/Fields/src -D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.8/CORE"   SFFloat.c
In Datei, eingefügt von /usr/lib/gcc/i486-linux-gnu/4.0.3/../../../../include/c++/4.0.3/backward/iostream.h:31,
                    von SFFloat.xs:2:
/usr/lib/gcc/i486-linux-gnu/4.0.3/../../../../include/c++/4.0.3/backward/backward_warning.h:32:2: Warnung: #warning This file includes at least one deprecated or antiquated header. Please consider using one of the 32 headers found in section 17.4.1.2 of the C++ standard. Examples include substituting the <X> header for the <X.h> header for C++ includes, or <iostream> instead of the deprecated header <iostream.h>. To disable this warning use -Wno-deprecated.
Running Mkbootstrap for SFFloat ()
chmod 644 SFFloat.bs
rm -f blib/arch/auto/SFFloat/SFFloat.so
LD_RUN_PATH="" cc  -shared -L/usr/local/lib SFFloat.o  -o blib/arch/auto/SFFloat/SFFloat.so   -lstdc++   
chmod 755 blib/arch/auto/SFFloat/SFFloat.so
cp SFFloat.bs blib/arch/auto/SFFloat/SFFloat.bs
chmod 644 blib/arch/auto/SFFloat/SFFloat.bs
