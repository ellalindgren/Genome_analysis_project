#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 00:30:00
#SBATCH -J reads_quality_trimmed
#SBATCH --output=analyses/01_preprocessing/03_quality/reads_quality_trimmed_%j.out

module load FastQC

IN_DIR="analyses/01_preprocessing/02_trimming"

OUT_DIR="analyses/01_preprocessing/03_quality"

fastqc $IN_DIR/*_paired.fq.gz -o $OUT_DIR
