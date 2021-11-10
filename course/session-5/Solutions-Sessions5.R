setwd("C:/Users/u0133385/Box Sync/Doctoraat/4. Courses/1. EDCP/Sessions/Session 5/")

########## Question 1 ##########
plant_growth <- read.csv("./data/plantgrowth.csv", header = TRUE, sep = ";")
colnames(plant_growth) <- c("Yield", "Treatment")
str(plant_growth)
plant_growth$Treatment <- as.factor(plant_growth$Treatment)

# Difference in a quantitative variable between two groups
# Sample size = 20
# Too small for a parametric test --> non-parametric test preferred!
# Independent samples? --> check!
# Independent two-group Mann-Whitney test
wilcox.test(Yield ~ Treatment, data = plant_growth)
# p-value > 0.05 --> unable to reject the zero-hypothesis at 5% significance level

# Let's consider sample size being large enough...

# We can check if normality holds
par(mfrow = c(1,2))
hist(plant_growth$Yield, prob=TRUE, xlab="Yield", main="Histogram of Yield")
m<-mean(plant_growth$Yield)
std<-sqrt(var(plant_growth$Yield))
curve(dnorm(x, mean=m, sd=std),col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(plant_growth$Yield, main="Normal Q-Q of Yield")
qqline(plant_growth$Yield, col = "red", lwd = 2)
# Normality seems to hold

# Statistical test for normality (Shapiro-Wilk)
# Not recommended, because it is too strict
shapiro.test(plant_growth$Yield)
# p > 0.05 --> unable to reject the zero-hypothesis at 5% significance level (normally distributed)

# We can check if homoscedasticity holds
# Strong evidence for normal distribution --> Bartlett's test has better performance
bartlett.test(Yield ~ Treatment, data = plant_growth)
#  p > 0.05 --> unable to reject the zero-hypothesis at 5% significance level (homoscedasticity)

# We can use the unpaired t.test (independent samples)
t.test(Yield ~ Treatment, data = plant_growth, paired = FALSE)
# p-value < 0.05 --> reject the zero-hypothesis --> significant difference!

########## Question 2 ##########
iris <- read.csv("./data/iris.csv", header = TRUE, sep = ",")
iris <- iris[, c(2,6)]
colnames(iris) <- c("sepal_length", "Species")
str(iris)
iris$Species <- as.factor(iris$Species)

# Difference in a quantitative variable between 3 samples
# Sample size = 30 
# 10 observations per sample --> non-parametric test preferred!
# Independent samples? --> check!
# Kruskall-Wallis test + posthoc

# Use the kruskal-Wallis test
kruskal.test(sepal_length ~ Species, data = iris)
# p-value < 0.05 --> reject the zero-hypothesis --> significant difference!

# Post-hoc testing to check between samples
# Benjamini-Hochberg adjustment, no Bonferonni (too strict)
library(FSA)
dunnTest(sepal_length ~ Species, data = iris, method= "bh")
# There is a significant difference in sepal length between setosa & virginica and between setosa & versicolor
# There is no significant difference in sepal length between versicolor & virginica

# Let's consider sample size being large enough...

# We can check if normality holds
par(mfrow = c(1,2))
hist(iris$sepal_length , prob=TRUE, xlab="Sepal lenghth",main="Histogram of sepal length")
m<-mean(iris$sepal_length)
std<-sqrt(var(iris$sepal_length))
curve(dnorm(x, mean=m, sd=std),col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(iris$sepal_length, main="Normal Q-Q of sepal length")
qqline(iris$sepal_length, col = "red", lwd = 2)

# See if data transformation can solve the problem
iris$log_sl <- log(iris$sepal_length)
iris$sqrt_sl <- sqrt(iris$sepal_length)

# We can check if normality is better now
par(mfrow = c(1,2))
hist(iris$log_sl , prob=TRUE, xlab="Log(Sepal lenghth)",main="Logaritmic transformation")
m<-mean(iris$log_sl)
std<-sqrt(var(iris$log_sl))
curve(dnorm(x, mean=m, sd=std),col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(iris$log_sl, main="Logaritmic transformation")
qqline(iris$log_sl, col = "red", lwd = 2)

par(mfrow = c(1,2))
hist(iris$sqrt_sl , prob=TRUE, xlab="sqrt(Sepal lenghth)",main="Square Root Transformation")
m<-mean(iris$sqrt_sl)
std<-sqrt(var(iris$sqrt_sl))
curve(dnorm(x, mean=m, sd=std),col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(iris$sqrt_sl, main="Square Root Transformation")
qqline(iris$sqrt_sl, col = "red", lwd = 2)

# Statistical test for normality (Shapiro-Wilk)
# Not recommended, because it is too strict
shapiro.test(iris$sepal_length)
shapiro.test(iris$log_sl)
shapiro.test(iris$sqrt_sl)

# We can check if homoscedasticity holds
# No strong evidence for normal distribution --> Levene's test has better performance
library(car)
leveneTest(sepal_length ~ Species, data = iris)
# p > 0.05 --> unable to reject the zero-hypthesis at 5% significance level (homoscedasticity)

# Let's consider all assumptions are holding...
# Compute the ANOVA
res.aov <- aov(sepal_length ~ Species, data = iris)
summary(res.aov)
# p < 0.001 --> reject the zero-hypothesis at 0.1% significance level

# Post-hoc testing to check between samples
# Tuckey post-hoc test
TukeyHSD(res.aov)
# There is a significant difference in sepal length between setosa & virginica and between setosa & versicolor
# There is no significant difference in sepal length between versicolor & virginica

########## Question 3 ##########
meerdaal <- read.csv("./data/meerdaal.csv", header = TRUE, sep = ";")
colnames(meerdaal) <- c("Plot", "Old", "Recent")

# Difference in a quantitative variable between 2 paired samples
# Sample size = 13 
# Too small for a parametric test --> non-parametric test
# Assumption: independent samples --> false, it is resampling of the same plots!
# Wilcoxon signed rank test

# Use paired wilcoxon test
wilcox.test(meerdaal$Old, meerdaal$Recent, paired = TRUE)
# p-value < 0.05 --> reject the zero-hypothesis --> significant difference!


########## Question 4 ##########
# We are comparing gamma diversity!
# Chao estimators of two groups with t-test
kembel_sp <- read.csv("./data/kembel_sp.csv", header = TRUE, sep = ",")

mixed <- kembel_sp[-c(8:17), 2:77 ]
fes <- kembel_sp[c(8:17), 2:77]

library(vegan)
# Calculate chao estimators
mixed_gamma <- specpool(mixed)
fes_gamma <- specpool(fes)

chao_mixed <- mixed_gamma$chao
chao_mixed_se <- mixed_gamma$chao.se
chao_fes <- fes_gamma$chao
chao_fes_se <- fes_gamma$chao.se

# Take 100 random samples from a normal distribution!
sample_mixed <- rnorm(100, mean = chao_mixed, sd = chao_mixed_se)
sample_fes <- rnorm(100, mean = chao_fes, sd = chao_fes_se)

# Perform a t-test
t.test(sample_mixed, sample_fes, paired = FALSE)
#p-value < 0.05 --> reject the zero-hypothesis --> significant difference!
#There is a higher species richness in fec grasslands

