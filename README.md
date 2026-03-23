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

> **Note:** `gadi_install_shared.sh` is already inside `/g/data/m18/software/uw3-pixi`. Pure users just need to edit the job script accordingly and submit the job.

```bash
# Edit gadi_pbs_job.sh to set your script, ncpus, walltime, then submit
qsub gadi_pbs_job.sh
```

### Per-user install

Copy `gadi_install_user.sh` to a convenient location, then:

```bash
# Install (first time only)
source gadi_install_user.sh install

# Activate in future sessions
source gadi_install_user.sh
```

### Shared install (admin only)

Copy `gadi_install_shared.sh` to a convenient location, then:

```bash
# Install (first time only)
source gadi_install_shared.sh install
```

## Kaiju

### Submit a job

> **Note:** Pure users just need to do edit the job script accordingly and submit the job.

```bash
# Edit kaiju_slurm_job.sh to set your script, nodes, walltime, then submit
sbatch kaiju_slurm_job.sh
```

### Per-user install

Copy `kaiju_install_user.sh` to a convenient location, then:

```bash
# Install (first time only)
source kaiju_install_user.sh install

# Activate in future sessions
source kaiju_install_user.sh
```

### Shared install (admin only)

Copy `kaiju_install_shared.sh` to a convenient location, then:

```bash
# Install shared environment and create module file (first time only)
source kaiju_install_shared.sh install
```
