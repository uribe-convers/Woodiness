# Plots the results from an ancestral state reconstruction in a very large 350K tip tree
# Simon Uribe-Convers - November 14th, 2017, http://simonuribe.com

setwd("/Users/SAI/Documents/-Projects/--Woodiness/Ancestral_State_Reconstruction")

library(geiger)
library(diversitree)
library(phytools)
library(picante)

tree <- read.nexus("ALLOTB_Ancestral_States_Nexus.tre")

co <- c("blue", "red")
p <- character(length(tree$node.label))
p[as.numeric(tree$node.label) == 1] <- co[1]
p[as.numeric(tree$node.label) == 0] <- co[2]

pdf("ALLOTB_Ancestral_States.pdf", width = 10, height = 10)

plot(tree, type = "fan", show.tip.label = TRUE)
nodelabels(cex=0.75, bg=p, pch=21, frame="n")
legend("topleft", c("Woody","Herbaceous"), col=co, cex = 1, bty = "n", fill = co)

dev.off()


pdf("ALLOTB_Ancestral_States_no_tiplabels.pdf", width = 10, height = 10)

plot(tree, type = "fan", show.tip.label = FALSE)
nodelabels(cex=0.75, bg=p, pch=21, frame="n")
legend("topleft", c("Woody","Herbaceous"), col=co, cex = 1, bty = "n", fill = co)

dev.off()


