#!/bin/bash
# -------------------------------------------------------------------------------
# Author:    	Michael DeGuzis
# Git:	    	https://github.com/ProfessorKaos64/higan-src
# Scipt Name:	build-higan.sh
# Script Ver:	0.1.1
# Description:	Attempts to build higan from src
#
# Usage:	./build-higan-sh
# -------------------------------------------------------------------------------

time_start=$(date +%s)
time_stamp_start=(`date +"%T"`)
srcdir=$(pwd)

prepare()
{
  cd "{$srcdir}"
  #Append user's CXXFLAGS and LDFLAGS
  sed -i "/^flags   += -I. -O3 -fomit-frame-pointer/ s/$/ -std=gnu++11 $CXXFLAGS/" Makefile
  sed -i "/^link    +=/ s/$/ $LDFLAGS/" Makefile
}

build()
{
  
  # libananke
  cd "${srcdir}/higan"
  make compiler=g++ platform=linux flags="$CXXFLAGS -I.. -fomit-frame-pointer -std=gnu++11" -C ananke
  
  # higan
  cd "${srcdir}/higan"
  make clean
  for _profile in ${_profiles}; do
  make compiler=g++ platform=linux target=ethos profile=${_profile}
  mv out/higan{,-${_profile}}
  done

}

package()
{

# Install higan
  cd "${srcdir}/higan"
   
  # Common files
  install -dm 755 "${pkgdir}"/usr/{bin,lib,share/{applications,pixmaps,higan/Video\ Shaders}}
  install -m 755 "${srcdir}"/Higan "${pkgdir}"/usr/bin/higan
  install -m 644 "${srcdir}"/higan/data/higan.desktop "${pkgdir}"/usr/share/applications/higan.desktop
  install -m 644 "${srcdir}"/higan/data/higan.png "${pkgdir}"/usr/share/pixmaps/higan.png
  install -m 644 "${srcdir}"/higan/data/higan.ico "${pkgdir}"/usr/share/pixmaps/higan.ico
  cp -dr --no-preserve=ownership profile/* data/cheats.bml "${pkgdir}"/usr/share/higan/
  cp -dr --no-preserve=ownership shaders/*.shader "${pkgdir}"/usr/share/higan/Video\ Shaders/

  # libananke
  install -m 644 "${srcdir}"/higan/ananke/libananke.so "${pkgdir}"/usr/lib/libananke.so.1
  cd "${pkgdir}"/usr/lib/
  ln -s libananke.so.1 libananke.so
  
  # higan
  cd "${srcdir}/higan"
  for _profile in ${_profiles}; do
    install -m 755 {out,"${pkgdir}"/usr/bin}/higan-${_profile}
  done

  # Fix permissions
  find "${pkgdir}"/usr/share/higan/ -type d -exec chmod 755 {} +
  find "${pkgdir}"/usr/share/higan/ -type f -exec chmod 644 {} +
}

# note time ended
time_end=$(date +%s)
time_stamp_end=(`date +"%T"`)
runtime=$(echo "scale=2; ($time_end-$time_start) / 60 " | bc)

# output finish
echo -e "\nTime started: ${time_stamp_start}"
echo -e "Time started: ${time_stamp_end}"
echo -e "Total Runtime (minutes): $runtime\n"

# Start functions
prepare
build
package
