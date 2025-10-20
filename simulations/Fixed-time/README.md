## Running Simulations 

To run `Betting IID vs QMC.ipynb` we recommend the following steps

```bash
mkdir betsim 
cd betsim/
conda env create --name betci python=3.12
conda activate betci
git clone git@github.com:aaditj1962161/Betting-Paper-Simulations-for-QMC.git 
pip install "numpy<2" scipy qmcpy matplotlib seaborn jupyterlab
git clone git@github.com:gostevehoward/confseq.git
pip install -e ./confseq/
cd Betting-Paper-Simulations-for-QMC/simulations/Fixed-time/
jupyter-lab 
```
