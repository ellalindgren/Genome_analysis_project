#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 20:00:00
#SBATCH -J canu_assembly_chr3
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ellal/genome_analysis/analyses/02_assembly/%x.%j.out


module load canu
module load SAMtools

IN_FILE="/home/ellal/genome_analysis/data/raw_data/reads/genomics_chr3_data/chr3_clean_nanopore.fq.gz"
OUT_DIR="/home/ellal/genome_analysis/analyses/02_assembly/run1"

canu \
 -p chr3_assembly \
 -d $OUT_DIR \
 genomeSize=2.5m \
 gridOptions="-A uppmax2026-1-61 -M pelle -t 12:00:00" \
 maxThreads=2 \
 corThreads=2 \
 oeaThreads=2 \
 cnsThreads=2 \
 -nanopore $IN_FILE
