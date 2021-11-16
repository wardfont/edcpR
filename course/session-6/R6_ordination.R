
sp<-read.csv(file = "./data/varespec.csv",header=TRUE,row.names=1,sep=",")
env<-read.csv(file = "./data/varechem.csv",header=TRUE,row.names=1,sep=";")

str(sp)
str(env)

env$Managementtype<-as.factor(env$Managementtype)

##### PCA ############################################

# The goal here is to 
library(vegan)

# Environmental conditions --> PCA is good for this type of data

# rda without conditions or constraints is PCA
# We have nutrient contents (g/kg), soil depth (cm), pH (1-14)...
# scale = TRUE for data on different scales!!
PCA <- rda(env[,1:10], scale=TRUE) 

# Bar plot of relative eigen values (= percentage variance explained by each axis)
eig <- as.vector(PCA$CA$eig)
barplot(eig/sum(eig), xlab = "Principal Component", 
        ylab = "Explained variance", ylim = c(0, 0.5))


# Calculate the percent of variance explained by first two or three axes
# Between 0.7 and 0.8 is preferred
# First two axes explain 63% of the variance
# First three axes explain 73% of the variance, this is ok!
sum((eig/sum(eig))[1:2])
sum((eig/sum(eig))[1:3])

# Three dimensional representation is possible, but more difficult
# We prefer to plot in two dimensions
# Solution: plot PC1 Vs. PC2 & PC1 vs. PC3

# ?vegan::biplot.rda for help on the next plots
biplot(PCA, choices=c(1,2), type=c("text","points")) # biplot of axis 1 vs 2 
biplot(PCA, choices=c(1,3), type=c("text","points")) # biplot of axis 1 vs 3


# Species composition --> PCA is not recommended since species rarely linearly relate to each other

#The exact same analysis could be done, the only difference being no scaling is necessary
PCA <- rda(sp, scale=FALSE) # scale = FALSE since no scaling is necessatry
# ...

##### PCoA ############################################
# It is very important that the correct method is used to calculate the distances ((dis)similarity matrix)

library(ape)
library(FD)

# Environmental conditions --> here we can also use the ordinal columns

# First step: create a distance matrix
# We have quantitative and categorical environmental variables
# We thus use Gower distance for mixed variables
dist <- gowdis(env)

# Perform PCoA & plot the eigenvalues
PCoA <- pcoa(dist)
barplot(PCoA$values$Relative_eig, xlab = "Principal Component", 
        ylab = "Explained variance", ylim = c(0, 0.45)) 

# Some distance measures may result in negative eigenvalues --> add a correction
PCoA <- pcoa(dist, correction = "cailliez")
barplot(PCoA$values$Rel_corr_eig, xlab = "Principal Component", 
        ylab = "Explained variance", ylim = c(0, 0.3))

# There are no variables plotted on this biplot (input = dissimilarity matrix) 
biplot.pcoa(PCoA)

# However, we could work around this problem
biplot.pcoa(PCoA, env[1:10])

# Species composition --> again not recommended 

# calculate distance matrix
dist <- vegdist(sp,  method = "bray")
#Perform pcoa and check results
PCOA<-pcoa(dist)

################################################
#NMDS
#Different classes of variables are allowed (nominal, ordinal, binair, numerical)
#Nominal or ordinal variables don't have to be converted to numerical variables
#NMDS is a non-parametric analysis, it does not assume any distribution
#NMDS does not assume linear relationships
#NMDS is a distance based analysis, any distance measure can be used.
#The solution is not found by eigenanalysis. Final axes are not ordered and don't have eigenvalues
#You must specify a number of ordination axis at the beginning of your analysis

#Methodology of NMDS
#Step 1: Perform NMDS with 1 to 4 dimensions (k = number of dimensions)
#Step 2: Check results for convergent solution and stress
#stress < 0.05: excellent representation in reduced dimensions
#< 0.1 is good, < 0.2 fair, and stress < 0.3 is poor
#Step 3: Choose optimal number of dimensions
#Step 4: Perform final NMDS with that number of dimensions

# Function metaMDS does a lot of the work for you:
# - performs a PCA on the NMDS result so that the variance of points is maximized on first dimension

# Determine the number of dimensions for the final NMDS
# Run NMDS for 1 up to 10 dimensions
# Bray-Curtis distance matrix for species matrix with cover data
# If you don`t provide a dissimilarity matrix, metaMDS automatically applies Bray-Curtis
A<-vector() 
B<-vector() 

for (i in 1:10) {
  NDMS <- metaMDS(sp, distance = "bray", k=i, autotransform = FALSE, trymax=100)
  solution <- NDMS$converged
  stress <- NDMS$stress
  A1 <- cbind(solution,stress)
  B <- rbind(B,i)
  A <- rbind(A,A1)
}
#Combine results of all NMDS
NMDSoutput<-data.frame(B,A)
names(NMDSoutput) <- c("k","Solution?","Stress")
NMDSoutput

plot(NMDSoutput$Stress, xlab = "# of Dimensions", ylab = "Stress", main = "NMDS stress plot")
plot(NMDSoutput$`Solution?`, xlab = "# of Dimensions", ylab = "Solution", main = "NMDS convergence plot")

# Final result depends on the initial random placement of the points 
# We need set a seed to make the results reproducible
set.seed(999)

NMDSfinal <- metaMDS(sp, distance = "bray", k=2, autotransform = FALSE, trymax=100 )

# We can again check the stress
NMDSfinal$stress

# Let's check the results of NMDSfinal with a stressplot
stressplot(NMDSfinal)

#Plot results
plot(NMDSfinal,type="t") #text
plot(NMDSfinal, type="p") #points


# Now we can try to answer the question: 
# Which environmental variable is driving the observed differences in species composition?

# We do this by correlating the environmental variables with the ordination axes

# There are no environmental variables on the plot (same as PCoA)
# We can again work around this
ef <- envfit(NMDSfinal, env[1:10], permu = 999)
ef

# Plot the vectors of the significant correlations
plot(NMDSfinal, type = "t", display = "sites")
plot(ef, p.max = 0.05)

