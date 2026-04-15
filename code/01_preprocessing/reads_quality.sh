#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_chr3
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ella.lindgren.9076@student.uu.se
#SBATCH --output=%x.%j.out

module load FastQC

fastqc /home/ellal/genome_analysis/data/raw_data/reads/genomics_chr3_data/chr3_*.fastq.gz -o /home/ellal/genome_analysis/analyses/01_preprocessing
