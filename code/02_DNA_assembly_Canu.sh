#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J DNA_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

module load bioinfo-tools canu

canu \
 -p Canu_assembly_scaffold_06  -d /home/leizhao/Genome_Analysis/results/02_Canu \
 genomeSize=27m \
 corThreads=4 useGrid=False \
 -pacbio-raw /home/leizhao/Genome_Analysis/data/raw_data/pacbio_data/SRR6037732_scaffold_06.fq.gz

