#!/bin/sh
installResources=`pwd`/Resources
scriptResources=$installResources/scripts
read productVersion DSTROOT < "`pwd`/version.txt"
productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads

#PREFIX=`pwd`/../system/i386-mingw32msvc
if [[ "$DSTROOT" == *"../"* ]] ;then
PREFIX=`pwd`/$DSTROOT/
else
PREFIX=$DSTROOT/
fi

INCLUDE=$PREFIX/include
BIN=$PREFIX/bin
LIB=$PREFIX/lib

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "http://sourceforge.net/projects/plibc/files/plibc/0.1.5/plibc-0.1.5.zip"

TMPDIR=/tmp/install_plibc$$
mkdir $TMPDIR
cd $TMPDIR
unzip $downloadFolder/plibc-0.1.5.zip

mkdir -p $PREFIX/bin
cp bin/libplibc-1.dll  $PREFIX/bin

mkdir -p $PREFIX/lib
cp lib/libplibc.dll.a $PREFIX/lib/libplibc.a

mkdir -p $PREFIX/include
(cd include;tar -cf - *) | (cd $PREFIX/include;tar -xf -)

