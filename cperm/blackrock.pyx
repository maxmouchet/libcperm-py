# distutils: sources = vendors/blackrock/rand-blackrock.c
# distutils: include_dirs = vendors/blackrock/
from libc.stdint cimport uint64_t


cdef extern from "rand-blackrock.h":
    cdef struct BlackRock:
        pass

    void blackrock_init(BlackRock *br, uint64_t range, uint64_t seed, unsigned rounds)
    uint64_t blackrock_shuffle(const BlackRock *br, uint64_t index)


class Permutation:
    def __init__(self, range, seed, rounds):
        self.range = range
        self.seed = seed
        self.rounds = rounds

    def __iter__(self):
        return PermutationIterator(self.range, self.seed, self.rounds)

    def __len__(self):
        return self.range


cdef class PermutationIterator:
    cdef uint64_t _counter
    cdef uint64_t _range
    cdef BlackRock _perm

    def __cinit__(self, range, seed, rounds):
        self._counter = 0
        self._range = range
        blackrock_init(&self._perm, range, seed, rounds)

    def __iter__(self):
        return self

    def __next__(self):
        if self._counter >= self._range:
            raise StopIteration
        enc = blackrock_shuffle(&self._perm, self._counter)
        self._counter += 1
        return enc
