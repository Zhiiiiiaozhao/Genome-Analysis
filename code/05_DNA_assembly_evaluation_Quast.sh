#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J DNA_assembly_evaluation
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools quast

quast.py \
-o /home/leizhao/Genome_Analysis/results/05_Quast_DNA_assembly_evaluation/pilon \
-r /home/leizhao/Genome_Analysis/results/05_Quast_DNA_assembly_evaluation/reference_scaffold_06.fasta \
--eukaryote \
/home/leizhao/Genome_Analysis/results/04_Pilon_DNA_assembly_polish/DNA_assembly_polish_Pilon.fasta
