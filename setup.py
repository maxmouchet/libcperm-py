from Cython.Build import cythonize
from setuptools import Extension, setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="cperm",
    version="0.1.2",
    author="Maxime Mouchet",
    author_email="max@maxmouchet.com",
    description="Python wrapper for libcperm.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/maxmouchet/libcperm-py",
    ext_modules=cythonize([Extension("cperm", ["cperm/cperm.pyx"])]),
    classifiers=[
        "Programming Language :: Cython",
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
    ],
    python_requires=">=3.6",
)
