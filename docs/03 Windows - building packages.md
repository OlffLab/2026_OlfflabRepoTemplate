# Building packages on a Windows machine

## Why use renv?
We use the renv library to "freeze" the versions of the packages used in a project. This ensures that for example 5 years from know you can still run the scripts of your project, even through R has changed substantially. And it ensures that collaborators work exactly with the same software environment while collaborating on scripts. 
Which packages in which version a project is using, is stored in the file renv.lock in the root folder of your R project. 

This use of the renv library in R, as for example when restoring your R environment from the .lock file 
```r
renv::restore()
```
requires that your computer can build packages into a binary version from their online source code in a repository.  

## renv requires RTools
On Windows, R packages that contain C, C++, or Fortran code require a separate toolchain called Rtools. Rtools bundles compilers, build tools, libraries, and utilities needed to compile packages from source. This is a separate program that you installin addition to installing R and your IDE as Positron. 
Install the version of RTools that fits with your R installation. 
for R 4.6 you need RTools 4.5 (the latest version)  

Install it using the installer from this location https://cran.r-project.org/bin/windows/Rtools/  
On macOS this works differently, see the next .md file