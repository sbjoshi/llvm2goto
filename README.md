# LL2GB
LL2GB is a translator from [LLVM](https://github.com/llvm/llvm-project) IR to [CProver/CBMC](https://github.com/diffblue/cbmc/)'s GOTO IR.

## Build Steps:

``` bash
    $ mkdir build
    $ cd build
    $ cmake -DCBMC_DIR=<cbmc_path> -DLLVM_CONFIG=<llvm-config> ../
    $ make
    $ ./ll2gb --help
```
## Dependencies:
    LLVM 14.x (or above)
    CBMC 5.54 (or above)

## Check

``` bash
    $ cd regression/c_regression
    $ make test
```
## Acknowledgement
An earlier version of the tool can be found in the `old` branch. We thank Rasika Sapate for her contributions in developing this earlier version.
We also thank Dr Saurabh Joshi for their valuable insignts and guidance in developing this tool.

## License
MIT License, see `LICENSE` file.
