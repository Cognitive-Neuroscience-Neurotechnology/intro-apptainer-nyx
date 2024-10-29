#!/bin/bash

# 0. setup
apptainer --version
singularity --version

ls -l $(which singularity)

echo $APPTAINER_BINDPATH
echo $APPTAINER_TMPDIR
echo $APPTAINER_CACHEDIR

echo $SINGULARITY_BINDPATH

# 1. Getting containers
apptainer pull hello-world.sif docker://hello-world

ls -lh

# 2. Running containers

apptainer run hello-world.sif

apptainer inspect hello-world.sif
apptainer inspect -r hello-world.sif


singularity pull alpine.sif docker://alpine
singularity exec alpine.sif echo "Hello, world"


singularity shell alpine.sif docker://alpine


# 3. Building containers

# 3.1. Building a minimal container from a base image
apptainer build --fakeroot minimal.sif minimal.def

# 3.2 Building a container and installing some linux packages
# 1. python3
apptainer build --fakeroot minimal.sif minimal.def
# (possible bindpath related error, swith to build script:)
./build.sh debian_python.sif debian_python.def

# discuss additional sections in the definition file (environment, runscript, etc.)
# see https://apptainer.org/docs/user/main/definition_files.html

# 2. add file
# 3. add environment variable
# 4. add runscript



# 3.3 Approaches to installing more complex software
# example fsl
# - go to the fsl website, read installation instructions and draft a definition file
# - probem: fsl tries to download from anaconda channel, which is blocked in the MPG

# example freesurfer
# - go to the freesurfer website, read installation instructions and draft a definition file

# also consolt templates in gfae submodule


# 3.4 Neurodocker 
# see: https://www.repronim.org/neurodocker
# get neurodocker container
apptainer pull neurodocker.sif docker://repronim/neurodocker:latest
apptainer run neurodocker.sif

apptainer run docker://repronim/neurodocker:latest

apptainer run docker://repronim/neurodocker:latest 
alias neurodocker='apptainer run neurodocker.sif'

neurodocker generate singularity \
    --pkg-manager apt \
    --base-image ubuntu:22.04 \
    --freesurfer version=7.4.1 \
    > freesurfer_neurodocker.def

# 3.3 Neurocontainers (from neurodesk project)
# see: https://github.com/NeuroDesk/neurocontainers



