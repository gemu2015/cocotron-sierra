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

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "http://www.opengl.org/resources/libraries/glut/glutdlls36.zip"

TMPDIR=/tmp/install_GLUT$$
mkdir $TMPDIR
cd $TMPDIR
unzip $downloadFolder/glutdlls36.zip

mkdir -p $PREFIX/bin
cp glut32.dll $PREFIX/bin

mkdir -p $PREFIX/lib
cp glut32.lib $PREFIX/lib

mkdir -p $PREFIX/include/GLUT
cp glut.h $PREFIX/include/GLUT/GLUT.h


