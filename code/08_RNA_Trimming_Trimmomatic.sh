#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J RNA_trimming
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools trimmomatic

java -jar /sw/apps/bioinfo/trimmomatic/0.39/rackham/trimmomatic-0.39.jar PE \
/home/leizhao/Genome_Analysis/data/raw_data/transcriptome/untrimmed/SRR6040095_scaffold_06.1.fastq.gz \
/home/leizhao/Genome_Analysis/data/raw_data/transcriptome/untrimmed/SRR6040095_scaffold_06.2.fastq.gz \
-baseout /home/leizhao/Genome_Analysis/results/08_Trimmomatic_RNA_trimming/RNA_trimmed.fq.gz \
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
