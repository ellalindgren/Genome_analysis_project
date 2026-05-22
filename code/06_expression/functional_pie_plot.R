library(ggplot2)
library(dplyr)

# 1. Load and Clean 
anno <- read.delim("/Users/ellalindgren/Library/CloudStorage/OneDrive-Uppsalauniversitet/Genomanalys/Project/chr3_functional.emapper.annotations", skip=4, header=FALSE)
cog_data <- anno$V7[anno$V7 != "-" & anno$V7 != ""]

# 2. Create counts and sort by size
cog_counts <- as.data.frame(table(cog_data))
colnames(cog_counts) <- c("Category", "Count")
cog_counts <- cog_counts %>% arrange(desc(Count))

# 3. Define the "Full Names" for the legend
cog_lookup <- c(
  "S" = "Function Unknown",
  "O" = "Post-translational modification",
  "R" = "General function prediction only",
  "G" = "Carbohydrate metabolism",
  "E" = "Amino acid metabolism",
  "T" = "Signal transduction",
  "J" = "Translation",
  "K" = "Transcription",
  "L" = "Replication / Repair"
)

# 4. Keep Top 6 and lump the rest into "Other"
top_n <- 6
main_categories <- head(cog_counts, top_n)
other_categories <- tail(cog_counts, -top_n)

# Combine them
final_counts <- main_categories
final_counts <- rbind(final_counts, data.frame(Category = "Other", Count = sum(other_categories$Count)))

# 5. Replace Letters with Full Names
final_counts$FullName <- ifelse(final_counts$Category %in% names(cog_lookup), 
                                cog_lookup[as.character(final_counts$Category)], 
                                as.character(final_counts$Category))

# 6. Plot with professional colors
ggplot(final_counts, aes(x="", y=Count, fill=reorder(FullName, -Count))) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  scale_fill_brewer(palette="Set3") + # Clean, professional color palette
  labs(title="Functional Landscape (COG) of Chromosome 3",
       fill="Functional Category") +
  theme(legend.text = element_text(size = 10))
