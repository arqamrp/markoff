<img src = "assets/DALL_E_2023-06-08_08.52.29_-_A_logo_with_only_a_stylized_M__simplistic__techno-modern__with_a_reference_to_a_markov_chain_diagrams_with_linkages_between_each_node-removebg-preview.png", width = "100">


# markoff

An R package (markoffchains) and accompanying web app for computing properties of discrete time space Markov Chains

The RShiny app is available at [https://arqam.shinyapps.io/markoff](https://arqam.shinyapps.io/markoff).
The [markoffchains](/markoffchains) folder contains the package files and the pdf file [markoffchains_0.0.0.9000.pdf](markoffchains_0.0.0.9000.pdf) contains brief descriptions of the package functions.



### Package installation:
1. Install the package `devtools` in R with `install.packages("devtools")`.
2. Load the library using `library(devtools)`
3. Run the following command in your console
```
  devtools::install_github("arqamrp/markoff", subdir = "markoffchains")
```
4. Load the library using `library(markoffchains)` for use.


### Some functions available on the Shiny app


#### Communicating classes

![](/assets/comm_classes.png)

#### Reachable states

![](/assets/access.png)

#### Stationary matrix

![](/assets/stat.png)

#### Returning probabilities (lim(n->inf) p_jj n)

![](/assets/rtrn.png)
