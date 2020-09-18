#!/bin/bash
codeSetupHome="/opt/python/code_setup"
project="hr"
codeHome="/opt/python/code"
projectHome="${codeHome}/${project}"
pythonBin="python3.8"
PWD=$(pwd)
if [ -d ${projectHome} ]
then
    echo -e "Project Home, ${projectHome} already exists"
    exit 1
fi
mkdir -p ${projectHome}
cd ${projectHome}
mkdir -p src/${project} tests
touch src/${project}/__init__.py tests/.keep README.rst
echo -e "Installing PIPENV"
pip3.8 install --user pipenv
if [ $? -ne 0 ]
then
    echo -e "Error while installing PIPENV"
    exit 1
fi
echo -e "PIPENV Version\t$(pipenv --python $(which ${pythonBin}))"
echo -e "Setting Up Dependency Management"
pipenv --python ${pythonBin} install --dev pytest pytest-mock
if [ $? -ne 0 ]
then
   echo -e "Error while setting up pipenv"
   exit 1
fi
echo -e "from setuptools import setup, find_packages\n\nwith open('README.rst', encoding='UTF-8') as f:\n\treadme = f.read()\n#\nsetup(\n\tname='${project}'\n\tversion='0.1.0',\n\tdescription='Commandline utility',\n\tlong_description=readme,\n\tauthor='Senthil     Nathan Manoharan',\n\tauthor_email='Senthil.NathanM@Yahoo.Com',\n\tpackages=find_packages('src'),\n\tpackage_dir={'': 'src'},\n\tinstall_requires=[]\n)" >> ${projectHome}/setup.py

echo -e "Initializing Project, ${project} as a GIT Repository"
git init
if [ $? -ne 0 ]
then
    echo -e "Error while initializing GIT Repository"
fi
cp -p ${codeSetupHome}/gitignore ${projectHome}/.gitignore
