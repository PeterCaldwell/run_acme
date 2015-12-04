#!/usr/bin/csh -f
#Simple run script based on www.cesm.ucar.edu/models/cesm1.2/cesm/doc/usersguide/x382.html

set CASE = test1
set COMPSET = FC5
set RES = ne30_ne30
set MACH = corip1
set PROJECT = acme
set CASEROOT = $SCRATCH/ACME_runs/$CASE

cd ~/ACME_code/master/cime/scripts
echo CALLING create_newcase
echo ==============================
./create_newcase -case $CASEROOT \
    -mach $MACH \
    -compset $COMPSET \
    -res $RES \
    -project $PROJECT

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
