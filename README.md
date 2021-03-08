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

### Times

Times measured on a MacBook Air with an M1 CPU.  
We report the minimum time over 5 trials.

#### Prefix mode
  
BlackRock 8 rounds, Cperm in prefix mode.

Cipher      | Range   | Time (us) | Iterations/s
------------|---------|-----------|-------------
BlackRock   | 256     | 21        | 12'201'611
BlackRock   | 4096    | 355       | 11'537'857
BlackRock   | 65536   | 4462      | 14'686'787
BlackRock   | 1048576 | 70890     | 14'791'553
Cperm RC5   | 256     | 18        | 14'128'181
Cperm RC5   | 4096    | 451       | 9'080'269
Cperm RC5   | 65536   | 7455      | 8'790'748
Cperm RC5   | 1048576 | 13623     | 7'696'818
Cperm Speck | 256     | 15        | 17'043'521
Cperm Speck | 4096    | 387       | 10'578'737
Cperm Speck | 65536   | 6618      | 9'901'228
Cperm Speck | 1048576 | 12387     | 8'465'058

#### Cycle mode

BlackRock 8 rounds, Cperm in cycle mode.  
Time to iterate the first 2^20 values out of 2^32.

Cipher      | Time (us) | Iterations/s
------------|-----------|-------------
BlackRock   | 124905    | 8'394'932
Cperm RC5   | 85202     | 12'306'806
Cperm Speck | 72342     | 14'494'530
