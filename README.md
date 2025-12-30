## Simulations for the paper "Empirical Bernstein and betting confidence intervals for randomized quasi-Monte Carlo"

To run the simulations, we recommend the following steps

First, to set up the environment, run the following commands 

```bash
mkdir betsim 
cd betsim/
conda create --name betci python=3.8.19
conda activate betci
git clone git@github.com:aaditj1962161/Betting-Paper-Simulations-for-QMC.git 
pip install numpy=1.24.4 scipy=1.10.1 qmcpy=1.6.2 jupyter
git clone git@github.com:gostevehoward/confseq.git
pip install -e ./confseq/
```

Then, ensuring you are in the `betci` conda environment, run the Jupyter notebook simulations in `Betting IID vs QMC.ipynb` to generate `qmc_combined_results.csv`. 

Then, run the R script to generate outputs from the CSV file using 

```bash 
Rscript makefigs.R
```
This should output `Table1.txt`, `Table2.txt`, and `Table3.txt` as well as `figmeanwidths.pdf` and `figwidthstoeb.pdf`. 
