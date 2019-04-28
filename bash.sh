#! /bin/bash

gfortran -c precision_module.f90 -o precision_module.o
gfortran -c constants_module.f90 -o constants_module.o
gfortran -c maths_module.f90 -o maths_module.o

gfortran precision_module.o constants_module.o maths_module.o main.f90 -o main

rm -f *.o *.mod

