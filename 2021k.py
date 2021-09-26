def sliding(a, k):
    n = len(a)
    seen = {}
    for i in range(n - k + 1):
        sum = 0
        for j in range (i, i + k):
            sum += a[j]
        if sum in seen:
            seen[sum] += 1
        else:
            seen[sum] = 1

    max_value = max(seen.values())
    max_key = min(seen.keys())

    for i in seen:
        if seen[i] == max_value and i > max_key:
            max_key = i
    print(max_key, max_value)

sliding([1, 4, 2, 3, 2, 1, 3, 4, 2], 4)
sliding([1, 4, 2, 3, 2, 1, 3, 4, 2], 3)
sliding([-1, -4, -2, -3, -2, -1, -3, -4, -2], 4)
sliding([-1, -4, -2, -3, -2, -1, -3, -4, -2], 3)