# Building Packages on a Windows Machine

## Why use `renv`?

We use the `renv` package to create a reproducible software environment for an R project. `renv` records the exact versions of all R packages used in the project, ensuring that analyses can be reproduced in the future, even if R and its packages have changed substantially.

Using `renv` also ensures that all collaborators work with exactly the same package versions, reducing the risk of scripts behaving differently on different computers.

The package versions used by a project are stored in the `renv.lock` file located in the root folder of the project.

For example, a collaborator can recreate the project's package environment using:

```r
renv::restore()
```

During this process, `renv` may need to install packages from source code and compile them locally. Therefore, your computer must have the necessary build tools installed.

## `renv` Requires Rtools on Windows

On Windows, many R packages contain C, C++, or Fortran code. To install these packages from source, R requires a separate software toolchain called **Rtools**.

Rtools provides the compilers, libraries, and build tools needed to compile R packages. It must be installed in addition to R itself and your preferred IDE (e.g. Positron or RStudio).

Install the version of Rtools that is compatible with your version of R. As a rule of thumb, use the most recent Rtools version recommended for your R release. For example:

| R version | Recommended Rtools version |
| --------- | -------------------------- |
| R 4.6.x   | Rtools 4.5                 |
| R 4.5.x   | Rtools 4.5                 |
| R 4.4.x   | Rtools 4.4                 |

Rtools can be downloaded from:

https://cran.r-project.org/bin/windows/Rtools/

After installation, you can verify that Rtools is available by running:

```r
pkgbuild::has_rtools(debug = TRUE)
```

## macOS

On macOS, Rtools is not used. Package compilation relies on Apple's Xcode Command Line Tools instead. See the accompanying document:

**Building packages on a MacOS machine.md**