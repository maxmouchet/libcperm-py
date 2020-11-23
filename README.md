# libcperm-py
![CI](https://github.com/maxmouchet/libcperm-py/workflows/CI/badge.svg)
![PyPI](https://img.shields.io/pypi/v/cperm)

Python wrapper for [libcperm](https://github.com/lancealt/libcperm).

```bash
pip install cperm
```

```python
from cperm import Permutation
perm = Permutation(256, "prefix", "speck", b"abcdabcd")
for x in perm:
    print(x)
```

### TODO

- `manylinux` wheel
