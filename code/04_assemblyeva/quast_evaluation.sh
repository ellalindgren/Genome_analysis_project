#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J quast_evaluation
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ellal/genome_analysis/analyses/04_assemblyeva/%x.%j.out

module load SAMtools
module load QUAST


POLISHED_ASM="analyses/03_polish/chr3_polished.fasta"
OUT_DIR="analyses/04_assemblyeva/01_quasteva"



echo "Running QUAST..."
quast.py $POLISHED_ASM -o $OUT_DIR/quast_results
