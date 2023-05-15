#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J Illumina_QC_bf
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

module load bioinfo-tools FastQC

fastqc -o /home/leizhao/Genome_Analysis/results/01_FastQC  /home/leizhao/Genome_Analysis/data/raw_data/illumina_data/SRR6058604_scaffold_06.*P.fastq.gz

