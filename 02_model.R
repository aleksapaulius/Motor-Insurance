
model.stat <- matrix(0, ncol = 4, nrow = 1) %>% data.frame()
names(model.stat) <- c('RSE', 'Adjusted R-squared', 'F-Statistic', 'any-aliased')


### Linear model

# MODEL 1
lm.regressors1 <- setdiff(names(mdata), c('claim_count'))
f1 <- as.formula(paste("claim_count ~ ", paste(lm.regressors1, collapse=" + ")))
fit1 <- lm(f1, data = mdata)
summary(fit1)
model.stat.fit1 <-  model.stat
model.stat.fit1$RSE <- summary(fit1)$sigma
model.stat.fit1$`Adjusted R-squared` <- summary(fit1)$adj.r.squared
model.stat.fit1$`F-Statistic` <- summary(fit1)$fstatistic[1]
model.stat.fit1$`any-aliased` <- any(summary(fit1)$aliased)

# MODEL 2
lm.regressors2 <- setdiff(names(mdata), c('claim_count', 'population_density', 'vehicle_hp'))
f2 <- as.formula(paste("claim_count ~ ", paste(lm.regressors2, collapse=" + ")))
fit2 <- lm(f2, data = mdata)
summary(fit2) # higher F-Statistic shows stronger relashionship between exogenic and endogenic variables
model.stat.fit2 <-  model.stat
model.stat.fit2$RSE <- summary(fit2)$sigma
model.stat.fit2$`Adjusted R-squared` <- summary(fit2)$adj.r.squared
model.stat.fit2$`F-Statistic` <- summary(fit2)$fstatistic[1]
model.stat.fit2$`any-aliased` <- any(summary(fit2)$aliased)


### Poisson regression

# MODEL 3
pr.regressors3 <- setdiff(names(mdata), c('claim_count'))
f3 <- as.formula(paste("claim_count ~ ", paste(pr.regressors3, collapse=" + ")))
fit3 <- glm(f3, mdata, family = poisson(link = "log"))
summary(fit3)

# MODEL 3
f4 <- f3
fit4 <- glm(f4, mdata, family = quasipoisson(link = "log"))
summary(fit4)

# Comparing The Models
coef1 = coef(fit3)
coef2 = coef(fit4)
se.coef1 = se.coef(fit3)
se.coef2 = se.coef(fit4)
models.both <- cbind(coef1, se.coef1, coef2, se.coef2, exponent=exp(coef1))
models.both


# Predicting From The Model
#modeling.data <- mdata[,setdiff(names(mdata), c('claim_count'))]
#predict(fit3, newdata = modeling.data, type = "response")
#table(round(predict(fit3, newdata = modeling.data, type = "response"), 0))



# Visualizing
#plot_summs(fit4, scale = TRUE, exp = TRUE)
#plot_summs(fit3, fit4, scale = TRUE, exp = TRUE)



