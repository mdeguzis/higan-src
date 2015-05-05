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


#################################################
# Prerequisites
#################################################

# Handled by desktop-software.sh
# Software list: cfgs/ue4.txt

######################
# Clang notice:
######################

# per this, we will attempt using setup.sh instead of ue4.txt first

#################################################
# Initial setup
#################################################


#################################################
# Build UE4
#################################################

############################
# proceed to global build:
############################

############################
# Begin UE4 build eval
############################

#################################################
# Post install configuration
#################################################

# TODO

#################################################
# Cleanup
#################################################

# clean up dirs

# note time ended
time_end=$(date +%s)
time_stamp_end=(`date +"%T"`)
runtime=$(echo "scale=2; ($time_end-$time_start) / 60 " | bc)

# output finish
echo -e "\nTime started: ${time_stamp_start}"
echo -e "Time started: ${time_stamp_end}"
echo -e "Total Runtime (minutes): $runtime\n"
