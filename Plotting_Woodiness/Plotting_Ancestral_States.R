## Plots the results from an ancestral state reconstruction in a very large 350K tip tree
# Simon Uribe-Convers - November 14th, 2017, http://simonuribe.com

### Phylo ####

setwd("/Users/SAI/Documents/-Projects/--Woodiness/Plotting_Woodiness/")

library(geiger)
library(diversitree)
library(phytools)
library(picante)

tree <- read.nexus("ALLOTB_Nexus_binary_Names.tre")


#### Data ####

traits <- read.csv("Species_Phylo_with_Traits.csv", header = TRUE, row.names = 1)
name.check(tree, traits)


#### Ploting ####

# DiversiTree, might need to reimport the trait data if you sorted them
# http://www.zoology.ubc.ca/~fitzjohn/diversitree.docs/trait.plot.html

pdf("AllOTB_DiversiTree.pdf", width = 200, height = 200)

trait.plot(tree, traits, cols = list(Woodiness = c("red", "blue")), lab = "Woodiness", legend = TRUE, cex.legen = 50)

dev.off()


# Plotting binary state at the tips
# http://schmitzlab.info/visual1.html

pdf("AllOTB_Woody_Trait.pdf",  width = 200, height = 200)

# Same order for data and tips
compare <- treedata(phy = tree, data = traits, sort = TRUE, warnings = TRUE)
tree <- compare$phy
traits <- as.data.frame(compare$data)

par(mar=c(2,0,0,1))
mycol<-character(length(traits))
mycol[traits=="1"]<-"blue"
mycol[traits=="0"]<-"red"

plot(tree, show.tip.label=FALSE, type = "fan")
tiplabels(pch=21, col = mycol, bg=mycol, cex=20)

dev.off()


# Picante
# color.plot.phylo(tree, traits, trait = "Woodiness", taxa.names = "Species")



#### Simulate ####

# tree <- pbtree(n = 26, scale = 1)
# tree$tip.label <- LETTERS[26:1]
# char1<-as.data.frame(c(1,1,1,1,1,0,1,0,0,1,0,1,1,1,1,1,1,1,1,0,1,0,0,1,0,1), row.names = tree$)
# rownames(char1) <- tree$tip.label
# colnames(char1) <-  "Trait"
# 
# x <- fastBM(tree)
# mtree <- make.simmap(tree, x = x)
# write.tree(tree, file = "test.tre")
# write.table(x, file = "test.data.txt", sep = "\t")
