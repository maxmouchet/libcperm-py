# distutils: sources = libcperm/src/cperm.c libcperm/src/cycle.c libcperm/src/prefix.c libcperm/src/ciphers/rc5-16.c libcperm/src/ciphers/rc5.c libcperm/src/ciphers/speck.c
# distutils: include_dirs = libcperm/src/
from libc.stdint cimport uint8_t, uint32_t


cdef extern from "cperm-internal.h":
    cdef struct cperm_t:
        pass


cdef extern from "cperm.h":
    ctypedef enum PermMode:
        PERM_MODE_ERROR = -1
        PERM_MODE_AUTO = 0
        PERM_MODE_PREFIX = 1
        PERM_MODE_CYCLE = 2
        PERM_MODE_FEISTEL = 3

    ctypedef enum PermCipher:
        PERM_CIPHER_ERROR = -1
        PERM_CIPHER_AUTO = 0
        PERM_CIPHER_RC5 = 1
        PERM_CIPHER_SPECK = 2

    cperm_t* cperm_create(uint32_t range, PermMode m, PermCipher a, uint8_t* key, int key_len)
    void cperm_destroy(cperm_t* p)
    int cperm_next(cperm_t* p, uint32_t* ct)


class Permutation:
    def __init__(self, range, mode, cipher, key):
        ciphers = {
            "auto": PermCipher.PERM_CIPHER_AUTO,
            "rc5": PermCipher.PERM_CIPHER_RC5,
            "speck": PermCipher.PERM_CIPHER_SPECK
        }

        modes = {
                "auto": PermMode.PERM_MODE_AUTO,
                "cycle": PermMode.PERM_MODE_CYCLE,
                "prefix": PermMode.PERM_MODE_PREFIX
        }

        self.range = range
        self.mode = modes[mode]
        self.cipher = ciphers[cipher]
        self.key = bytes(key)

    def __iter__(self):
        return PermutationIterator(self.range, self.mode, self.cipher, self.key)

    def __len__(self):
        return self.range


cdef class PermutationIterator:
    cdef uint32_t _counter
    cdef cperm_t* _perm

    def __cinit__(self, range, mode, cipher, key):
        self._counter = 0
        self._perm = cperm_create(range, mode, cipher, key, len(key))
        # TODO: Handle other errors.
        if self._perm is NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self._perm is not NULL:
            cperm_destroy(self._perm)

    def __iter__(self):
        return self

    def __next__(self):
        if cperm_next(self._perm, &self._counter) == -5:
            raise StopIteration
        return self._counter
