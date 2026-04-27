#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH -J hisat2_mapping
#SBATCH --output=/home/ellal/genome_analysis/analyses/05_annotation/hisat2_map.%j.out

module load HISAT2
module load SAMtools

INDEX="/home/ellal/genome_analysis/analyses/05_annotation/hisat2_index/hisat2_idx"
DATA_DIR="/home/ellal/genome_analysis/data/raw_data/reads/transcriptomic_data"
OUT_DIR="/home/ellal/genome_analysis/analyses/05_annotation/hisat2_mapped_data"

mkdir -p $OUT_DIR

# Sample 1: Control
echo "Mapping Control_1..."
hisat2 -p 2 -x $INDEX --dta \
    -1 $DATA_DIR/Control_1_f1.fq.gz \
    -2 $DATA_DIR/Control_1_r2.fq.gz \
    | samtools view -bS - | samtools sort -@ 2 -o $OUT_DIR/Control_1.sorted.bam

# Sample 2: Treated
echo "Mapping Heat_treated_1..."
hisat2 -p 2 -x $INDEX --dta \
    -1 $DATA_DIR/Heat_treated_42_12h_1_f1.fq.gz \
    -2 $DATA_DIR/Heat_treated_42_12h_1_r2.fq.gz \
    | samtools view -bS - | samtools sort -@ 2 -o $OUT_DIR/Treated_1.sorted.bam

# Final Merge & Index 
echo "Merging and Indexing..."
samtools merge -@ 2 $OUT_DIR/merged_rnaseq.bam $OUT_DIR/Control_1.sorted.bam $OUT_DIR/Treated_1.sorted.bam
samtools index $OUT_DIR/merged_rnaseq.bam

echo "Done"
