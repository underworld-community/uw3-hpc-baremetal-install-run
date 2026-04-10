#%Module1.0
##
## Underworld3 with AMR support
## Shared install: pixi (hpc env) + spack OpenMPI + PETSc + petsc4py
##
## Install path: /opt/cluster/software/underworld3
## Usage:        module load underworld3/development-DDMonthYY
##
## Admin: if spack OpenMPI is rebuilt (hash changes), update mpi_root below.

proc ModulesHelp { } {
    puts stderr "Underworld3 geodynamics simulation framework with AMR support."
    puts stderr ""
    puts stderr "To use:"
    puts stderr "  python3 -c \"import underworld3 as uw; print(uw.__version__)\""
    puts stderr ""
    puts stderr "To run with MPI:"
    puts stderr "  mpirun -n 4 python3 your_script.py"
    puts stderr "  srun --mpi=pmix -n 120 python3 your_script.py   # via Slurm"
}

module-whatis "Underworld3 geodynamics framework with AMR support"

set base     /opt/cluster/software/underworld3
set petsc    $base/petsc-custom/petsc
set arch     petsc-4-uw-openmpi
set mpi_root /opt/cluster/spack/opt/spack/linux-rocky8-skylake_avx512/gcc-8.5.0/openmpi-4.1.6-ticvlnexxf22yptz7rw37fqhgbijeknn

# Spack OpenMPI
prepend-path PATH            $mpi_root/bin
prepend-path LD_LIBRARY_PATH $mpi_root/lib

# pixi hpc environment (Python, numpy, sympy, scipy, gmsh, etc.)
prepend-path PATH            $base/.pixi/envs/hpc/bin
prepend-path LD_LIBRARY_PATH $base/.pixi/envs/hpc/lib

# PETSc + petsc4py + h5py + mpi4py (source-built against spack OpenMPI)
prepend-path LD_LIBRARY_PATH $petsc/$arch/lib
prepend-path PYTHONPATH      $petsc/$arch/lib

# PETSc env vars (used by some UW3 utilities)
setenv PETSC_DIR  $petsc
setenv PETSC_ARCH $arch

# Required for Slurm + PMIx + OpenMPI on Kaiju
setenv PMIX_MCA_psec               native
setenv OMPI_MCA_btl_tcp_if_include eno1
