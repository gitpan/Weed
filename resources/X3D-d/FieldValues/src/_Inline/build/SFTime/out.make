/usr/bin/perl /usr/share/perl/5.8/ExtUtils/xsubpp  -typemap /usr/share/perl/5.8/ExtUtils/typemap -typemap /home/holger/perl/X3D/Fields/src/map/SFTime.map -typemap /home/holger/perl/X3D/Fields/src/_Inline/build/SFTime/CPP.map   SFTime.xs > SFTime.xsc && mv SFTime.xsc SFTime.c
g++ -c  -I/home/holger/perl/X3D/Fields/src -D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.8/CORE"   SFTime.c
In Datei, eingefügt von /usr/lib/gcc/i486-linux-gnu/4.0.3/../../../../include/c++/4.0.3/backward/iostream.h:31,
                    von SFTime.xs:2:
/usr/lib/gcc/i486-linux-gnu/4.0.3/../../../../include/c++/4.0.3/backward/backward_warning.h:32:2: Warnung: #warning This file includes at least one deprecated or antiquated header. Please consider using one of the 32 headers found in section 17.4.1.2 of the C++ standard. Examples include substituting the <X> header for the <X.h> header for C++ includes, or <iostream> instead of the deprecated header <iostream.h>. To disable this warning use -Wno-deprecated.
Running Mkbootstrap for SFTime ()
chmod 644 SFTime.bs
rm -f blib/arch/auto/SFTime/SFTime.so
LD_RUN_PATH="" cc  -shared -L/usr/local/lib SFTime.o  -o blib/arch/auto/SFTime/SFTime.so   -lstdc++   
chmod 755 blib/arch/auto/SFTime/SFTime.so
cp SFTime.bs blib/arch/auto/SFTime/SFTime.bs
chmod 644 blib/arch/auto/SFTime/SFTime.bs
