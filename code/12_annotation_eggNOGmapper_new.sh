#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J annotation_eggNOGmapper
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

module load bioinfo-tools eggNOG-mapper/2.1.9

/sw/bioinfo/eggNOG-mapper/2.1.9/snowy/bin/emapper.py -i /proj/genomeanalysis2023/nobackup/work/leizhao/06_RepeatMasker_DNA_assembly_masking/DNA_assembly_polish_Pilon.fasta.masked --itype genome --output functional_annotation --output_dir /proj/genomeanalysis2023/nobackup/work/leizhao/12_eggNOGmapper_annotation --cpu 4

