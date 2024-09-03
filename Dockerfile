# Software installation, no database files
FROM condaforge/miniforge3:23.3.1-1

# build and run as root users since micromamba image has 'mambauser' set as the $USER
USER root

# set workdir to default for building; set to /data at the end
WORKDIR /

# Version arguments
# ARG variables only persist during build time
# using latest commit as of 2024/08/01
ARG RC_COMMIT="299bb2691f97f6a699ff550113830f6916731c84"
ARG RC_SRC_URL=https://github.com/jidc-trust/ribosomal_snakemake/archive/${RC_COMMIT}.zip

# metadata labels
LABEL base.image="condaforge/miniforge3:23.3.1-1"
LABEL dockerfile.version="1"
LABEL software="ribosomal-wdl"
LABEL software.version=${RC_COMMIT}
LABEL description="A WDL wrapper around LCrossman/ribosomal_snakemake for Terra.bio"
LABEL website="https://github.com/jidc-trust/ribosomal_snakemake"
LABEL license="UNAVAILABLE"
LABEL maintainer1="Andrew J. Page"
LABEL maintainer.email1="andrew.page@theiagen.com"

# install Snakemake dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    squashfs-tools \
    unzip \
    wget && \
    apt-get autoclean && \
    rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log

# get the ribosomal_snakemake latest commit
# remove build numbers and OSX specific packages from environment.yaml
# create conda environment
RUN wget --quiet "${RC_SRC_URL}" && \
    unzip ${RC_COMMIT}.zip && \
    rm ${RC_COMMIT}.zip && \
    mv -v ribosomal_snakemake-${RC_COMMIT} /ribosomal_snakemake && \
    mamba create -y --name ribosomal_snakemake -c conda-forge -c bioconda \
        'snakemake>=3.5' \
        'python==3.11' \
        'biopython>=1.77' \
        'toolz>=0.11.1' \
        'diamond>=0.9.32' \
        'mafft>=7.429' \
        'fasttree>=2.1.10' \
        'iqtree>=1.6.11' \
        'ncbi-genome-download>=0.3.0' \
        'trimal>=1.5.0' && \
    mamba clean -a -y

# set locale settings to UTF-8
# set the environment, put new rc_snakemake conda env in PATH by default
ENV PATH /opt/conda/envs/ribosomal_snakemake/bin:$PATH \
    LC_ALL=C.UTF-8

# set final working directory to /data
WORKDIR /data
