#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J hisat2_index
#SBATCH --output=/home/ellal/genome_analysis/analyses/05_annotation/%x.%j.out

module load HISAT2

GENOME="/home/ellal/genome_analysis/analyses/03_polish/chr3_polished.fasta"
INDEX_DIR="/home/ellal/genome_analysis/analyses/05_annotation/hisat2_index"

mkdir -p $INDEX_DIR

hisat2-build -p 2 $GENOME $INDEX_DIR/hisat2_idx
