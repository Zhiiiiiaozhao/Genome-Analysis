#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 20:00:00
#SBATCH -J annotation_braker
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1

cp -vf /sw/bioinfo/GeneMark/4.33-es/snowy/gm_key $HOME/.gm_key
source $AUGUSTUS_CONFIG_COPY
chmod a+w -R /home/leizhao/Genome_Analysis/code/11_annotation_BRAKER/augustus_config/species/



braker.pl --AUGUSTUS_CONFIG_PATH=/home/leizhao/Genome_Analysis/code/11_annotation_BRAKER/augustus_config \
--AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin \
--AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts \
--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.33-es/snowy \
--species=Durio_zibethinus \
--useexisting \
--genome=/home/leizhao/Genome_Analysis/results/06_RepeatMasker_DNA_assembly_masking/DNA_assembly_polish_Pilon.fasta.masked \
--bam=/home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/*.sortedByCoord.out.bam \
--workingdir=/home/leizhao/Genome_Analysis/results/11_BRAKER_annotation \
--softmasking \
--cores=8 \
--gff3
