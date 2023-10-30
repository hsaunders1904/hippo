#!/usr/bin/env bash

# Check that the meshes generated by the buoyantFoam tests match the reference
# mesh (according to exodiff).
#
# The script takes two arguments, the first is the output mesh of one of the
# buoyantFoam tests, the second is the reference mesh.
#
# The environment variable 'MOOSE_DIR' must be set.

RUN_OUT="$1"
REFERENCE_MESH="$2"

if ! [ -f "${RUN_OUT}" ]; then
    echo "run_out.e not found: make sure the buoyantCavity test has been run"
    exit 1
fi
if ! [ -f "${REFERENCE_MESH}" ]; then
    echo "reference mesh not found"
    exit 1
fi

EXODIFF="${MOOSE_DIR}/framework/contrib/exodiff/exodiff"
if ! command -v "${EXODIFF}" > /dev/null 2>&1; then
    echo "Can't find exodiff"
    exit 1
fi

"${EXODIFF}" "${RUN_OUT}" "${REFERENCE_MESH}"
