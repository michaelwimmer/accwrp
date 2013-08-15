Fortran wrappers for the OSX Accelerate framework.

The OSX Accelerate framework uses the g77 ABI conventions, as explained
[on the Apple developer website](http://developer.apple.com/hardwaredrivers/ve/errata.html#fortran_conventions). 
This gives problems if the Accelerate framework is linked to code
compiled with modern Fortran compilers such as gfortran.

The solution is to link a wrapper that does the necessary ABI
translations.  Unfortunately, the solution presented on the Apple
website is quite incomplete, as many more functions (other than cdotc,
cdotu, zdotc, zdotu) are affected.

accwrp is a complete wrapper containing all affected BLAS and LAPACK
functions defined in Lapack 3.2. (Note that later versions of Lapack
define additional functions, those are not implemented in Accelerate)

Compile as

    gfortran -fno-underscoring -c -O3 -shared -undefined dynamic_lookup wrapper.f -o libaccwrp.so

(the -fno-underscoring flag is vital!) and link this code before the
Accelerate framework, i.e. as

    -laccwrap -Wl,-framework -Wl,Accelerate

