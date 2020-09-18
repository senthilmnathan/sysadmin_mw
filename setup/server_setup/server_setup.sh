#!/bin/bash
userID="cloud_user"
pythonURL="https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz"
echo -e "Server Setup!!!!"
echo -e "Installing EPEL Repository"
yum install epel-release -y
if [ $? -ne 0 ]
then
    echo -e "EPEL Repository Installation Failed"
   exit 1
fi
echo -e "Enabling PowerTools"
dnf config-manager --set-enabled PowerTools
if [ $? -ne 0 ]
then
    echo -e "Enabling PowerTools Failed"
   exit 1
fi

echo -e "Updating Installed Packages"
yum update -y
if [ $? -ne 0 ]
then
    echo -e "Package Update Failed"
   exit 1
fi
echo -e "Installing Support Packages"
declare -a packageList=("byacc" "cscope" "ctags" "diffstat" "doxygen" "elfutils" "flex" "gcc" "gcc-c++" "gcc-gfortran" "git" "indent" "intltool" "libtool" "patchutils" "redhat-rpm-config" "rpm-build" "rpm-sign" "subversion" "swig" "systemtap" "lsof" "wget" "vim-enhanced" "words" "which")
for package in "${packageList[@]}"; do
    echo -e "Installing Package, ${package}"
    yum install -y ${package}
    if [ $? -ne 0 ]
    then
        echo -e "Failed to install package, ${package}"
        exit 1
    fi
done
echo -e "Copy VIMRC and BASHRC files"
cp -p vimrc /home/${userID}/.vimrc
cp -p bashrc /home/${userID}/.bashrc

echo -e "Installing Python"
declare -a pythonPackages=("libffi-devel" "zlib-devel" "bzip2-devel" "openssl-devel" "ncurses-devel" "sqlite-devel" "readline-devel" "tk-devel" "gdbm-devel" "libdb-devel" "libpcap-devel" "xz-devel" "expat-devel")
for package in "${pythonPackages[@]}"; do
    echo -e "Installing Python SUpport Package, ${package}"
    yum install -y ${package}
    if [ $? -ne 0 ]
    then
        echo -e "Failed to install package, ${package}"
        exit 1
    fi
done
PWD=$(pwd)
cd /usr/src/
if curl --output /dev/null --silent --head --fail "$pythonURL"; then
    wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
    tar -zxvf Python-3.8.5.tgz
    cd Python-3.8.5
    echo -e "Running Python Configure"
    sh configure --enable-optimizations
    if [ $? -ne 0 ]
    then
        echo -e "Python Configure Command Failed"
        exit 1
    fi
    echo -e "Running Python Make Command"
    make altinstall
    if [ $? -ne 0 ]
    then
        echo -e "Python Make Command Failed"
        exit 1
    fi
else
  echo "Python Source URL is invalid: $url"
    exit 1
fi
cd ${PWD}
echo -e "Modifying SUDOERS"
sed -i 's|secure_path.*|&:/usr/local/bin/|g' /etc/sudoers
if [ $? -ne 0 ]
then
    echo -e "SUDOERS File update Failed"
    exit 1
fi
echo -e "Python Installation Complete"
echo -e "Upgrading PIP 3.8"
pip3.8 install --upgrade pip
if [ $? -ne 0 ]
then
    echo -e "PIP Upgrade Failed"
    exit 1
fi
