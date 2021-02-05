import blackrock
import cperm

def test_blackrock():
    perm = blackrock.Permutation(256, 0, 14)
    assert set(perm) == set(range(256))
    assert len(perm) == 256

    perm = blackrock.Permutation(256, 10, 8)
    assert set(perm) == set(range(256))
    assert len(perm) == 256


def test_cperm():
    perm = cperm.Permutation(256, "prefix", "speck", b"abcdabcd")
    assert set(perm) == set(range(256))
    assert len(perm) == 256

    perm = cperm.Permutation(256, "prefix", "rc5", b"abcdabcdabcdabcd")
    assert set(perm) == set(range(256))
    assert len(perm) == 256
