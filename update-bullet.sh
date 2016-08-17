VERSION=2.83.7

mkdir -p bullet
cd bullet

NAME=$VERSION.tar.gz

download "bullet" \
https://github.com/bulletphysics/bullet3/archive/$NAME \
$NAME

eval tar xf $NAME

mkdir -p build-$ARCH
cd build-$ARCH
cmake ../bullet3-$VERSION -G"$GENERATOR" \
	-DINSTALL_LIBS=on \
	-DBUILD_SHARED_LIBS=off \
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL=$USE_MSVC_RUNTIME_LIBRARY_DLL \
	-DBUILD_UNIT_TESTS=off \
	-DBUILD_EXTRAS=off \
	-DBUILD_CPU_DEMOS=off \
	-DBUILD_BULLET2_DEMOS=off \
	-DBUILD_OPENGL3_DEMOS=off \
	-DCMAKE_INSTALL_PREFIX=../../VC${MSVC}-$RUNTIME-$ARCH-$CONFIG/bullet
cmake --build . --target install --config $CONFIG -- /maxcpucount:4 /verbosity:quiet

cd ..

cd ..
