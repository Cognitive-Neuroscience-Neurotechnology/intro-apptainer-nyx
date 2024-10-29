#!/bin/bash
export APPTAINER_TMPDIR=~/ptmp/tmp
export APPTAINER_CACHEDIR=~/ptmp/tmp
export APPTAINER_BINDPATH=

deffile=$1
container_fname=${2-$(basename $deffile .def)}.sif

# Build the container
apptainer build --fakeroot $container_fname $deffile