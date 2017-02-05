#!/bin/sh
./install_FreeType.sh

installResources=`pwd`/Resources
scriptResources=$installResources/scripts

read productVersion DSTROOT < "`pwd`/version.txt"


productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads



if [ ""$1"" = "" ];then
	AGG_VERSION=2.5
else
	AGG_VERSION=$1
fi

#PREFIX=`pwd`/../system/i386-mingw32msvc/agg-$AGG_VERSION
if [[ "$DSTROOT" == *"../"* ]] ;then
	PREFIX=`pwd`/$DSTROOT/agg-$AGG_VERSION
else
	PREFIX=$DSTROOT/agg-$AGG_VERSION
fi


BUILD=/tmp/build_AntiGrain

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "http://www.antigrain.com/agg-$AGG_VERSION.zip"

mkdir -p $BUILD
cd $BUILD
unzip -o $downloadFolder/agg-$AGG_VERSION.zip
cd agg-$AGG_VERSION

cd src

# Create a fake Cocotron uname for the build system
cat > uname <<EOF
#!/bin/sh
echo "Cocotron"
EOF
chmod +x uname
cd ..

# Create a Makefile.in.Cocotron
cat > Makefile.in.Cocotron <<EOF
AGGLIBS= -lagg 
AGGCXXFLAGS = -O3
CXX = /Developer/Cocotron/$productVersion/Windows/i386/gcc-4.3.1/bin/i386-pc-mingw32msvc-g++
C = /Developer/Cocotron/$productVersion/Windows/i386/gcc-4.3.1/bin/i386-pc-mingw32msvc-gcc
LIB = /Developer/Cocotron/$productVersion/Windows/i386/gcc-4.3.1/bin/i386-pc-mingw32msvc-ar cr

.PHONY : clean
EOF

# include the local uname

PATH=.:$PATH

rm gpc/*
rm include/agg_conv_gpc.h
# The makefiles expect a .c file, so make an empty one
touch gpc/gpc.c

make

mkdir -p $PREFIX
(tar -cf - --exclude "Makefile*" include) | (cd $PREFIX;tar -xf -)
cp src/libagg.a $PREFIX
