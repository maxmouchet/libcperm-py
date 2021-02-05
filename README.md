# libcperm-py
[![CI](https://github.com/maxmouchet/libcperm-py/workflows/CI/badge.svg)](https://github.com/maxmouchet/libcperm-py/actions)
[![PyPI](https://img.shields.io/pypi/v/cperm)](https://pypi.org/project/cperm/)

Python wrapper for [libcperm](https://github.com/lancealt/libcperm) and the BlackRock cipher from [masscan](https://github.com/robertdavidgraham/masscan).

```bash
pip install cperm
```

```python
from blackrock import Permutation
perm = Permutation(256, 0, 14)
for x in perm:
    print(x)

from cperm import Permutation
perm = Permutation(256, "prefix", "speck", b"abcdabcd")
for x in perm:
    print(x)
```
