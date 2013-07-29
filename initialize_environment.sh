#!/bin/bash
set -e

# MYPYTHON=/opt/EPD-7.2-2/bin
# export PATH=$MYPYTHON:$PATH
#echo Updating current python. First installing pip.
#easy_install --upgrade pip

#echo Then installing virtualenv
#pip install --upgrade virtualenv
config=environment.sh
tag=DVS

#CURPYTHON=`which python`/..

# TODO: add in PATH the current path for python
# so other utilities can be accessed (like ptdump)
echo \#\!/bin/bash > ${config}
echo "# load this using   source ${config}" >> ${config}
# echo export PATH=${MYPYTHON}:\$PATH >> ${config}
echo export ${tag}_ROOT=`pwd` >>${config}
echo export ${tag}_PREFIX=\${${tag}_ROOT}/deploy >>${config}
echo export ${tag}_SRC=\${${tag}_ROOT}/src >>${config}
echo export ${tag}_DATA=\${${tag}_ROOT}/data >>${config}
echo export ${tag}_OUT=\${${tag}_ROOT}/results >>${config}
echo export PATH=\${${tag}_PREFIX}/bin:\$PATH >>${config}
#echo export PATH=${CURPYTHON}:\$PATH >>${config}

echo export PYTHONPATH=\${${tag}_PREFIX}/lib/python2.6/site-packages:\$PYTHONPATH >>${config}
echo export PYTHONPATH=\${${tag}_PREFIX}/lib/python2.7/site-packages:\$PYTHONPATH >>${config}
echo export PKG_CONFIG_PATH=\${${tag}_PREFIX}/lib/pkgconfig:\$PKG_CONFIG_PATH >>${config}
source ${config}
cat ${config}

echo "Now creating virtual environment (press enter)"
read
echo Create a new virtual env for python
virtualenv --system-site-packages --prompt=${tag} `pwd`/deploy
echo source $\{${tag}_PREFIX\}/bin/activate >> ${config}
source ${config}

# echo "Now installing a few python packages (press enter)"
# read


#pip install --upgrade ipython
#pip install --upgrade nose
#pip install --upgrade rudolf # nose colored output
#pip install --upgrade nose-progressive
#echo "Install patience"
#pip install -e "git+git@github.com:AndreaCensi/patience.git#egg=Patience"


