# 1. Install/Load DESeq2
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
# Following your instructions for version compatibility if needed:
# BiocManager::install("DESeq2") 

library(DESeq2)

# 2. Load the data
# featureCounts output has a 6-line header we usually skip, 
# or we just read it and fix the columns.
count_data <- read.table("read_counts.txt", header=TRUE, row.names=1, check.names=FALSE)

# 3. Clean the table
# featureCounts includes Chr, Start, End, Strand, and Length (columns 1-5)
# We only want the actual count columns (columns 6 and 7)
counts <- count_data[, 6:7]

# 4. Simplify Column Names
# Your current names are long paths. Let's rename them to match your conditions.
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

# 7. Handle the "No Replicates" issue (Manual override)
# We must estimate size factors first
dds <- estimateSizeFactors(dds)

# Manually set the dispersion because we can't estimate it from 1 sample
# 0.1 is a conservative estimate for biological data
mcols(dds)$dispersion <- 0.1

# 8. Run the Wald test directly
dds <- nbinomWaldTest(dds)
res <- results(dds)

# 9. View results
summary(res)
