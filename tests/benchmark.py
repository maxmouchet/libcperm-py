import blackrock
import cperm
import time

def bench(f, n=1):
    times = []
    for _ in range(n):
        start = time.time()
        f()
        times.append(time.time() - start)
    return min(times)

def noop(it):
    for _ in it:
        pass

def noop2(it, n):
    i = 0
    for _ in it:
        i += 1
        if i >= n:
            return

if __name__ == "__main__":
    for range_ in (256, 4096, 65536, 1048576):
        perm = blackrock.Permutation(range_, 0, 8)
        time_ = bench(lambda: noop(perm))
        print("blackrock", time_, range_ / time_)

        perm = cperm.Permutation(range_, "prefix", "rc5", b"abcdabcdabcdabcd")
        time_ = bench(lambda: noop(perm))
        print("cperm:rc5", time_, range_ / time_)

        perm = cperm.Permutation(range_, "prefix", "speck", b"abcdabcd")
        time_ = bench(lambda: noop(perm))
        print("cperm:speck", time_, range_ / time_)

    print()
    range_ = 2**32 - 1
    
    perm = blackrock.Permutation(range_, 0, 8)
    time_ = bench(lambda: noop2(perm, 2**20))
    print("blackrock", time_, 2**20 / time_)

    perm = cperm.Permutation(range_, "cycle", "rc5", b"abcdabcdabcdabcd")
    time_ = bench(lambda: noop2(perm, 2**20))
    print("cperm:rc5", time_, 2**20 / time_)

    perm = cperm.Permutation(range_, "cycle", "speck", b"abcdabcd")
    time_ = bench(lambda: noop2(perm, 2**20))
    print("cperm:speck", time_, 2**20 / time_)
