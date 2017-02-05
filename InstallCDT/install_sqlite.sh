#!/bin/sh
installResources=`pwd`/Resources
scriptResources=$installResources/scripts
read productVersion DSTROOT < "`pwd`/version.txt"
productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads

BASEDIR=/Developer/Cocotron/$productVersion/Windows/i386/gcc-4.3.1/
#PREFIX=`pwd`/../system/i386-mingw32msvc
if [[ "$DSTROOT" == *"../"* ]] ;then
PREFIX=`pwd`/$DSTROOT/
else
PREFIX=$DSTROOT/
fi


google_url=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cocotron-tools-gpl3


$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "$google_url/sqlite-dll-win32-x86-3070600.zip"

TMPDIR=/tmp/install_sqlite$$
echo $TMPDIR
mkdir $TMPDIR
cd $TMPDIR
unzip $downloadFolder/sqlite-dll-win32-x86-3070600.zip

mkdir -p $PREFIX/bin
cp sqlite3.dll $PREFIX/bin

mkdir -p $PREFIX/lib
$BASEDIR/bin/i386-pc-mingw32msvc-dlltool --def sqlite3.def --dllname sqlite3.dll --output-lib $PREFIX/lib/libsqlite3.a