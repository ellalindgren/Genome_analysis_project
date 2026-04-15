#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J trimmomatic_chr3
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ella.lindgren.9076@student.uu.se
#SBATCH --output=analyses/01_preprocessing/trimmomatic_%j.out


module load Trimmomatic/0.39-Java-17

IN_DIR="data/raw_data/reads/genomics_chr3_data"
OUT_DIR="analyses/01_preprocessing"

# 3. Run Trimmomatic
trimmomatic PE -threads 2 \
$IN_DIR/chr3_illumina_R1.fastq.gz $IN_DIR/chr3_illumina_R2.fastq.gz \
$OUT_DIR/chr3_illumina_R1_paired.fq.gz $OUT_DIR/chr3_illumina_R1_unpaired.fq.gz \
$OUT_DIR/chr3_illumina_R2_paired.fq.gz $OUT_DIR/chr3_illumina_R2_unpaired.fq.gz \
ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10:2:True \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
