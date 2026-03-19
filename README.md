# uw3-hpc-baremetal-install-run

Install and job scripts for running [Underworld3](https://github.com/underworldcode/underworld3) on HPC clusters using bare-metal MPI (system/spack OpenMPI) with [pixi](https://pixi.sh) for Python package management.

## Clusters

| Cluster | Scheduler | MPI | Python |
|---------|-----------|-----|--------|
| [NCI Gadi](gadi/) | PBS Pro | module `openmpi/4.1.7` | pixi `gadi` env |
| [Kaiju](kaiju/) | Slurm | spack `openmpi@4.1.6` | pixi `kaiju` env |

## Structure

```
gadi/
  gadi_install_shared.sh    # shared install to /g/data/m18/software/ (admin only)
  gadi_install_user.sh      # per-user install to /g/data/m18/$USER/
  gadi_pbs_job.sh           # PBS job script template
  gadi_test_stokes.py       # parallel Stokes flow test

kaiju/
  kaiju_install_shared.sh   # shared install (admin only)
  kaiju_install_user.sh     # per-user install to ~/uw3-installation/
  kaiju_slurm_job.sh        # Slurm job script template
  kaiju_test_stokes.py      # parallel Stokes flow test
```

## Gadi

### Submit a job

> **Note:** Pure users just need to do this step.

```bash
# Activate the shared environment
source /g/data/m18/software/uw3-pixi/gadi_install_shared.sh

# Edit gadi_pbs_job.sh to set your script, ncpus, walltime, then submit
qsub gadi/gadi_pbs_job.sh
```

### Per-user install

```bash
# Install to /g/data/m18/$USER/uw3-pixi/ (first time only)
source gadi/gadi_install_user.sh install

# Activate in future sessions
source gadi/gadi_install_user.sh
```

### Shared install (admin only)

```bash
# Install to /g/data/m18/software/uw3-pixi/ (first time only)
source gadi/gadi_install_shared.sh install
```

## Kaiju

### Submit a job

> **Note:** Pure users just need to do this step.

```bash
# Activate the shared environment
module load underworld3/development-12Mar26

# Edit kaiju_slurm_job.sh to set your script, nodes, walltime, then submit
sbatch kaiju/kaiju_slurm_job.sh
```

### Per-user install

```bash
# Install to ~/uw3-installation/ (first time only)
source kaiju/kaiju_install_user.sh install

# Activate in future sessions
source kaiju/kaiju_install_user.sh
```

### Shared install (admin only)

```bash
# Install shared environment and create module file (first time only)
source kaiju/kaiju_install_shared.sh install
```
