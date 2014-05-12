# Low-latency localization by Active LED Markers tracking using a Dynamic Vision Sensor


This repository contains the source code 
for a Python implementation of the method
contained in the paper *Low-latency localization by Active LED Markers tracking using a Dynamic Vision Sensor*
(in the spirit of *reproducible research*).
The paper's PDF, slides, and other additional materials are found [on this webpage][webpage].

[webpage]: http://purl.org/censi/2013/dvs



## Instructions for reproducing the development environment 

The Python source code for the method is contained in the [``rcl`` repository](https://github.com/AndreaCensi/env_dvs).
Note, however, that there are a bunch of dependences  across a bunch of repositories
(on the ``env_dvs`` branch). [See here for instructions on how to setup the development environment](README-development.md).

This is the C++ implementation used in the experiments:  <https://github.com/ailab/dvs_tracking>