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