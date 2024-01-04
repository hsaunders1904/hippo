#!/usr/bin/env bash

# You need OpenFOAM's bin on the system path to run this
(
    cd buoyantCavity && \
    rm log.blockMesh log.buoyantFoam log.createGraphs log.postProcess.sample && \
    blockMesh && \
    decomposePar -force && \
    ./Allrun
)
mpirun -n 4 $1 -i run.i
