##########################################################################################
########################## Species diversity #############################################
##########################################################################################

#Load packages
library(vegan)

#Load data
data(BCI)

############ Alfa diversity ################
#Species richness
S <- specnumber(BCI)
#Shannon index
H <- diversity(BCI,"shannon")
#This function returns 1-D (= Gini-Simpson Index)
D <- diversity(BCI, "simpson")
#This function returns 1/D (= Simpson's Reciprocal Index)
invD <- diversity(BCI, "inv")

#Evenness
#Shannon evenness
J <- H/(log(S))
#Simpson evenness
E <- invD/S

# Indices do not increase linearly with species richness!
# Indices are a bit outdated --> Effective number of species!
# Hill numbers
Hill <- tsallis(BCI,hill=TRUE,scales=c(0,1,2))

#This should equal (see lecture formulas)
sum(Hill[, 1]) == sum(S)
sum(Hill[, 2]) == sum(exp(H))

#Simpson diversity gives FALSE when it should be TRUE?
sum(Hill[, 3]) == sum(invD) 
sum(Hill[, 3])
sum(invD)

#Plot relationships
plot(S, H)
plot(S, Hill[,2])

############ Beta diversity ################
#Pairwise beta diversity
#It is very important to first check which formula you will use
betadiver(help = TRUE)

#Depending on the formula, you will get a (dis)similarity matrix!
#Notice that there is also a "sor" option (= different from the one in lectures)
#Different from the one in the lecture
sorensen <- betadiver(BCI, "w")

#Transform into a data frame to get a nice overview between plots
dissimilarity <- scores(sorensen)

#On the diagonal, we find zero (because the dissimilarity of a plot with itself is 0)
#The off-diagonal data shows the sorensen dissimilarity between each pair of plots (between 0 and 1)
#Watch out when you use a similiarity matrix!
#The scores() function only mirrors the matrix and fills the diagonal automaticcaly with 0 values.
#This is, of course, wrong. These should be transformed to 1

#Beta diversity can be partitioned in nestedness & turnover
#Both components can be calculated with the betapart-package
library(betapart)

#Partitioning only works for presence/absence data
#Transform all values larger than 0 to 1
PA <- BCI
PA[PA > 0] <- 1

#First matrix is turnover (SIM), second is nestedness (SNE) and third is sum (SOR)
#Third matrix (the sum) should equal the previous calculation of sorensen beta diversity
beta.pair(PA, index.family = "sorensen")


#Multiple site beta diversity (= one value for all sites)
#This corresponds to the differences between all sites
#Again, this is immediately partitioned in the two part (Turnover & Nestedness)
beta.multi(PA, index.family="sorensen")

############ Gamma diversity ################
#Calculate plot-based gamma diversity with chao estimators
BCI_gamma <- specpool(BCI)

#Extract the mean and standard error
chao_BCI <- BCI_gamma$chao
chao_BCI_se <- BCI_gamma$chao.se

#Take 100 random samples from a normal distribution!
sample_BCI <- rnorm(100, mean = chao_BCI_mean, sd = chao_BCI_se)
sample <- rnorm(100, mean = 280, sd = 11.5)

t.test(sample_BCI, sample)
#p-value < 0.05 --> reject the zero-hypothesis --> significant difference!

##########################################################################################
####################### Fucntional diversity #############################################
##########################################################################################
library(FD)

#We will make use of the Tussock dataset (= part of the package FD)
#First we need to split abundance data from trait data
traits <- tussock$trait
abundance <- tussock$abun

#Now we need to clean the trait data
#We will only use continuous traits and not seedmass because we are interested in the plant itself
#We also need to remove species on which we have no trait data
traits <- traits[, c(2:7, 11)] 
traits <- na.omit(traits)

#Abundance data: rows = plots & columns = species
#Only select the species that do have traits!
#We omitted two, so here those two should also be deleted
abundance <- abundance[, rownames(traits)] 

#Calculate species richness
#Transform abundance to a data frame
spec_richness <- rowSums(abundance != 0)
abundance <- as.data.frame(abundance)

# Calculate all FD indices
FD <- dbFD(traits, abundance)

# Plot FD vs species diversity
plot(spec_richness, FD$FRic)

