def f(x, y):
    print(y + 2*x)

f(17,8)
f("","banana")
f("na","ba")

def count_substr(s, k):
    l = len(s)
    t = set()
    result = 0
    for i in range(l - k + 1):
        if s[i:(i + k)] not in t:
            result += 1
            t.add(s[i:(i + k)])
    return result

print(count_substr("helloworld", 3))
print(count_substr("banana", 2))