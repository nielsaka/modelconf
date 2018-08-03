# Model Confidence Sets

The R package `modelconf` lets you estimate model confidence sets (MCS).
These sets account for the uncertainty surrounding model choice.

## About

This repository offers an implementation written in R of the algorithms
described by [Hansen, Lunde and Nason (2011)](https://doi.org/10.3982/ECTA5771)
in their Econometrica paper. There, they develop procedures for estimating model
confidence sets that are expected to contain all best model(s) with a given
probability. Interpretation of the confidence set is therefore analogous to
confidence intervals for population parameters. The notion of a confidence set
is particularly useful in situations where competing model specifications are
available and it is uncertain which model will be appropriate in a certain
context.

The algorithms come in two flavours, an in-sample and an out-of-sample version.
Both of these are implemented here.

There is another implementation of these algorithms available on CRAN via the
[MCS](https://cran.r-project.org/web/packages/MCS/index.html) package. Maybe
some of the code from here can be merged to over there or results from the two
packages could be compared for correctness and efficiency.

## Installation 

Straight from github via `devtools::install_github("nielsaka/modelconf.git")`.

Locally, the package can be installed using the command line and 
`R CMD INSTALL /path/to/modelconf`. If the package has been installed before, it
might be necessary to enable the pre-clean option. With devtools, use
`options(devtools.install.args = "--preclean")` to remove previously built
binary files or `R CMD INSTALL --preclean /path/to/modelconf` on the command
line.

## License

This project is licensed under the MIT License. See the LICENSE file for
details.
