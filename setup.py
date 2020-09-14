from setuptools import setup, find_packages

with open('README.rst', encoding='UTF-8') as f:
    readme = f.read()
#

setup(
        name='pgbackup',
        version='0.1.0',
        descrption='Database backups locally or to AWS S3',
        long_description='readme',
        author='Senthil Nathan Manoharan',
        author_email='Senthil.Nathanm@yahoo.com',
        packages=find_packages('src'),
        package_dir={'': 'src'},
        install_requires=[]
)
