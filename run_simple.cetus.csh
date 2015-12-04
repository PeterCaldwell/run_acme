#!/bin/csh -f
#Simple run script based on www.cesm.ucar.edu/models/cesm1.2/cesm/doc/usersguide/x382.html

set CASE = test4
set COMPSET = FC5
set RES = ne30_g16
set MACH = cetus
set PROJECT = HiRes_EarthSys
#PMC note: machine file puts in ...$PROJECT/**usr**/$USER...
#but only jayesh has write access to create this file. Will fail
#for everyone else.
set CASEROOT = /projects/$PROJECT/$USER/$CASE

cd ~/gitwork/ACME/cime/scripts
echo CALLING create_newcase
echo ==============================
./create_newcase -case $CASEROOT \
    -mach $MACH \
    -compset $COMPSET \
    -res $RES \
    -project $PROJECT

cd $CASEROOT

#echo DO 1 RESTART TO CONFIRM FUNCTIONALITY
#echo ==============================
#./xmlchange -file env_run.xml -id RESUBMIT -val 1

echo CALLING cesm_setup
echo ==============================
./cesm_setup

echo CALLING CASE.build
echo ==============================
./$CASE.build

#echo RUN IN DEBUG QUEUE
#echo ==============================
#cat ${CASE}.run | sed "s/walltime=.*/walltime=0:29:00/g" > run.tmp
#cat run.tmp | sed "s/regular/debug/g" > run.tmp2
#mv run.tmp2 ${CASE}.run

echo CALLING CASE.submit
echo ==============================
./$CASE.submit
