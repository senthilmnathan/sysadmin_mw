Sysadmin Scripts and Packages
=============================

This repository consists of
1. CentOS/RHEL server setup scripts to setup a server for developing Python and Bash scripts
   The ``setup/server_setup/server_setup.sh`` script performs the following activities
          1. Installs advanced VIM and development packages
          2. Installs Python 3.x as a supplemental binary identified as python3.8
          3. Updates the default non-root user's bash and VIM profile to support advanced syntaxing and scripting
          4. Requires SUDO ROOT privileges
2. Python project setup scripts to stand up a development environment for coding and building python packages
   The ``setup/project_setup/code_setup.sh`` script performs the following activities
          1. Creates a home directory for the new python project
          2. Initializes the python project by creating empty, ``__init__.py`` and README.rst files
          3. Setups up tests directory for TEST DRIVEN DEVELOPMENT
          4. Installs pipenv to setup project dependencies
3. The ``exerices`` directory consists of some general use python scripts
4. The ``pgbackup`` is the project built to create a utility that can backup PostgreSQL database to a flat file or S3 Bucket


Attributes
----------

Most of the code here are part of Linux Academy course and exteded to automate the server and project setup
