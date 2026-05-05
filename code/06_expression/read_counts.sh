#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH --mem=8G
#SBATCH -J featureCounts_moss
#SBATCH --output=/home/ellal/genome_analysis/analyses/06_expression/counts.%j.out


module load Subread
 
GTF_CLEAN="/home/ellal/genome_analysis/analyses/05_annotation/braker/braker_cleaned.gtf"
BAM_DIR="/home/ellal/genome_analysis/analyses/05_annotation/hisat2_mapped_data"
OUT_DIR="/home/ellal/genome_analysis/analyses/06_expression"
mkdir -p $OUT_DIR

# Run featureCounts
featureCounts \
    -p \
    -t exon \
    -g gene_id \
    -a $GTF_CLEAN \
    -o $OUT_DIR/read_counts.txt \
    $BAM_DIR/Control_1.sorted.bam \
    $BAM_DIR/Treated_1.sorted.bam

echo "Done"
