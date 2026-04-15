#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=16G
#SBATCH -t 02:00:00
#SBATCH -J fastqc_chr3_nanopore
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ellal/genome_analysis/analyses/01_preprocessing/01_quality/%x.%j.out

module load FastQC
IN_DIR="/home/ellal/genome_analysis/data/raw_data/reads/genomics_chr3_data"
OUT_DIR="/home/ellal/genome_analysis/analyses/01_preprocessing/01_quality"

fastqc $IN_DIR/chr3_clean_nanopore.fq.gz -o $OUT_DIR
