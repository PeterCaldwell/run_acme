#!/bin/csh -f
#Simple run script based on www.cesm.ucar.edu/models/cesm1.2/cesm/doc/usersguide/x382.html

set CASE = test4
set COMPSET = FC5
set RES = ne30_ne30
set MACH = blues
set PROJECT = ACME
set CASEROOT = /lcrc/project/ACME/$USER/ACME_simulations/$CASE

cd ~/ACME_code/ACME/cime/scripts
echo CALLING create_newcase
echo ==============================
./create_newcase -case $CASEROOT \
    -mach $MACH \
    -compset $COMPSET \
    -res $RES \
    -project $PROJECT \
    -compiler intel

cd $CASEROOT
 
echo CALLING cesm_setup
echo ==============================
./cesm_setup

echo CALLING CASE.build
echo ==============================
./$CASE.build

echo CALLING CASE.submit
echo ==============================
./$CASE.submit
