from cperm import Permutation


def test_basic():
    perm = Permutation(256, "prefix", "speck", b"abcdabcd")
    assert set(perm) == set(range(256))

    perm = Permutation(256, "prefix", "rc5", b"abcdabcdabcdabcd")
    assert set(perm) == set(range(256))
