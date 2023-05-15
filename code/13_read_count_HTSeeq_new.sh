#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J read_count_HTSeq
#SBATCH --mail-type=ALL
#SBATCH --mail-user lei.zhao.1300@student.uu.se

set -x
cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

module load bioinfo-tools
module load samtools
module load htseq/2.0.2

bam_path=/proj/genomeanalysis2023/nobackup/work/leizhao/10_STAR_RNA_mapping
gff_path=/proj/genomeanalysis2023/nobackup/work/leizhao/11_BRAKER_annotation

for file in $bam_path/*.bam
do
        samtools index $file
done

cd /proj/genomeanalysis2023/nobackup/work/leizhao/13_HTSeq_read_counting


heseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040092_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040092_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040093_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040093_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040094_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040094_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040095_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040095_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040096_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040096_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6040097_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6040097_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6156066_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6156066_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6156067_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6156067_06_counts.txt
htseq-count -f bam -t exon -i "ID" -r pos  $bam_path/SRR6156069_06_Aligned.sortedByCoord.out.bam $gff_path/augustus.hints.gff3 > SRR6156069_06_counts.txt
