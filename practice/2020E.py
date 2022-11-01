def countsum1(a, k):
    n = len(a)
    result = 0
    for i in range(n):
        for j in range(n):
            if sum(a[i:j+1]) == k:
                result += 1
    return result

def countsum2(a, k):
    n = len(a)
    result = 0
    for i in range(n):
        sum = 0
        for j in range(i, n):
            sum += a[j]
            if sum == k:
                result += 1
    return result

def countsum3(a, k):
    seen = {0: 1}
    sum = result = 0
    for x in a:
        sum += x
        if sum - k in seen:
            result += seen[sum - k]
        if sum in seen:
            seen[sum] += 1
        else:
            seen[sum] = 1
    return result

l = [1, 3, 1, 4, 2, 3, 1, 2, 4, 3, 4, 3, 2, 2, 1, 2]
k = 4

print(countsum1(l, k),
      countsum2(l, k),
      countsum3(l, k))