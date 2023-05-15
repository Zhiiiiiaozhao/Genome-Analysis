#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:20:00
#SBATCH -J DNA_assembly_evaluation
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools quast


#with reference
quast.py \
-o /home/leizhao/Genome_Analysis/results/05_Quast_DNA_assembly_evaluation \
-r /home/leizhao/Genome_Analysis/results/05_Quast_DNA_assembly_evaluation/reference_scaffold_06.fasta \
--eukaryote \
/home/leizhao/Genome_Analysis/results/04_Pilon_DNA_assembly_polish/DNA_assembly_polish_Pilon.fasta \
/home/leizhao/Genome_Analysis/results/02_Canu/Canu_assembly_scaffold_06.contigs.fasta



