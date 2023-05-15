#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J RNA_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools trinity/2.4.0
	
Trinity --genome_guided_bam /proj/genomeanalysis2023/nobackup/work/leizhao/14_Trinity_RNA_assembly/merged_STAR.bam --CPU 4 --max_memory 50G --genome_guided_max_intron 10000 --output /proj/genomeanalysis2023/nobackup/work/leizhao/14_Trinity_RNA_assembly
