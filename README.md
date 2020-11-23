# libcperm-py

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
