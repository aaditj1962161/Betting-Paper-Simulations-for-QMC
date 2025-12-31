## Simulations for the paper "Empirical Bernstein and betting confidence intervals for randomized quasi-Monte Carlo"

To run the simulations, we recommend the following steps

First, to set up the environment, run the following commands 

```bash
mkdir betsim 
cd betsim/
git clone git@github.com:aaditj1962161/Betting-Paper-Simulations-for-QMC.git 
cd Betting-Paper-Simulations-for-QMC/
conda create --name betci python=3.12.12 -y
conda activate betci
pip install numpy==1.26.4 scipy==1.16.3 qmcpy==2.1 jupyter
wget https://github.com/gostevehoward/confseq/archive/refs/tags/v0.0.11.zip
unzip ./v0.0.11.zip
pip install -e ./confseq-0.0.11
```

Then, ensuring you are in the `betci` conda environment, run the Jupyter notebook simulations in `Betting IID vs QMC.ipynb` to generate `qmc_combined_results.csv`.

Then, run the R script to generate outputs from the CSV file using 

```bash 
Rscript makefigs.R
```

This should output `Table1.txt`, `Table2.txt`, and `Table3.txt` as well as `figmeanwidths.pdf` and `figwidthstoeb.pdf`.