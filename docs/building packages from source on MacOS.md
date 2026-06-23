# Building packages from source on macOS

The use of the renv library in R, as renv::restore() requires that your computer can build packages into a binary version from their online source code in a repository.  

On Windows, R packages that contain C, C++, or Fortran code require a separate toolchain called Rtools. Rtools bundles compilers, build tools, libraries, and utilities needed to compile packages from source.

On macOS, these tools are provided by Apple through the Xcode Command Line Tools, optionally supplemented by Homebrew-installed libraries.

## Comparison

| Windows | macOS |
|----------|--------|
| Rtools | Xcode Command Line Tools |
| gcc (MinGW-w64) | clang/LLVM |
| make | make |
| bundled Unix tools | native Unix tools |
| additional libraries often bundled | often installed via Homebrew |

## How package installation works on macOS

When you run for example:

```r
install.packages("ggplot2")
```

R first looks for a precompiled binary package.

If a binary is available, it is downloaded and installed directly.

If only source code is available, R compiles the package locally using:

- clang (C/C++ compiler)
- make
- system libraries
- optional external libraries such as GDAL, PROJ, GEOS, OpenSSL, or libxml2

These tools come from the Xcode Command Line Tools and sometimes Homebrew.

## Installing the required toolchain

Install Apple's command line tools:

```bash
xcode-select --install
```

This installs:

- clang
- clang++
- make
- git
- SDK headers and libraries

## Checking the installation

From a terminal:

```bash
clang --version
make --version
```

From R:

```r
system("clang --version")
Sys.which("make")
```

## The role of Homebrew

Some R packages depend on external libraries that Apple does not provide.

Examples:

- sf
- terra
- rgdal (legacy)
- openssl
- xml2

These libraries are commonly installed using Homebrew:

```bash
brew install gdal
brew install geos
brew install proj
```

## Why Windows needs Rtools but macOS usually does not

Windows does not include a Unix-style development environment. Rtools provides one.

macOS is based on Unix and already supports native development tools through Apple's compiler infrastructure. Therefore, no separate R-specific toolchain is required.

## Troubleshooting

If package compilation fails on macOS:

1. Verify that Xcode Command Line Tools are installed.
2. Check that clang is available.
3. Check that Homebrew libraries required by the package are installed.
4. Inspect the package compilation log for missing headers or libraries.
5. Verify that your version of R supports your macOS version.

## Useful commands

```r
sessionInfo()

system("clang --version")

Sys.which("make")

capabilities()
```

These commands provide most of the information needed to diagnose source-package installation problems on macOS.
