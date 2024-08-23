version 1.0

import "../tasks/task_rctyping.wdl" as rc_snakemake_task

workflow rctyping {
  meta {
    description: "A WDL wrapper around the ribosomal typing Snakemake pipeline."
  }
  input {
    Array[File] genbank
    File rc_proteins
    String species
  }
  call rc_snakemake_task.ribosomal_snakemake as rc_snakemake {
    input:
      genbank = genbank,
      rc_proteins = rc_proteins,
      species = species
  }
  output {
    String rctype_version = rc_snakemake.rctype_version
    String rctype_analysis_date = rc_snakemake.analysis_date
    File rctype_fasta = rc_snakemake.rctype_fasta
    File rctype_deduped_fasta = rc_snakemake.rctype_deduped_fasta
    File rctype_aln = rc_snakemake.rctype_aln
    File rctype_proteins_fasta = rc_snakemake.rctype_proteins_fasta
    File rctype_proteins_fasta2 = rc_snakemake.rctype_proteins_fasta2
    File rctype_extracted_fasta = rc_snakemake.rctype_extracted_fasta
    File rctype_recovered_fasta = rc_snakemake.rctype_recovered_fasta
  }
}
