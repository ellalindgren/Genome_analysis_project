#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=32G
#SBATCH -t 24:00:00
#SBATCH -J pilon_chr3
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ellal/genome_analysis/analyses/03_polish/%x.%j.out

module load BWA
module load SAMtools
module load Pilon

ASSEMBLY="analyses/02_assembly/run1/chr3_assembly.contigs.fasta"
ILLUMINA_R1="analyses/01_preprocessing/02_trimming/chr3_illumina_R1_paired.fq.gz"
ILLUMINA_R2="analyses/01_preprocessing/02_trimming/chr3_illumina_R2_paired.fq.gz"
OUT_DIR="analyses/03_polish"

# index assembly
echo "Indexing assembly..."
bwa index $ASSEMBLY

# Map Illumina reads and sort
echo "Mapping reads with BWA-MEM..."
bwa mem -t 2 $ASSEMBLY $ILLUMINA_R1 $ILLUMINA_R2 | \
samtools view -Sb - | \
samtools sort -@ 2 -o $OUT_DIR/aligned_reads.sorted.bam

# Index the BAM
echo "Indexing BAM file..."
samtools index $OUT_DIR/aligned_reads.sorted.bam

#  Run Pilon
echo "Running Pilon polishing..."

java -Xmx30G -jar $EBROOTPILON/pilon.jar \
    --genome $ASSEMBLY \
    --bam $OUT_DIR/aligned_reads.sorted.bam \
    --outdir $OUT_DIR \
    --output chr3_polished \
    --vcf \
    --changes

echo "Done"
