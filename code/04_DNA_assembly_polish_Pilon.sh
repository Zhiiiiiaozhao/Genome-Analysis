#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J DNA_assembly_polish_Pilon
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools
module load Pilon
module load samtools

#path to bwa alignments files
bwa_path=/home/leizhao/Genome_Analysis/results/03_BWA_DNA_mapping
genome_path=/home/leizhao/Genome_Analysis/results/02_Canu

samtools sort $bwa_path/DNA_bwa_align.sam -o $bwa_path/DNA_bwa_align.bam
samtools index $bwa_path/DNA_bwa_align.bam $bwa_path/DNA_bwa_align.bai

java -Xmx16G -jar /sw/apps/bioinfo/Pilon/1.24/rackham/pilon-1.24.jar --genome $genome_path/Canu_assembly_scaffold_06.contigs.fasta --bam $bwa_path/DNA_bwa_align.bam --output DNA_assembly_polish_Pilon --outdir /home/leizhao/Genome_Analysis/results/04_Pilon_DNA_assembly_polish --diploid --threads 2
