hippo
=====

Moose app that wraps OpenFOAM buoyantFoam solver.

# Install/Build

NOTE: Only tested with mpich and gcc

Unfortunately hippo relies on patching OpenFOAM,
there is a script `scripts/install-openfoam.sh` that will clone
OpenFOAM-10, apply the patch, and build it.

First install the build dependencies:

```console
apt install \
    libqt5opengl5-dev \
    libqt5x11extras5-dev \
    libxt-dev \
    mpich \
    paraview \
    paraview-dev \
    qtbase5-dev \
    qttools5-dev \
    qttools5-dev-tools
```

Then run the script (use flag `-h` for help):

```console
bash ./scripts/install-openfoam.sh
```

To set the OpenFOAM build options (e.g., Opt or Debug mode),
copy `scripts/openfoam-prefs.sh` to `~/.OpenFOAM/prefs.sh`,
and update the environment variables within.
The variables will be loaded when `<path/to/OpenFOAM>/etc/bashrc` is sourced.


Follow instructions [Here](https://mooseframework.inl.gov/getting_started/installation/gcc_install_moose.html) to build MOOSE

# Hippo

### Environment

Set (recommend [direnv](https://direnv.net/) for this)

```
MOOSE_DIR=/path/to/moose/dir
MPI_ROOT=/path/to/mpich/root
MPI_ARCH_INC="-I/path/to/mpi/includes"
MPI_ARCH_LIBS="-L/path/to/mpi/libs -lmpi"
source /path/to/OpenFOAM/etc/bashrc
```

Once everything else is built then (in theory) should be able to `make` in the root directory (or `METHOD=dbg make` for a debug build

### Tests

Some basic tests can be run with `./run_tests`.

### Quality

Some code quality checks are set up with
[`pre-commit`](https://pre-commit.com/).

Install the pre-commit hooks to run on each new commit:

```console
pre-commit install
```

Run the hooks manually:

```console
pre-commit run --all
```

# NOTES

This work in progress so far hippo can:
 - Create a moose mesh from the boundary of an openfoam mesh
 - Can run an buoyantFOAM case via moose
 - Transfer temperature from faces of openfoam mesh to nodes of Moose mesh

NOTE: When running in parallel add `--keep-cout` to the command line because OpenFOAM will crash if
a process fails to write to stdout out

"Fork hippo" to create a new MOOSE-based application.

For more information see: [http://mooseframework.org/create-an-app/](http://mooseframework.org/create-an-app/)
