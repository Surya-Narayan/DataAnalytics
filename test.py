for _ in range(int(input())):
    n,k = list(map(int,input().split()))
    arr = list(map(int,input().split()))
    c = 0
    s = 0
    sc = 0
    size = []
    for j in range(n):
        i = arr[j]
        if s > 0:
            size.append(c)
            sc += 1
            c = 0
            s = 0
        else:
            s += i
            c += 1
        if sc == k-1 and j<n-