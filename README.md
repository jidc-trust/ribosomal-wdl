# ribosomal-wdl
A WDL wrapper around LCrossman/ribosomal_snakemake for Terra.bio

## Introduction

`ribosomal-wdl` is a WDL wrapper around the [ribosomal_snakemake](https://github.com/jidc-trust/ribosomal_snakemake)
pipeline for the generation of phylogenetic trees based on ribosomla proteins.

## Installation

To run locally you will need to have [Cromwell](https://cromwell.readthedocs.io/en/stable/)
and [Docker](https://docs.docker.com/engine/install/) availble. With these two you will have
everything needed to run `ribosomal-wdl` on the command-line.

For now you should clone the `ribosomal-wdl` repository.

```{bash}
git clone git@github.com:jidc-trust/ribosomal-wdl.git
```

__*Instructions on using `ribosomal-wdl` on [Terra.bio](https://terra.bio/) will be made available soon.*__

## Usage

### Inputs

`ribosomal-wdl` requires the following inputs:

### GenBank Files

For `ribosomal-wdl` you will need to provide a set of GenBank files from each of the samples
you would like to generate a tree from. These GenBank files can either be uncompressed or
compressed using Gzip, and they must be one of the following extensions: `.gbff`, `.gbk`,
`.gb`, or `.genbank`

### Ribosomal Proteins

`ribosomal-wdl` will expect you to bring your own ribosomal reference proteins or use the
provided datasets. 

If you generate a set of ribosomal reference proteins, they must be saved in the following
structure [as a Gzipped Tarball](https://github.com/jidc-trust/ribosomal-wdl/blob/master/tests/data/staphylococcus_xylosus.tar.gz):

```{bash}
./
├── atccs.txt
└── proteins
   ├── atccL14.aa
   ├── atccL15.aa
   ├── atccL16.aa
   ├── atccL18.aa
   ├── atccL2.aa
   ├── atccL22.aa
   ├── atccL24.aa
   ├── atccL3.aa
   ├── atccL4.aa
   ├── atccL5.aa
   ├── atccL6.aa
   ├── atccS10.aa
   ├── atccS17.aa
   ├── atccS19.aa
   ├── atccS3.aa
   └── atccS8.aa
```

#### `atccs.txt`

This file will be read by `ribosomal_snakemake` to determine where the input reference
ribosomal proteins are located. For the purposes of `ribosomal-wdl`, the path in `atccs.txt`
should be relative to a current working directory (e.g. no hard coded absolute paths). If you
stick to the structure above you should be fine.

#### `./proteins/` Directory

This directory should contain a FASTA file for each of the reference ribosomal proteins.To learn more
on generating this set of reference proteins, please see [ribosomal_snakemake - Usage](https://github.com/jidc-trust/ribosomal_snakemake#usage). Otherwise you can use the provided reference protein sets.

### Species Name

The final input required for `ribosomal-wdl` is a species name for the input samples. This is
a required input for `ribosomal_snakemake`.

## Executing `ribosomal-wdl`

If you have Cromwell and Docker, as well as your local copy of `ribosomal-wdl` available, 
you will be able to easily run `ribosomal-wdl` on the command-line.

__*Just to reinterate, instructions on using `ribosomal-wdl` on [Terra.bio](https://terra.bio/) will be made available soon.*__

### Running Test Data

If you would simply like to test to make sure your environment is correctly setup, you
can try running `ribosomal-wdl` on available test data using the following command: 

```{bash}
cd ribosomal-wdl/
cromwell run \
    workflows/wf_rctyping.wdl \
    -i tests/inputs/wf_rctyping.json \
    -m metadata.json
```

From this command, you will see alot of Cromwell logging, but if everyhting is successful
you will see something similar to this at the end:

```{bash}
[DATE] [info] SingleWorkflowRunnerActor workflow finished with status 'Succeeded'.
{
  "outputs": {
    "rctyping.rctype_treefile": "/path/to/call-rc_snakemake/execution/rctype_.updateriboprotdedupe.aln.treefile",
    "rctyping.rctype_version": "Ribo_tre-11-g5ccf10c.54",
    "rctyping.rctype_proteins_fasta": "/path/to/call-rc_snakemake/execution/rctype_concatenated_ribosomal_proteins_db.fasta",
    "rctyping.rctype_aln": "/path/to/call-rc_snakemake/execution/rctype_.updateriboprotdedupe.aln",
    "rctyping.rctype_deduped_fasta": "/path/to/call-rc_snakemake/execution/rctype_.updateriboprot.fastadedupe.fasta",
    "rctyping.rctype_recovered_fasta": "/path/to/call-rc_snakemake/execution/rctype_recovered.fasta",
    "rctyping.rctype_analysis_date": "DATE",
    "rctyping.rctype_fasta": "/path/to/call-rc_snakemake/execution/rctype_.updateriboprot.fasta",
    "rctyping.rctype_proteins_fasta2": "/path/to/call-rc_snakemake/execution/rctype_concatenated_ribosomal_proteins_db.fasta_2",
    "rctyping.rctype_extracted_fasta": "/path/to/call-rc_snakemake/execution/rctype_extracted.fasta"
  },
  "id": "RANDOM_ID"
}
```

If successful, you will have confirmation that you are properly set up to run `ribosomal-wdl`
on your system. To run your own data you will only need to create an `inputs.json` file.

### `inputs.json`

Cromwell expects inputs to be described in a JSON formatted file, sometimes called the
_"`inputs.json` file"_. You can name the file however you like, but it should have the
following structure:

```{bash}
{
    "rctyping.genbank": [
        "GENBANK_FILE_1",
        "GENBANK_FILE_2",
        "GENBANK_FILE_3",
        ...
        "GENBANK_FILE_N"
    ],
    "rctyping.rc_proteins": "RIBOSOMAL_PROTEINS.tar.gz",
    "rctyping.species": "SPECIES NAME"
}
```

As an example, here is the `inputs.json` that was used in the test run above:

```{bash}
{
    "rctyping.genbank": [
        "tests/data/genbank/GCF_018968045.1_ASM1896804v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_020229655.1_ASM2022965v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_003578725.1_ASM357872v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_015235475.1_ASM1523547v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_900458755.1_41665_D01_genomic.gbff.gz",
        "tests/data/genbank/GCF_002732165.1_ASM273216v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_020224725.1_ASM2022472v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_021403025.1_ASM2140302v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_003578835.1_ASM357883v1_genomic.gbff.gz",
        "tests/data/genbank/GCF_003578865.1_ASM357886v1_genomic.gbff.gz"
    ],
    "rctyping.rc_proteins": "tests/data/staphylococcus_xylosus.tar.gz",
    "rctyping.species": "Staphylococcus xylosus"
}
```

## Output Files

After successfully running `ribosomal-wdl` you will have the following outputs:

| File                                              | Description |
|---------------------------------------------------|-------------|
| rctype_recovered.fasta                            |  |
| rctype_.updateriboprot.fasta                      |  |
| rctype_concatenated_ribosomal_proteins_db.fasta   |  |
| rctype_.updateriboprotdedupe.aln                  |  |
| rctype_.updateriboprotdedupe.aln.treefile         |  |
| rctype_concatenated_ribosomal_proteins_db.fasta_2 |  |
| rctype_extracted.fasta                            |  |
| rctype_.updateriboprot.fastadedupe.fasta          |  |
