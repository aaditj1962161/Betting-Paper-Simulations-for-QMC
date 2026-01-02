## Simulations for the paper "Empirical Bernstein and betting confidence intervals for randomized quasi-Monte Carlo"

To run the simulations, we recommend the following steps

First, to set up the environment, run the following commands 

```bash
mkdir betsim 
cd betsim/
git clone git@github.com:aaditj1962161/Betting-Paper-Simulations-for-QMC.git 
cd Betting-Paper-Simulations-for-QMC/
conda create --name betci python=3.8.20 -y
conda activate betci
conda install -c conda-forge boost -y
pip install numpy==1.24.4 scipy==1.10.1 qmcpy==1.6.2 qmctoolscl==1.1.3 jupyter
pip install git+https://github.com/WannabeSmith/confseq.git@35aea3d729fdb24edd39db75e2603596f8ea62a4
```

Then, ensuring you are in the `betci` conda environment, run the Jupyter notebook simulations in `Betting IID vs QMC.ipynb` to generate `qmc_combined_results.csv`.

Then, run the R script to generate outputs from the CSV file using 

```bash 
Rscript makefigs.R
```
This should output `Table1.txt`, `Table2.txt`, and `Table3.txt` as well as `figmeanwidths.pdf` and `figwidthstoeb.pdf`.