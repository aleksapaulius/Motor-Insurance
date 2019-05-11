
model.stat <- matrix(0, ncol = 4, nrow = 1) %>% data.frame()
names(model.stat) <- c('RSE', 'Adjusted R-squared', 'F-Statistic', 'any-aliased')


# MODEL 1. Linear model
lm.regressors1 <- setdiff(names(mdata), c('claim_count', 'policy_desc'))
f1 <- as.formula(paste("claim_count ~ ", paste(lm.regressors1, collapse=" + ")))
fit1 <- lm(f1, data = mdata)
model.stat.fit1 <-  model.stat
model.stat.fit1$RSE <- summary(fit1)$sigma
model.stat.fit1$`Adjusted R-squared` <- summary(fit1)$adj.r.squared
model.stat.fit1$`F-Statistic` <- summary(fit1)$fstatistic[1]
model.stat.fit1$`any-aliased` <- any(summary(fit1)$aliased)



# MODEL 2. Poisson regression
lm.regressors2 <- setdiff(names(mdata), c('claim_count', 'policy_desc'))
f2 <- as.formula(paste("claim_count ~ ", paste(lm.regressors2, collapse=" + ")))

poisson.model <- glm(f2, mdata, family = poisson(link = "log"))
summary(poisson.model)

poisson.model2 <- glm(cf2, mdata, family = quasipoisson(link = "log"))
summary(poisson.model2)

# Comparing The Models
coef1=coef(poisson.model)
coef2=coef(poisson.model2)
se.coef1=se.coef(poisson.model)
se.coef2=se.coef(poisson.model2)
models.both<-cbind(coef1, se.coef1, coef2, se.coef2, exponent=exp(coef1))
models.both


# Predicting From The Model
#predict(poisson.model2, newdata = newdata, type = "response")

# Visualizing
plot_summs(poisson.model2, scale = TRUE, exp = TRUE)
plot_summs(poisson.model, poisson.model2, scale = TRUE, exp = TRUE)