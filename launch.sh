#!/bin/bash

  ######                     #####
 ##   Use with your .inp file  ##
######                     #####

# Write your Orca path here:
orcapath=' '


#####################################################################################
loc='cd $PBS_O_WORKDIR'

# Prepare the place
mkdir ${1::-4}.files
cp ${1} ${1::-4}.files

# Read the number of CPUs to request  --- must use a %pal block END
nprocs=$(grep "nprocs" ${1} | awk '{print $2}')

cd ${1::-4}.files

# Create pbs file
cat > ${1}.pbs <<EOF
#!/bin/bash
#PBS -N ${1::-4}
#PBS -l select=1:node_type=rome:mpiprocs=$nprocs
#PBS -l walltime=24:00:00             

# Change to the directory in which the job will run
$loc

# Launch Orca to the allocated compute nodes
$orcapath/orca ${1} > ../${1::-4}.out 2>&1
EOF

qsub ${1}.pbs
rm ${1}.pbs
