Rtools is a Windows-only toolchain.
On macOS there is no Rtools. Instead, R uses Apple's developer tools:

Install Xcode Command Line Tools:

xcode-select --install
This provides:
clang (C/C++ compiler)
make

headers and libraries needed to compile R packages
Check that they are installed:
clang --versionmake --version

From within R:
system("clang --version")Sys.which("make")
For most packages, that's all you need.
If a package requires additional external libraries (e.g. sf, terra, xml2, curl, openssl), these are often installed via Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
Then for example:
brew install gdalbrew install geosbrew install proj
The equivalent mapping is roughly:
WindowsmacOSRtools43Xcode Command Line ToolsRtools44Xcode Command Line ToolsRtools45Xcode Command Line Toolsgcc/mingwclang/LLVM
So if renv::restore() fails on Windows, checking Rtools is important. On macOS, the corresponding check is whether the Xcode Command Line Tools are installed and whether clang is available.
