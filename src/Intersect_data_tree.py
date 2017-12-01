"""
Returns two files (comma and tab separated) that show the intersection of the 
tips in the large angiosperm tree and the data available in the GlobalTreeSearch 
(http://www.bgci.org/global_tree_search.php) database for woody species. 

Simon Uribe-Convers - Nov 06, 2017 - http://simonuribe.com

"""

import sys
from Bio import Phylo
import tree_reader
import re
import os

# Read data from GlobalTreeSearch
x = open("global_tree_search_trees.csv", "r", encoding="ISO-8859-1")
x.seek(0)
woody_species = []
for line in x:
    species = line.strip().split(",")[0]
    species = species.replace(" ", "_")
    # print(species)
    woody_species.append(species)

print("Species with trait data: %d" %len(woody_species))

# Get tip names from tree

# Big tree
y = open("ALLOTB_binary_Names.tre", "r")
# Genbank data tree
# y = open("GBOTB.tre", "r")
y.seek(0)

# With Stephen's Tree_Reader
tree = tree_reader.read_tree_string(y.readline().strip())
tips = tree.lvsnms()
print("Tips in the tree: %d" %len(tips))

# With BioPython
# tree2 = Phylo.read("GBOTB.tre", "newick")
# tree2.count_terminals()
# tips2 = tree2.get_terminals()
# len(tips2)

# Find Intersect
species_intersect = list(set(woody_species) & set(tips))
percent_tips_with_traits = (len(species_intersect) * 100) / len(tips)
print("Species in the tree with trait data: %d (%.2f%%)" %(len(species_intersect), percent_tips_with_traits))


# Get matrix with binary state for species with trait data

# Using a dictionary, FAST (~12 seconds)!
data_dic = {}
for k in woody_species:
    data_dic[k] = ""

data = []
data.append("Species,Woodiness")
for i in tips:
    try:
        data_dic[i]
        data.append(i + ",1")
    except:
        data.append(i + ",0")

data2 = []
data2.append("%d 1" % len(tips))
for i in tips:
    try:
        data_dic[i]
        data2.append(i + "\t1")
    except:
        data2.append(i + "\t0")

# Using sets, MEDIUM (~6 minutes)
# data_set = set({})
# for i in tips:
#     if i in woody_species:
#         data_set.add(i + "\t1")
#     else:
#         data_set.add(i + "\t0")
# 
# Using a list, SLOW (~27 minutes!)
# data_list = []
# for i in tips:
#     if i in woody_species:
#         data_list.append(i + "\t1")
#     else:
#         data_list.append(i + "\t0")

len(data)

data = "\n".join(data)
data2 = "\n".join(data2)

# Cleaning
# If the species name have periods or quotes in them, remove them from the tree and traits
# if "." in data or "'" in data:
#     # data = re.sub(r"(\w)\.", "\1", data)
#     data = data.replace("'", "")
# 

# If the species name have periods or quotes in them, remove them from the tree and traits
# if "." in data2 or "'" in data2:
    # data2 = data2.re("\w\.", "")
    # data2 = data2.replace("'", "")



s = open("Species_Phylo_with_Traits.csv", "w")
s.write(data)
s.close() 

s = open("Species_Phylo_with_Traits.txt", "w")
s.write(data2)
s.close()
