#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 03:00:00
#SBATCH -J RNA_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

module load bioinfo-tools star/2.7.9a

STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--genomeFastaFiles /home/leizhao/Genome_Analysis/results/06_RepeatMasker_DNA_assembly_masking/DNA_assembly_polish_Pilon.fasta.masked

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/results/08_Trimmomatic_RNA_trimming/RNA_trimmed_*P.fq.gz \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040095_06_ \
--outSAMtype BAM SortedByCoordinate 


STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6040092_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040092_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6040093_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040093_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6040094_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040094_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6040096_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040096_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6040097_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6040097_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6156066_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6156066_06_ \
--outSAMtype BAM SortedByCoordinate

STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6156067_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6156067_06_ \
--outSAMtype BAM SortedByCoordinate


STAR --runThreadN 8 \
--genomeDir /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping \
--readFilesIn /home/leizhao/Genome_Analysis/data/raw_data/transcriptome/trimmed/SRR6156069_scaffold_06.* \
--readFilesCommand zcat \
--outFileNamePrefix /home/leizhao/Genome_Analysis/results/10_STAR_RNA_mapping/SRR6156069_06_ \
--outSAMtype BAM SortedByCoordinate

