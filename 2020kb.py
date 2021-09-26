def f(x, y):
    print(y + 2*x)

f(17,8)
f("","banana")
f("na","ba")

def count_substr(s, k):
    n = len(s)
    t = set()
    for i in range(n - k + 1):
        str = ""
        for j in range(i, i + k):
            str += s[j]
        if str not in t:
            t.add(str)
    return len(t)

print(count_substr("helloworld", 3))
print(count_substr("banana", 2))