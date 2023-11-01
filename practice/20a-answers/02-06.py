# 1

def has_edge_mat(m, u, v):
    return True if m[u][v] else False

def adj_mat_list(m):
    n = len(m)
    g = {}
    for i in range(n):
        s = set()
        for j in range(n):
            if m[i][j]:
                s.add(j)
        g[i] = s
    return g

def has_edge_list(g, u, v):
    return True if (v in g[u]) else False

m = [[0, 0, 1], [0, 0, 1], [1, 1, 0]]
print(adj_mat_list(m))

print(has_edge_list(adj_mat_list(m), 0, 1),
      has_edge_list(adj_mat_list(m), 0, 2),
      has_edge_list(adj_mat_list(m), 1, 0),
      has_edge_list(adj_mat_list(m), 1, 2),
      has_edge_list(adj_mat_list(m), 2, 0),
      has_edge_list(adj_mat_list(m), 2, 1))

# 2

def f(x, y):
    print(y + 2*x)

f(17,8)
f("","banana")

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

# 3

def f(a):
    l = list(a)
    s = sum(l)
    return [x / s for x in a]

def adj_list_mat(g):
    n = len(g)
    m = list()
    m = [[0] * n for i in range(n)]
    for j in range(n):
        for neighbor in g[j]:
            m[j][neighbor] = 1
    return m

def out_degree(m, u):
    return sum(m[u])

def in_degree(m, u):
    return sum(m[i][u] for i in range(len(m)))

g = [
    [1, 2],
    [0],
    [0, 1, 3],
    [0]
]

m = adj_list_mat(g)

for row in m:
    print(row)
    
print(out_degree(m, 2)) #3
print(in_degree(m, 2)) #1