#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J DNA_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x

module load bioinfo-tools
module load bwa/0.7.17

bwa index /home/leizhao/Genome_Analysis/results/02_Canu/Canu_assembly_scaffold_06.contigs.fasta

bwa mem -t 2 /home/leizhao/Genome_Analysis/results/02_Canu/Canu_assembly_scaffold_06.contigs.fasta \
/home/leizhao/Genome_Analysis/data/raw_data/illumina_data/SRR6058604_scaffold_06.1P.fastq.gz \
/home/leizhao/Genome_Analysis/data/raw_data/illumina_data/SRR6058604_scaffold_06.2P.fastq.gz \
> /home/leizhao/Genome_Analysis/results/03_BWA_DNA_mapping/DNA_bwa_align.sam
