# 1. Install/Load DESeq2
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
install("DESeq2") 

library(DESeq2)

# 2. Load the data
count_data <- read.table("read_counts.txt", header=TRUE, row.names=1, check.names=FALSE)

# 3. Clean the table
counts <- count_data[, 6:7]

# 4. Simplify Column Names
colnames(counts) <- c("Control", "Treated")

# 5. Create Metadata
sample_info <- data.frame(
  condition = factor(c("control", "treated")),
  row.names = colnames(counts)
)

# 6. Create the DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = sample_info,
                              design = ~ condition)

# 7. Handle the "No Replicates"
dds <- estimateSizeFactors(dds)

mcols(dds)$dispersion <- 0.1

# 8. Run the Wald test directly
dds <- nbinomWaldTest(dds)
res <- results(dds)

# 9. View results
summary(res)
