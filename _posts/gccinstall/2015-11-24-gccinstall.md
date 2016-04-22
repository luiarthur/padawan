---
layout: post
title: Installing GCC without Root Privileges
description: Installing or updating gcc/g++ without root priviliges /sudo (on a server)
---

How do you install or update gcc/g++ without root priviliges (i.e. you can't just sudo apt-get install)? 

A good set of instructions can be found [here](https://gcc.gnu.org/wiki/InstallingGCC).
But, I'll add on a little more here. You need to
- download the gcc source
    - the source for gcc will also include the source for g++
- configure
- make
- make install

First, you need to download the source from a gcc mirror. Simply google 
*gcc source download*.  For instance, you can go
[here](http://www.netgull.com/gcc/releases/gcc-5.2.0/) and download the
`gcc-5.2.0.tar.gz` file. You are downloading the tar file which ends with
`.tar.gz`. This contains the source files for `gcc 5.2`. If you need a
different version of gcc, you can search for it.

After donwloading the source, unpack it, and `cd` into the directory where your
version of gcc was unpacked. Then, enter the following commands, replacing all
instances of `gcc-5.2.0` with your gcc version. Also, this script will install
gcc in your home directory. If you want it installed somewhere else, change
the prefix option accordingly. The `make` command could take as little as 2
hours and as much as a day, depending on your system.

~~~
tar xzf gcc-5.2.0.tar.gz
cd gcc-5.2.0
./contrib/download_prerequisites
cd ..
mkdir objdir
cd objdir
$PWD/../gcc-5.2.0/configure --prefix=$HOME/gcc-5.2.0 --enable-languages=c,c++,fortran,go
make
make install
~~~

Now gcc and g++ will be installed on your system. If you would like to use the installed
version of gcc (in this case`gcc-5.2.0` overthe preinstalled gcc, you can simply add

~~~
export PATH=~/gcc-5.2.0/bin:$PATH
export LD_LIBRARY_PATH=~/gcc-5.2.0/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=~/gcc-5.2.0/lib64:$LD_LIBRARY_PATH
~~~

to your `~/.bashrc`.

For R users, if you need a particular version of gcc to run certain packages (like
RcppArmadillo), you can do so by adding 

~~~
CXX = ~/gcc-5.2.0/bin/g++
~~~

to your `~/.R/Makevars` file (or creating the file if it does not yet exist).
