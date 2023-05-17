if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
library(DESeq2)
library(tidyverse)
library(ggplot2)
#load the read counts files
SRR6040092_counts<-read.delim("SRR6040092_06_counts.txt", header=FALSE) # MK leaf
SRR6040093_counts<-read.delim("SRR6040093_06_counts.txt", header=FALSE) # MK root
SRR6040096_counts<-read.delim("SRR6040096_06_counts.txt", header=FALSE) # MK stem
SRR6040094_counts<-read.delim("SRR6040094_06_counts.txt", header=FALSE) # MK aril2
SRR6040095_counts<-read.delim("SRR6040095_06_counts.txt", header=FALSE) # MK aril1
SRR6040097_counts<-read.delim("SRR6040097_06_counts.txt", header=FALSE) # MK aril3
SRR6156066_counts<-read.delim("SRR6156066_06_counts.txt", header=FALSE) # MT aril2
SRR6156067_counts<-read.delim("SRR6156067_06_counts.txt", header=FALSE) # MT aril3
SRR6156069_counts<-read.delim("SRR6156069_06_counts.txt", header=FALSE) # MT aril1

#merge the files into one table
counts<-merge(SRR6040092_counts,SRR6040093_counts,by="V1")
counts<-merge(counts,SRR6040096_counts,by="V1")
counts<-merge(counts,SRR6040094_counts,by="V1")
counts<-merge(counts,SRR6040095_counts,by="V1")
counts<-merge(counts,SRR6040097_counts,by="V1")
counts<-merge(counts,SRR6156066_counts,by="V1")
counts<-merge(counts,SRR6156067_counts,by="V1")
counts<-merge(counts,SRR6156069_counts,by="V1")

#name the col and remove first 5 rows
names(counts) <- c("gene","MK_leaf","MK_root","MK_stem","MK_aril2","MK_aril1","MK_aril3","MT_aril2","MT_aril3","MT_aril1")
counts<-counts[-c(1:5),]

without_gene_names<-counts[,-1]
without_gene_names

condition<-c("nonfruit","nonfruit","nonfruit","fruit","fruit","fruit","fruit","fruit","fruit")
cultivar<-c("MK","MK","MK","MK","MK","MK","MT","MT","MT")
#creat a metadata 
metadata <- data.frame(row.names=colnames(without_gene_names),condition,cultivar)
metadata
counts_df <- data.frame(row.names=counts[,1], counts[2], 
                        counts[3], counts[4], 
                        counts[5], counts[6], 
                        counts[7],counts[8],counts[9], counts[10])
counts_df
#DESeq2 create dds matrix
dds <- DESeqDataSetFromMatrix(countData=counts_df, colData=metadata, design= ~ condition)  
dds$condition <- relevel(dds$condition, ref = "nonfruit")
dds$condition
#keep the rows which have at least 10 counts
keep <- rowSums(counts(dds)) >= 10
dds2 <- dds[keep,]
dds2
dds2$condition<- relevel(dds2$condition, ref = "nonfruit")
#run the DESeq
deseq <- DESeq(dds2)
# store the dds Deseq result to res
res <- results(deseq)   
res
summary(res)
# set the padj value to 0.05
res2 <- results(deseq, alpha = 0.05) 
summary(res2)


#PCA
rld<-rlog(deseq)
colData(deseq)
plotPCA(rld,intgroup=c("condition","cultivar"))

#Ordering
resOrdered <- res[order(res2$padj),]
resOrdered=as.data.frame(resOrdered)
head(resOrdered)
resOrdered=na.omit(resOrdered)
head(resOrdered)
write.csv(resOrdered,"resOrdered.csv")
DEG_data <- resOrdered
#Draw volcano plot
DEG_data$threshold = as.factor(ifelse(DEG_data$padj < 0.05 & abs(DEG_data$log2FoldChange) >= 1, ifelse(DEG_data$log2FoldChange> 1 ,'Up-regulated','Down-regulated'),'Not-Significant'))
ggplot(data = DEG_data, aes(x = log2FoldChange, y = -log10(padj), colour=threshold)) +
  geom_point(alpha=0.4, size=3.5) +
  scale_color_manual(values=c("blue", "grey","red"))+
  ylim(0,25)+
  xlim(-15,15)
#Heatmap#
select<- head(order(res2$padj), 15)  #for top 15 padj genes
nt<-normTransform(deseq)
log2.norm.counts<-assay(nt)[select,]
df<-as.data.frame(colData(deseq))
df
library(pheatmap)
pheatmap(log2.norm.counts,cluster_rows = TRUE,show_rownames = TRUE,cluster_cols = TRUE,annotation_col = df)


