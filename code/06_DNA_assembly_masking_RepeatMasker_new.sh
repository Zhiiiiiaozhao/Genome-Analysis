#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 24:00:00
#SBATCH -J DNA_assembly_masking
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools 
module load RepeatModeler
module load RepeatMasker

BuildDatabase -name mySpecies /home/leizhao/Genome_Analysis/results/04_Pilon_DNA_assembly_polish/DNA_assembly_polish_Pilon.fasta
RepeatModeler -database mySpecies -pa 4

RepeatMasker -pa 4 -xsmall -lib mySpecies-families.fa -dir /proj/genomeanalysis2023/nobackup/work/leizhao/06_RepeatMasker_DNA_assembly_masking /home/leizhao/Genome_Analysis/results/04_Pilon_DNA_assembly_polish/DNA_assembly_polish_Pilon.fasta

