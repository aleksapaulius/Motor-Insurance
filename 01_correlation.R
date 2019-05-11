# CORRELATION ------------------------------------------------------------------

cor.names <- c("spearman")

cor.df <- mdata[,!(names(mdata) %in% c('policy_desc'))]
cor.df <- lapply(cor.df, as.numeric) %>% data.frame()


# calculating correlation

for (i in cor.names) {
  all.cor <- cor(cor.df, use = 'complete.obs', method = i)
  assign(paste0("cor.", i), melt(cor(cor.df, use = 'complete.obs'), variable.factor=FALSE))
}


# Correlogram

corr <- round(all.cor, 2)

pdf(file="plots/Correlogram.pdf",width = 16, height = 12)
corr.plot1 <- ggcorrplot(corr, hc.order = TRUE, 
                         type = "lower", 
                         lab = TRUE, 
                         lab_size = 3, 
                         method="square", 
                         colors = c("tomato2", "white", "springgreen3"), 
                         title="Correlogram", 
                         ggtheme=theme_bw)
print(corr.plot1)
dev.off()
