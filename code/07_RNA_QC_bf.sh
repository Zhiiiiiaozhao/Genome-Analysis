#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J RNA_QC_bf
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools  FastQC/0.11.9

fastqc -o /home/leizhao/Genome_Analysis/results/07_FastQC_RNA_bf /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/untrimmed/SRR6040095_scaffold_06.*.fastq.gz 

