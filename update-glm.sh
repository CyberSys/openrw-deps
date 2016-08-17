VERSION=0.9.7.6

mkdir -p glm
cd glm

NAME=glm-$VERSION.7z

download "glm" \
https://github.com/g-truc/glm/releases/download/$VERSION/$NAME \
$NAME

eval 7z x -y $NAME

mkdir -p build-$ARCH
cd build-$ARCH
cmake ../glm -G"$GENERATOR" \
	-DCMAKE_INSTALL_PREFIX=../../VC${MSVC}-$RUNTIME-$ARCH-$CONFIG/glm
cmake --build . --target install --config $CONFIG -- /maxcpucount:4 /verbosity:quiet

cd ..

cd ..
