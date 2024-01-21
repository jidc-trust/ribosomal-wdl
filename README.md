# ribosomal-wdl
A WDL wrapper around [ribosomal_snakemake](https://github.com/jidc-trust/ribosomal_snakemake) for
execution on [Terra.bio](https://terra.bio/).

## Introduction

`ribosomal-wdl` is a WDL wrapper around the [ribosomal_snakemake](https://github.com/jidc-trust/ribosomal_snakemake)
pipeline for the generation of phylogenetic trees based on ribosomla proteins.

## Usage on Terra.bio

`ribosomal-wdl` is available on [Terra.bio](https://terra.bio/), a cloud-native platform for
researchers to access data, run analysis tools, and collaborate. With Terra.bio, you can easily
process your data without prior knowledge of the command-line.

The following steps, assume you have already set up an account on Terra.bio and created
a workspace to work with `ribosomal-wdl`.

### Import from Dockstore

To begin using `ribosomal-wdl` on Terra.bio, you will need to import the workflow from Dockstore,
which is available at: [ribosomal-wdl Dockstore Import](https://dockstore.org/workflows/github.com/jidc-trust/ribosomal-wdl/RCTyping:master?tab=info).

Once you are on the Dockstore page for `ribosomal-wdl`, you will want to locate the _Launch with_
section on the right side of the page and click on _Terra_.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/76a9e250-fd0d-49d0-9b0a-60db87d37946)

After clicking the _Terra_ button, you will be transported to Terra.bio. Once here you will
decide on the _Destination Workspace_. Please select which of your workspaces you would like
to import this workflow into. For demonstration purposes, a _RCTyping_ workspace was created.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/2d98f606-17ba-4e31-aeef-df84e71c9377)

__*Again, please substitute this with a workspace you would like to use.*__

Once you have selected a _Destination Workspace_, all that remains is to click the _Import_
button.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/7f306637-750e-4993-956c-7fec8eb11241)

If successful, you should have imported the RCTyping workflow into Terra.bio.

### A Brief Tutorial

Now that we have imported the RCTyping workflow, let's take a moment to processing a small
toy set of data to better understand how to use this workflow on Terra.bio. In order to do this
we will make use of test data available from this repo.

#### Downloading Data

To make things easy for us, we'll make use of existing test data in this repo. Let's go ahead
and download a Zip file of this repository.

[Download ribosomal-wdl ZIP](https://github.com/jidc-trust/ribosomal-wdl/archive/refs/heads/master.zip)

*This is identical to clicking the green __Code__ button at the top of this page, then clicking __Download ZIP__*

Remember where you downloaded and extracted this file we'll need it in the next section.

#### Importing Data

First we'll navigate to the _Data_ section in your workspace.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/769275f3-b128-4ca1-85c6-7cd2c56b7513)

Next you will select _Files_ in the left pannel:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/b85c1cd7-3707-48a4-9803-1e555dc90a49)

In the _Files+ section, let's create a new folder and name it _tutorial_:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/56c2d21a-ddbd-4486-9544-82bfc0c38c81)

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/0ff8bd6e-d934-445b-91df-80c42d74cfad)

We will use this folder to upload our test data into.

To upload data click the _UPLOAD_ button. This will open a file manager (e.g. Windows Explorer), navigate
to where you downloaded and extracted the ZIP file downloaded in the previous section.

Once found, enter the `tests` directory, then the `data` directory. In here you will see:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/a59b0dfd-6050-4526-b21c-594878df7373)

The `genbank` folder contains input GenBank files, and the `staphylococcus_xyulosus.tar.gz` contains
reference ribosomal proteins for RCTyping.

First let's import the  `staphylococcus_xyulosus.tar.gz` file,by selecting it and cliking _Open".

Next we'll import the GenBank files. Again click the _UPLOAD_ button and navigate to the `test/data` folder
(_It might reopen to this directory_). Once here open the `genbank` folder and select all the GenBank files
in this directory and select _Open_.

After you have imported all your data, your `tutorial` folder should look like this:
![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/6e346338-f084-4ad7-a1fb-5bae64ea6789)

##### __IMPORTANT NOTE__ - GenBank must use valid extension

Your input GenBank files must have one of the following extension: _'*.gbff', '*.gbff.gz', '*gbf', '*gbf.gz', '*.gbk', '*.gbk.gz', '*.gb', '*.gb.gz', '*.genbank', or '*.genbank.gz'_ 

The tutorial files use a valid extension, but please keep this in might as you start processing your own data.

#### Setup Workspace Data and Tutorial Table

Every workspace in Terra.bio gets a unique bucket name to save ouput files to. To determine your
unique _Bucket Name_, navigate to the _Dashboard_ 

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/7f4dd31a-35b1-4949-97d2-98867709a225)

Next click on _CLOUD INFORMATION_

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/70c7bbfd-bb74-40a5-9e3b-56af2f926e50)

There it is, _Bucket Name_, go ahead and click the _clipboard_ next to it to copy this bucket name
to your Clipboard. You'll make use of it in the next sections.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/d6e53e03-8fb3-4df5-b189-205cfdc510e9)

##### Workspace Data

Now let's navigate back to your _DATA_ section and click on _Workspace Data_ in the left section.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/e9c66de8-d9e1-443b-a58b-ab136c4d05ae)

Once here, you will see information that is available to all workflows in the workspace. It might be empty
if its a new Workspace, but let's go ahead and add a new entry. 

To do so, look for the circle with a plus sign in the bottom right. 

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/8b863ef7-c290-4921-b1d7-748db616224b)

Uplon clicking this, you will be able to edit a new row in your workspace. You can add a _Key_, _Value, and
_Description_. For this section we'll use the following values:

__Key__: staphylococcus_xyulosus  
__Value__: gs://<YOUR_BUCKET_NAME>/tutorial/staphylococcus_xylosus.tar.gz  
__Description_: Staphylococcus xylosus reference ribosomal proteins  

__*Be sure to replace <YOUR_BUCKET_NAME> with the bucket name we copied in the previous section!*__

Once done click the _checkmark_ button.

You should now see a new entry in your _Workspace Data_.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/b0ff5d70-8664-4b08-bf00-b50dcbf0d4be)

##### Table Data

In the _DATA_ section you might have noticed a _TABLES_ section. Here we will click on _Upload TSV_.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/3d74ddb8-78ca-41c5-8c3e-44fa1838e57e)

Next we'll select the _TEXT IMPORT_ section, and paste in the following TSV, making sure to replace
`<YOUR_BUCKET_NAME>` with the bucket name that corresponds to your Workspace.

```bash
entity:rctying_tutorial_id	genbank	species
GCF_002732165	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_002732165.1_ASM273216v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_003578725	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_003578725.1_ASM357872v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_003578835	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_003578835.1_ASM357883v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_003578865	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_003578865.1_ASM357886v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_015235475	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_015235475.1_ASM1523547v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_018968045	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_018968045.1_ASM1896804v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_020224725	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_020224725.1_ASM2022472v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_020229655	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_020229655.1_ASM2022965v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_021403025	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_021403025.1_ASM2140302v1_genomic.gbff.gz	Staphylococcus xylosus
GCF_900458755	gs://<YOUR_BUCKET_NAME>/tutorial/GCF_900458755.1_41665_D01_genomic.gbff.gz	Staphylococcus xylosus
```

__*Be sure to replace <YOUR_BUCKET_NAME> with the bucket name we copied in the previous section!*__

Once you are done, click on the _START IMPORT JOB_ button.

If everything was susccessful, you should have a `rctyping_tutorial` table.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/71c64ce8-3a3c-40e1-a087-24cbdc6fad56)

We are almost ready to process the data! 

##### Create A Table Set

In the `rctyping_tutorial` table select every row:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/18d303dd-76e7-4d3f-a13a-ed41ebeaf521)

Then click the _Edit_ button, and select _Save seelction as a set_

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/f8deba61-8ac6-476d-840e-68ec931104a5)

Let's name it `tutorial-set` and click on the _SAVE_ button.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/54aa6590-cc46-425f-80f7-b3dad2c30459)

Now you should see a `rctyping_tutorial_set` table in your _TABLES_ section.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/9b6bda43-6660-4645-9014-bba5f949087a)

We now have everything in place to run the RCTyping workflow!

#### Processing Samples with RCTyping Workflow

Now that we have imported our data and created the necessary Workspace and Tables, let's go a head and run
the workflow for the first time.

Navigate to _WORKFLOWS_ and click on the _RCTyping_ workflow.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/fdcf627a-2a56-4582-b529-c5c9bc9d58a1)

We will need to select the _Run workflow(s) with inputs defined by data table_

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/a0be40af-f3ac-4b60-bdfe-f5bd2dabd76b)

For Step 1, we will use `rctyping_tutorial_set` for the _Select root entity type_:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/0db09dde-4e9c-40f9-b7a7-153581788ab3)

Then we'll click on the _SELECT DATA_ button, check the row with `tutorial-set`, and finally click the
_OK_ button.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/dd6e354a-a207-4f06-b10c-2dc178e9732b)

Now we will need to set the default input values, for the `genbank`, `rc_proteins`, and `species` variables.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/e70fe587-b134-40ed-b23d-a3c104c4a35b)

We'll use the following values:

_genbank_: this.rctying_tutorials.genbank  
_rc_proteins_: workspace.staphylococcus_xyulosus
_species_: "Staphylococcus xyulosus"

Enter these, then click the _SAVE_ button. After doing so, it should look like this:

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/cc620a89-046a-44c7-b592-b8ca37e87c6d)

Notice! We now have a _RUN ANALYSIS_ button available to us. Let's go ahead an run an analysis
on our input samples. Go ahead, click the _RUN_ANALYSIS_ button!

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/2735d7cd-8ac0-4637-ac67-4b60f9d6aef3)

Feel free to add your own description, but when ready click the _LAUNCH_ button.

This should take about 10-20 minutes to complete.

![image](https://github.com/jidc-trust/ribosomal-wdl/assets/5334269/7d24da99-647c-46cb-bed8-0fbb817d0fe8)

The outputs will be available from the _rctyping_tutorial_set_ table, and are described below
in this document.

That's all for the tutorial, good luck processing your own data!


## Local Installation

To run locally you will need to have [Cromwell](https://cromwell.readthedocs.io/en/stable/)
and [Docker](https://docs.docker.com/engine/install/) availble. With these two you will have
everything needed to run `ribosomal-wdl` on the command-line.

For now you should clone the `ribosomal-wdl` repository.

```{bash}
git clone git@github.com:jidc-trust/ribosomal-wdl.git
```

## Usage

### Inputs

`ribosomal-wdl` requires the following inputs:

### GenBank Files

For `ribosomal-wdl` you will need to provide a set of GenBank files from each of the samples
you would like to generate a tree from. These GenBank files can either be uncompressed or
compressed using Gzip, and they must be one of the following extensions: `.gbff`, `.gbk`,
`.gb`, or `.genbank`

#### __IMPORTANT NOTE__ - GenBank must use valid extension

Your input GenBank files must have one of the following extension: _'*.gbff', '*.gbff.gz', '*gbf', '*gbf.gz', '*.gbk', '*.gbk.gz', '*.gb', '*.gb.gz', '*.genbank', or '*.genbank.gz'_ 

If one of these extensions is not utilized, the pipeline will not process your files.

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

This directory should contain a FASTA file for each of the reference ribosomal proteins. To
learn more on generating this set of reference proteins, please see
[ribosomal_snakemake - Usage](https://github.com/jidc-trust/ribosomal_snakemake#usage). Otherwise
you can use the provided reference protein sets.

### Species Name

The final input required for `ribosomal-wdl` is a species name for the input samples. This is
a required input for `ribosomal_snakemake`.

## Executing `ribosomal-wdl`

If you have Cromwell and Docker, as well as your local copy of `ribosomal-wdl` available, 
you will be able to easily run `ribosomal-wdl` on the command-line.

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
