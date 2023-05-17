if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
library(DESeq2)
library(tidyverse)
library(ggplot2)
#load the read counts files

SRR6040094_counts<-read.delim("SRR6040094_06_counts.txt", header=FALSE) # MK aril2
SRR6040095_counts<-read.delim("SRR6040095_06_counts.txt", header=FALSE) # MK aril1
SRR6040097_counts<-read.delim("SRR6040097_06_counts.txt", header=FALSE) # MK aril3
SRR6156066_counts<-read.delim("SRR6156066_06_counts.txt", header=FALSE) # MT aril2
SRR6156067_counts<-read.delim("SRR6156067_06_counts.txt", header=FALSE) # MT aril3
SRR6156069_counts<-read.delim("SRR6156069_06_counts.txt", header=FALSE) # MT aril1

#merge the files into one table
counts<-merge(SRR6040094_counts,SRR6040095_counts,by="V1")
counts<-merge(counts,SRR6040097_counts,by="V1")
counts<-merge(counts,SRR6156066_counts,by="V1")
counts<-merge(counts,SRR6156067_counts,by="V1")
counts<-merge(counts,SRR6156069_counts,by="V1")

#name the col and remove first 5 rows
names(counts) <- c("gene","MK_aril2","MK_aril1","MK_aril3","MT_aril2","MT_aril3","MT_aril1")
counts<-counts[-c(1:5),]

without_gene_names<-counts[,-1]
without_gene_names

condition<-c("MK","MK","MK","MT","MT","MT")
#creat a metadata 
metadata <- data.frame(row.names=colnames(without_gene_names),condition)
metadata
counts_df <- data.frame(row.names=counts[,1], counts[2], 
                        counts[3], counts[4], 
                        counts[5], counts[6], 
                        counts[7])
counts_df
#DESeq2 create dds matrix
dds <- DESeqDataSetFromMatrix(countData=counts_df, colData=metadata, design= ~ condition)  
dds$condition <- relevel(dds$condition, ref = "MT")
dds$condition
dds
#keep the rows which have at least 10 counts
keep <- rowSums(counts(dds)) >= 10
dds2 <- dds[keep,]
dds2
#run the DESeq
deseq <- DESeq(dds2)
res <- results(deseq)   # store the dds Deseq result to res
res
summary(res)

res2 <- results(deseq, alpha = 0.05)  # set the padj value to 0.05
summary(res2)


#PCA
rld<-rlog(deseq)
colData(deseq)
plotPCA(rld,intgroup=c("condition"))

#Ordering
resOrdered <- res[order(res2$padj),]
resOrdered=as.data.frame(resOrdered)
head(resOrdered)
resOrdered=na.omit(resOrdered)
head(resOrdered)
write.csv(resOrdered,"resOrdered_fruits.csv")
diff<-subset(resOrdered,pvalue<0.05)
up<-subset(diff,log2FoldChange > 2)
down<-subset(diff,log2FoldChange < -2)

DEG_data <- resOrdered
DEG_data$logp <- -log10(DEG_data$padj)
dim(DEG_data)
DEG_data$group <- "not-significant"
DEG_data$group[which((DEG_data$padj < 0.05) & DEG_data$log2FoldChange>  2)]="up_regulated"
DEG_data$group[which((DEG_data$padj < 0.05) & DEG_data$log2FoldChange < -2)]="down_regulated"
table(DEG_data$group)
DEG_data<- DEG_data[order(DEG_data$padj),]

#Draw volcano plot
DEG_data$threshold = as.factor(ifelse(DEG_data$padj < 0.05 & abs(DEG_data$log2FoldChange) >= 1, ifelse(DEG_data$log2FoldChange> 1 ,'Up-regulated','Down-regulated'),'Not-Significant'))
ggplot(data = DEG_data, aes(x = log2FoldChange, y = -log10(padj), colour=threshold)) +
  geom_point(alpha=0.4, size=3.5) +
  scale_color_manual(values=c("blue", "grey","red"))
  

#Heatmap#
select<- head(order(res2$padj), 10)  #for top 10 padj genes
nt<-normTransform(deseq)
log2.norm.counts<-assay(nt)[select,]
df<-as.data.frame(colData(deseq))

library(pheatmap)
pheatmap(log2.norm.counts,cluster_rows = TRUE,show_rownames = TRUE,cluster_cols = TRUE,annotation_col = df)


