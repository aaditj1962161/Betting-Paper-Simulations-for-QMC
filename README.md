## Simulations for the paper "Empirical Bernstein and betting confidence intervals for randomized quasi-Monte Carlo"

To run the simulations, we recommend the following steps

First, to set up the environment, run the following commands 

```bash
mkdir betsim 
cd betsim/
conda env create --name betci python=3.12
conda activate betci
git clone git@github.com:aaditj1962161/Betting-Paper-Simulations-for-QMC.git 
pip install "numpy<2" scipy qmcpy matplotlib seaborn jupyterlab
git clone git@github.com:gostevehoward/confseq.git
pip install -e ./confseq/
cd Betting-Paper-Simulations-for-QMC/
```

Then, to run simulations and generate `qmc_combined_results.csv` run the Jupyter notebook `Betting IID vs QMC.ipynb`.

Then, in an R session, source `makefigs.R`. This should output `Table1.txt`, `Table2.txt`, and `Table3.txt` as well as `figmeanwidths.pdf` and `figwidthstoeb.pdf`. 



