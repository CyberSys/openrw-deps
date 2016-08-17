VERSION=1.17.2

mkdir -p openal
cd openal

NAME=openal-soft-$VERSION.tar.bz2

download "openal" \
http://kcat.strangesoft.net/openal-releases/$NAME \
$NAME

cd ..
