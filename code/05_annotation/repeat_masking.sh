#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J repeat_masker
#SBATCH --output=/home/ellal/genome_analysis/analyses/05_annotation/%x.%j.out

module load RepeatMasker


OUT_DIR="/home/ellal/genome_analysis/analyses/05_annotation/repeat_masking"


mkdir -p $OUT_DIR

# -xsmall performs softmasking (converts repeats to lowercase)
RepeatMasker \
    -pa 4 \
    -xsmall \
    -species "land plants" \
    -dir $OUT_DIR \
    /home/ellal/genome_analysis/analyses/03_polish/chr3_polished.fasta
