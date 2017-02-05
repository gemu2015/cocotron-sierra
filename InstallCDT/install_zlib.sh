#!/bin/sh
echo "Installing zlib"

installResources=`pwd`/Resources
scriptResources=$installResources/scripts
read productVersion DSTROOT < "`pwd`/version.txt"
productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads

#PREFIX=`pwd`/../system/i386-mingw32msvc/
if [[ "$DSTROOT" == *"../"* ]] ;then
PREFIX=`pwd`/$DSTROOT/
else
PREFIX=$DSTROOT/
fi


# We need the headers/libraries, zlib.net only provides a dll or source which is more work

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "ftp://ftp.zlatkovic.com/libxml/zlib-1.2.5.win32.zip"

mkdir -p $PREFIX
cd $PREFIX
echo `pwd`

unzip -o $downloadFolder/zlib-1.2.5.win32.zip

cd zlib-1.2.5/lib
mv zlib.lib libz.a
mv zdll.lib libz.dll.a
