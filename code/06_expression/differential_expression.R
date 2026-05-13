# 1. Install/Load DESeq2
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")


library(DESeq2)

# 2. Load the data
count_data <- read.table("read_counts.txt", header=TRUE, row.names=1, check.names=FALSE)

# 3. Clean the table, only relevant columns
counts <- count_data[, 6:7]

# 4. Simplify Column Names
colnames(counts) <- c("Control", "Treated")

# 5. Create Metadata
# This tells DESeq2 which column belongs to which group
sample_info <- data.frame(
  condition = factor(c("control", "treated")),
  row.names = colnames(counts)
)

# 6. Create the DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = sample_info,
                              design = ~ condition)

# 7. Handle the "No Replicates" issue 
dds <- estimateSizeFactors(dds)

# Model the noise to ensure that small gene expression changes are not mistaken for biological signals
mcols(dds)$dispersion <- 0.1

# 8. Run the Wald test directly
dds <- nbinomWaldTest(dds)
res <- results(dds)

# 9. View results
summary(res)

# Volanco plot
# 1. Expand limits to prevent clipping
max_lfc <- max(abs(res$log2FoldChange), na.rm = TRUE) + 2
max_pval <- max(-log10(res$padj), na.rm = TRUE) + 5

# 2. Create the plot
plot(res$log2FoldChange, -log10(res$padj), 
     pch=20, 
     main="Volcano Plot: N. japonicum Chromosome 3 (Heat vs Control)",
     xlab="log2 Fold Change", 
     ylab="-log10 Adjusted P-value",
     xlim=c(-max_lfc, max_lfc), 
     ylim=c(0, max_pval),
     col=ifelse(res$padj < 0.1 & abs(res$log2FoldChange) > 1, "red", "black"))

# 3. Add lines
abline(h=-log10(0.1), col="blue", lty=2)
abline(v=c(-1, 1), col="blue", lty=2)

# 4. Smart labeling (labels move away from the margins)
# Left side (Downregulated)
text(res["g641",]$log2FoldChange, -log10(res["g641",]$padj), 
     labels="g641", pos=4, cex=0.8, col="darkblue")

# Right side (Upregulated)
top_up <- c("g1103", "g2253", "g2059")
text(res[top_up,]$log2FoldChange, -log10(res[top_up,]$padj), 
     labels=top_up, pos=2, cex=0.8, col="darkred")
