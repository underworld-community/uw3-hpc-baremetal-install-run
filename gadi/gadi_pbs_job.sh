#!/bin/bash
#
# PBS job script template for Underworld3 on NCI Gadi
# Uses the shared pixi-based installation.
#
# Usage:
#   qsub gadi_pbs_job.sh
#   qsub -v SCRIPT=/path/to/my_model.py gadi_pbs_job.sh
#
# Adjust #PBS directives and USER CONFIGURATION below before submitting.
#

# ============================================================
# PBS DIRECTIVES
# ============================================================

#PBS -N uw3_job
#PBS -o uw3_${PBS_JOBID}.out
#PBS -e uw3_${PBS_JOBID}.err
#PBS -j oe
#PBS -q normal
#PBS -P m18
#PBS -l walltime=01:00:00
#PBS -l ncpus=4
#PBS -l mem=16gb
#PBS -l storage=gdata/m18+scratch/m18
#PBS -l wd

# ============================================================
# USER CONFIGURATION — edit this
# ============================================================

# Shared install script — readable by all m18 members.
INSTALL_SCRIPT=/g/data/m18/software/uw3-pixi/gadi_install_shared.sh

# Python script to run — relative to the directory where qsub is called.
# Override with: qsub -v SCRIPT=/absolute/path/to/script.py
SCRIPT="${SCRIPT:-gadi_test_stokes.py}"

# ============================================================
# ENVIRONMENT SETUP
# ============================================================

# Source the install script — loads modules, activates pixi gadi env,
# and exports PETSC_DIR, PYTHONPATH, PYTHONNOUSERSITE, LD_LIBRARY_PATH.
source "${INSTALL_SCRIPT}"

# ============================================================
# RUN
# ============================================================

echo "Job started:  $(date)"
echo "Job ID:       ${PBS_JOBID}"
echo "Nodes:        ${PBS_NODEFILE}"
echo "MPI ranks:    ${PBS_NCPUS}"
echo "Script:       ${SCRIPT}"
echo ""

mpirun -n "${PBS_NCPUS}" python3 "${SCRIPT}"

echo ""
echo "Job finished: $(date)"
