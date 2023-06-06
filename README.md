# markoff

A project for computing properties of discrete time space Markov Chains

The RShiny app is available at [https://arqam.shinyapps.io/markoff](https://arqam.shinyapps.io/markoff).
The markoffchains folder contains the package files.



### Package installation:
1. Install the package `devtools` in R with `install.packages("devtools")`.
2. Load the library using `library(devtools)`
3. Run the following command in your console
```
  devtools::install_github("arqamrp/markoff", subdir = "markoffchains")
```



### Some functions available on the Shiny app


#### Communicating classes

![](/assets/comm_classes.png)

#### Reachable states

![](/assets/access.png)

#### Stationary matrix

![](/assets/stat.png)

#### Returning probabilities (lim(n->inf) p_jj n)

![](/assets/rtrn.png)
