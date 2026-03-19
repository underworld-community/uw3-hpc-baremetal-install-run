#!/bin/bash
#
# Slurm job script template for Underworld3 on Kaiju
# Uses the shared installation loaded via Environment Modules.
#
# Usage:
#   sbatch uw3_slurm_job_shared.sh
#   sbatch --nodes=2 --ntasks-per-node=30 uw3_slurm_job_shared.sh
#
# Edit the SBATCH directives and SCRIPT variable below.
#

# ============================================================
# SLURM DIRECTIVES
# ============================================================

#SBATCH --job-name=uw3_job
#SBATCH --output=uw3_%j.out       # %j = job ID
#SBATCH --error=uw3_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=30      # 4 nodes x 30 = 120 MPI ranks
#SBATCH --time=01:00:00           # HH:MM:SS wall time limit

# ============================================================
# USER CONFIGURATION — edit this
# ============================================================

# Module name (check available versions with: module avail underworld3)
UW3_MODULE="underworld3/development-12Mar26"

# Python script to run — relative to directory where sbatch is called.
# Override with: sbatch --export=SCRIPT=/absolute/path/to/script.py uw3_slurm_job_shared.sh
SCRIPT="${SCRIPT:-test_stokes_kaiju.py}"

# ============================================================
# ENVIRONMENT SETUP
# ============================================================

module load "${UW3_MODULE}"

# ============================================================
# RUN
# ============================================================

echo "Job started:  $(date)"
echo "Nodes:        ${SLURM_NODELIST}"
echo "MPI ranks:    ${SLURM_NTASKS}"
echo "Module:       ${UW3_MODULE}"
echo "Script:       ${SCRIPT}"
echo ""

# --mpi=pmix is required for Slurm + OpenMPI on Kaiju
srun --mpi=pmix python3 "${SCRIPT}"

echo ""
echo "Job finished: $(date)"
