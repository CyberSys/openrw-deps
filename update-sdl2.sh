VERSION=2.0.4

mkdir -p sdl2
cd sdl2

NAME=SDL2-devel-$VERSION-VC.zip

download "sdl2" \
https://www.libsdl.org/release/$NAME \
$NAME

cd ..
