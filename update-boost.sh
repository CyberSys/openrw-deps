VERSION=1.61.0
COMPONENTS=(filesystem system)

mkdir -p boost
cd boost

NAME=boost_${VERSION//./_}-msvc-$MSVC.0-$BITS.exe

download "boost" \
http://sourceforge.net/projects/boost/files/boost-binaries/$VERSION/$NAME \
$NAME

./$NAME //dir=. //verysilent

cd ..
