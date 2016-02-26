# PiCbench

[![release v0.1.0](http://img.shields.io/badge/release-v0.1.0-yellow.svg)](https://github.com/dih5/PiCbench/releases/latest)
[![Semantic Versioning](https://img.shields.io/badge/SemVer-2.0.0-brightgreen.svg)](http://semver.org/spec/v2.0.0.html)
[![license GNU GPLv3](https://img.shields.io/badge/license-GNU%20GPLv3License-brightgreen.svg)](https://github.com/dih5/PiCbench/blob/master/LICENSE.txt)
[![Mathematica 9.0 10.0](https://img.shields.io/badge/Mathematica-9.0_10.0-brightgreen.svg)](#compatibility)


Tools for making Particle in Cell simulations in Mathematica.
The package features C code compilation to produce fast simulations.

* [Features](#features)
* [Usage example](#usage-example)
* [Installation](#installation)
    * [Automatic installation](#automatic-installation)
    * [Manual installation](#manual-installation)
    * [No installation](#no-installation)
* [Documentation](#documentation)
* [Compatibility](#compatibility)
* [License](#license)
* [Versioning](#versioning)

## Features
1D1V plasma simulation with periodic boundaries with no magnetic fields are only implemented at the moment.

## Usage example

Check [the example notebook](https://raw.githubusercontent.com/Dih5/PiCbench/master/Examples/demo.nb) or [the example script](https://raw.githubusercontent.com/Dih5/PiCbench/master/Examples/demo.sh) to see how it works.

Note that a C compiler have to be set in Mathematica for these to work. In case you have installed a C compiler it is sometimes automatically detected by Mathematica, but sometimes it is not. Check out [the reference](https://reference.wolfram.com/language/CCompilerDriver/tutorial/SpecificCompilers.html).

You may still use the package without a C compiler. Replace `CompilationTarget -> "C"` by `CompilationTarget -> "WMV"`to try the demos.

## Installation
### Automatic installation

To install the PiCbench package evaluate:
```Mathematica
Get["https://raw.githubusercontent.com/dih5/PiCbench/master/BootstrapInstall.m"]
```

This method uses [MathematicaBootstrapInstaller](https://github.com/jkuczm/MathematicaBootstrapInstaller) and will also install the
[ProjectInstaller](https://github.com/lshifr/ProjectInstaller) package if you don't have it already installed.

To load the PiCbench package evaluate: ``Needs["PiCbench`"]``.


### Manual installation

1. Download latest released
   [PiCbench.zip](https://github.com/dih5/PiCbench/releases/download/v0.1.0/PiCbench.zip)
   file.

2. Extract downloaded `PiCbench.zip` to any directory which is on the Mathematica `$Path`,
   e.g. to install for the current user `FileNameJoin[{$UserBaseDirectory,"Applications"}]`,
   for all users `FileNameJoin[{$BaseDirectory,"Applications"}]`.

3. To load the package evaluate: ``Needs["PiCbench`"]``.


### No installation

To use package directly from the Web, without installation, evaluate:
```Mathematica
Get["https://raw.githubusercontent.com/dih5/PiCbench/master/PiCbench/PiCbench.m"]
```

Note that with this method of initialization
package documentation will not be available in Mathematica Documentation Center.


## Documentation

This application comes with documentation integrated with the Mathematica Documentation Center.
After installation search for "PiCbench" in documentation center
or press `F1` key with cursor on name of any of symbols introduced by this application.



## Compatibility

The package has been tested with Mathematica 9.0 and 10.X on Windows and Linux.
It will probably work in Mathematica 6.0+, but it has not been tested. If you do so, please let me know.




## License

This package is released under
[the GNU GPLv3 license](https://raw.githubusercontent.com/Dih5/PiCbench/master/LICENSE.txt).



## Versioning

Releases of this package will be numbered using
[Semantic Versioning guidelines](http://semver.org/).

## Acknowledgements

The PiC notebook from the Berkley Plasma Simulation Group found [here](http://sites.apam.columbia.edu/courses/ap1601y/) served as a motivation to try PiC simulations in Mathematica and also served as a model for the first implementation of some of the algorithms.
