#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J RNA_QC_af
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools  FastQC/0.11.9


fastqc -o /home/leizhao/Genome_Analysis/results/09_FastQC_RNA_af /home/leizhao/Genome_Analysis/results/08_Trimmomatic_RNA_trimming/RNA_trimmed_*P.fq.gz
