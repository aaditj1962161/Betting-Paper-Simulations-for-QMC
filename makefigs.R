# Script to generate figures and tables for the Empirical Bernstein RQMC paper.

# To generate
#  - place  figs.R makefigs.R readem.R rqmcvar.R example.R in a folder/directory
#  - within that folder start an R session
#  - in that session say source("makefigs.R")

# The figures that were not used in the paper get removed at the end.
                                        # The reason for this oddness is that some internal computations for the deleted figures get reused in the included figures.  It was not clear that commenting out those computations would produce the same figures.

# The resulting plots are visually identical to those in the paper. The PDF files have the same numbers of lines, words and characters according to the wc command.  Diff says that they are different.

# The table output has the same numbers that appear in tables 1 and 2
# Those output numbers were hand edited into the latex source

cat("This takes about two minutes on an iMac from 2020.\n")
source("readem.R")
source("figs.R")
source("rqmcvar.R")
source("example.R")

setup()
widthvsothers()
comparewidthstoEB()

system("rm -f figwvsrqmcsize.pdf")
system("rm -f figwvspopsize.pdf")
system("rm -f figwvsdimension.pdf")
system("rm -f figwvsrqmcsizenodim.pdf")
system("rm -f figsmooth1d.pdf")
system("rm -f fignonsmooth1d.pdf")

# Now the tables
sink("Table1.txt")
print(xvsonethird())
sink()
sink("Table2.txt")
ans = trimbestnxexpxminusone()
print(ans)
sink()
sink("Table3.txt")
print(table3())
sink()















