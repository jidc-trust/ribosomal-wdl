version 1.0

task ribosomal_snakemake {
  input {
    Array[File] genbank
    File rc_proteins
    String species
    String docker="us-central1-docker.pkg.dev/general-theiagen/jidc-trust/ribosomal-wdl:1.0.0"
    Int memory = 32
    Int cpu = 4
    Int disk_size = 50
  }
  command <<<
    date | tee DATE

    # ribosomal_snakemake does not have a version output
    cat /ribosomal_snakemake/version | tee RCTYPE_VERSION

    # Compressed GenBank files are not supported
    # must create a "cleannames.txt" file
    # Genbank files also must be in PWD
    genbank_array=(~{sep=' ' genbank})
    touch cleannames.txt
    for index in ${!genbank_array[@]}; do
      gb=${genbank_array[$index]}
      gb_name=$(basename $gb | sed 's/.gz//') 
      if [[ $gb == *.gz ]]; then
        gunzip --stdout $gb > $gb_name
      fi
      echo $gb_name >> cleannames.txt
    done

    # Extract input RC Proteins
    tar -xzvf ~{rc_proteins}

    # copy Ribosomal_snakemake to current directory
    cp -r /ribosomal_snakemake/* ./
    cp example_files/config.yaml ./
    mkdir logs
    echo "~{species}" > genus.txt

    # Run ribosomal snakemake
    if snakemake --cores ~{cpu}; then
      # ribosomal_snakemake prefixes outputs with DD-MM-YY
      # replace to make capturing easier
      for f in $(ls $(date +"%d-%m-%y")*); do
        mv "$f" "$(echo "$f" | sed s/$(date +"%d-%m-%y")/rctype_/)"
      done
    else
      # Run failed
      exit 1
    fi
  >>>
  output {
    String rctype_version = read_string("RCTYPE_VERSION")
    String rctype_docker = docker
    String analysis_date = read_string("DATE")
    File rctype_fasta = "rctype_.updateriboprot.fasta"
    File rctype_deduped_fasta = "rctype_.updateriboprot.fastadedupe.fasta"
    File rctype_aln = "rctype_.updateriboprotdedupe.aln"
    File rctype_treefile = "rctype_.updateriboprotdedupe.aln.treefile"
    File rctype_proteins_fasta = "rctype_concatenated_ribosomal_proteins_db.fasta"
    File rctype_proteins_fasta2 = "rctype_concatenated_ribosomal_proteins_db.fasta_2"
    File rctype_extracted_fasta = "rctype_extracted.fasta"
    File rctype_recovered_fasta = "rctype_recovered.fasta"
  }
  runtime {
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: cpu
    disks: "local-disk ~{disk_size} SSD"
    maxRetries: 3
    preemptible: 0
  }
}
