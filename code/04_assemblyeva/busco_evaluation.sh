#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J busco_evaluation
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ellal/genome_analysis/analyses/04_assemblyeva/02_buscoeva/%x.%j.out

module load SAMtools
module load BUSCO


POLISHED_ASM="analyses/03_polish/chr3_polished.fasta"
OUT_DIR="analyses/04_assemblyeva/02_buscoeva"



echo "Running BUSCO..."
busco -i $POLISHED_ASM -o busco_results --out_path $OUT_DIR -m genome -l embryophyta_odb10 --cpu 2


