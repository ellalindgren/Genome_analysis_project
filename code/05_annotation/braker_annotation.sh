#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH --mem=64G
#SBATCH -J braker_annotation
#SBATCH --output=/home/ellal/genome_analysis/analyses/05_annotation/%x.%j.out

# Set the path for the config copied
export AUGUSTUS_CONFIG_PATH=/home/ellal/bin/augustus_config/


# Paths
GENOME="/home/ellal/genome_analysis/analyses/05_annotation/repeat_masking/chr3_polished.fasta.masked"
BAM_FILE="/home/ellal/genome_analysis/analyses/05_annotation/hisat2_mapped_data/merged_rnaseq.bam"
OUT_DIR="/home/ellal/genome_analysis/analyses/05_annotation/braker"
BRAKER_SIF="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif"

mkdir -p $OUT_DIR
export TMPDIR=$OUT_DIR/tmp
mkdir -p $TMPDIR

# Run BRAKER3
singularity exec --cleanenv \
  -B /home/ellal:/home/ellal \
  -B /crex:/crex \
  -B /home/ellal/bin/augustus_config:/opt/Augustus/config \
  $BRAKER_SIF \
  braker.pl \
    --genome=$GENOME \
    --bam=$BAM_FILE \
    --species=Niphotrichum_japonicum_1 \
    --threads=2 \
    --min_contig=5000 \
    --workingdir=$OUT_DIR \
    --softmasking \
    --skipOptimize
