import os.path
import setuptools

import fascia

version_info = (0, 0, 1)
__version__ = '.'.join(str(s) for s in version_info)

def read_requirements(filename):
    requirements = []
    try:
        with open(os.path.join('requires', filename)) as req_file:
            for line in req_file:
                requirements.append(line.strip())
    except IOError:
        pass
    return requirements


requirements = read_requirements('installation.txt')
tests_require = read_requirements('testing.txt')

setuptools.setup(
    name='fascia',
    version=__version__,
    author='Picwell Hackweek: Team Fascia',
    author_email='kelly@picwell.com',
    install_requires=requirements,
    packages=setuptools.find_packages(exclude=['tests', 'tests.*']),
    entry_points={
        'console_scripts': ['run-fascia=fascia.app:run']
    },
    test_suite='nose.collector',
    tests_require=tests_require,
    zip_safe=True,
)
