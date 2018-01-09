# Woodiness

### Simon Uribe-Convers - November 7th, 2017 - http://simonuribe.com
---

#### Mapping and reconstructing which species of angiosperms are woody using data from [GlobalTreeSearch](http://www.bgci.org/global_tree_search.php).

Remove periods from `sp.`, `aff.`, and single quotes from species name on the tree. **Be careful** to not delete the period from the decimal point in the branch lengths.

```
# Do this on the tree before running the python script 

sed 's/\([A-z]\)\./\1/g' ALLOTB_binary.tre > ALLOTB_binary_Names.tre
sed -i '' 's/\([A-z]\)\./\1/g' ALLOTB_binary_Names.tre
sed -i "" "s/\'//g" ALLOTB_binary_Names.tre

```
**Create the trait data that matches the tree**  
Run `Intersect_data_tree.py` to get a file with the species on the tree that have trait data.

**Ancestral State Reconstruction**  
Run the first part of `Plotting_Ancestral_States.R` to check that species match on both the tree and data.

Use `pxstrec` to map the trait. The data file has to have a header with the number of species and number of traits, a la phylip. The tree **can't** have polytomies! 

```
353185 1
Humiriastrum_subcrenatum	1
Humiriastrum_dentatum	1
Humiriastrum_glaziovii	1
...
```
**BEFORE** you run the state reconstruction analysis, double check that the trait file has unix line breaks.

Run it: 
`pxstrec -t ALLOTB_binary_Names.tre -d Species_Phylo_with_Traits.txt -c control_file.txt -o ALLOTB_Ancestral_States.tre > info.txt`

**Plotting the results**  
Run the rest of `Plotting_Ancestral_States.R` to plot the results. _Beware_ of the size of the pdf files that are created! Opening them on Adobe Acrobat seemed to work better than Apple's Preview. 