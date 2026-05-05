#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH --mem=64G
#SBATCH -J eggnog_functional
#SBATCH --output=/home/ellal/genome_analysis/analyses/05_annotation/eggnog.%j.out

module load eggnog-mapper

# Paths
INPUT_PROT="/home/ellal/genome_analysis/analyses/05_annotation/braker/braker.aa"
OUT_DIR="/home/ellal/genome_analysis/analyses/05_annotation/functional"
mkdir -p $OUT_DIR

# Run eggNOG-mapper
emapper.py \
    -i $INPUT_PROT \
    --output chr3_functional \
    --output_dir $OUT_DIR \
    --cpu 2 \
    --itype proteins \
    --data_dir /sw/data/eggNOG/5.0.0/rackham/
echo "Done"
